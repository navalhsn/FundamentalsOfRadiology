//
//  Register.swift
//  FRS
//
//  Created by Naval Hasan on 05/05/19.
//  Copyright © 2019 infomatix. All rights reserved.
//

import UIKit
import Alamofire

class Register: UIViewController, UITextFieldDelegate {

    // #MARK: Outlets
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var number: UITextField!
    
    // #MARK: Declarations
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
    var mobileNumber = String(), countryCode = String()
    let constants = Constants()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.name.delegate = self
        self.number.delegate = self
        
       
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    // #MARK: API functions
    func mobileNumberVarification() {
        // Activity indicator
        activityIndicator.center =  CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2)
        self.view.addSubview(activityIndicator)
        activityIndicator.color = UIColor.red
        self.activityIndicator.startAnimating()
        
        let phoneNumber = "+" + countryCode + mobileNumber
        let params: [String : Any] = ["phone" : phoneNumber, "name" : name.text!]
        
        Alamofire.request(constants.baseUrl + "insert_user_data.php", method: .post , parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON {
            response in
            
            print("Direct response : ",response)
            
            switch(response.result) {
                
            case .success(_):
                
                if response.result.value != nil {
                    self.activityIndicator.stopAnimating()
                    //  let JSON = response.result.value as? NSDictionary
                    //  print("success data", JSON ?? "No data")
                    
                    print(response.result)
                    let apiResponse = String(describing : response.result.value!)
                    print(apiResponse)
                    let status = apiResponse.last
                    print(status!)
                    if status == "0"{
                        UserDefaults.standard.set(true, forKey : "isUserRegistered")
                        UserDefaults.standard.set(true, forKey: "loginStatus")
                        UserDefaults.standard.set(self.name, forKey: "User_name")
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Dashboard") as! Dashboard
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                        
                    }
                    else{
                        UserDefaults.standard.set(false, forKey : "isUserRegistered")
                        UserDefaults.standard.set(false, forKey: "loginStatus")
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Register") as! Register
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                        
                    }
                    
                }
                break
            case .failure(_):
                self.activityIndicator.stopAnimating()
                break
                
            }
        }
    }
    
    
    
    @IBAction func submitAction(_ sender: Any) {
        if name.text?.count != 0 && number.text?.count != 0{
            UserDefaults.standard.set(true, forKey: "loginStatus")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Dashboard") as! Dashboard
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            let alert = UIAlertController(title: nil, message: "All fields are mandatory.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

}
