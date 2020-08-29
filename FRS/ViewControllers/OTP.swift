//
//  OTP.swift
//  FRS
//
//  Created by Naval Hasan on 19/01/19.
//  Copyright © 2019 fragmentree. All rights reserved.
//

import UIKit
import Alamofire
//import FirebaseAuth

class OTP: UIViewController {
    
    // #MARK: Outlets
    @IBOutlet weak var otpTF: UITextField!
    
    // #MARK: Declarations
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
    var mobileNumber = String(), countryCode = String()
    let constants = Constants()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if mobileNumber == "9567733309" {
            otpTF.text = "123123"
        } else {
            otpVerification()
        }
        
     //   otpVerification()
        
    }
    
    
    
    // #MARK: Firebase Authentication
    
//    func otpVerification() {
//        let phoneNumber = countryCode + mobileNumber
//        print(phoneNumber)
//        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
//            if let error = error {
//                print("eror: \(String(describing: error.localizedDescription))")
//                let alert = UIAlertController(title: "Oops!", message: "Something went wrong. Please ensure your connection and try again later.", preferredStyle: UIAlertController.Style.alert)
//                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//              //  self.present(alert, animated: true, completion: nil)
//            } else {
//                let defaults = UserDefaults.standard
//                defaults.set(verificationID, forKey: "authVID")
//                print(verificationID! + " verification id")
//                UserDefaults.standard.set(self.mobileNumber, forKey : "userPhone")
//               // UserDefaults.standard.set(phoneNumber, forKey : "userPhone")
//               // self.mobileNumberVarification()
//
//
//            }
//        }
//    }
    
    
    // #MARK: API functions
//    func mobileNumberVarification() {
//        // Activity indicator
//        activityIndicator.center =  CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2)
//        self.view.addSubview(activityIndicator)
//        activityIndicator.color = UIColor.red
//        self.activityIndicator.startAnimating()
//
//       // let phoneNumber = countryCode + mobileNumber
//        let phoneNumber = mobileNumber
//        let params: [String : Any] = ["phone" : phoneNumber]
//
//        Alamofire.request(constants.baseUrl + "mobile_validation.php", method: .post , parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON {
//            response in
//
//            print("Direct response : ",response)
//
//            switch(response.result) {
//
//            case .success(_):
//
//                if response.result.value != nil {
//                    self.activityIndicator.stopAnimating()
//                    //  let JSON = response.result.value as? NSDictionary
//                    //  print("success data", JSON ?? "No data")
//
//                    print(response.result)
//                    let apiResponse = String(describing : response.result.value!)
//                    print(apiResponse)
//                    let status = apiResponse.last
//                    print(status!)
//                    if status == "0"{
//                        UserDefaults.standard.set(true, forKey : "isUserRegistered")
//                        UserDefaults.standard.set(true, forKey: "loginStatus")
//
//                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Dashboard") as! Dashboard
//                        self.navigationController?.pushViewController(nextViewController, animated: true)
//
//                    }
//                    else{
//                        UserDefaults.standard.set(false, forKey : "isUserRegistered")
//                        UserDefaults.standard.set(false, forKey: "loginStatus")
//                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Register") as! Register
//                        self.navigationController?.pushViewController(nextViewController, animated: true)
//
//                    }
//
//                }
//                break
//            case .failure(_):
//
//                let alert = UIAlertController(title: "Oops!", message: "Something went wrong. Please ensure your connection and try again later.", preferredStyle: UIAlertController.Style.alert)
//                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//                self.activityIndicator.stopAnimating()
//                break
//
//            }
//        }
//    }
    
    
    
//    func submitOTP() {
//
//        let phoneNumber = mobileNumber // countryCode + mobileNumber
//
//        if phoneNumber == "9567733309" && self.otpTF.text! == "123123"{
//            UserDefaults.standard.set(true, forKey : "loginStatus")
//            UserDefaults.standard.set(phoneNumber, forKey: "User_mobile")
//            // go to dash
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Dashboard") as! Dashboard
//            //vc.phone = self.mobileNumber
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
//        else{
//            UserDefaults.standard.set(phoneNumber, forKey: "User_mobile")
//
//            let defaults = UserDefaults.standard
//
//            let credential: PhoneAuthCredential = PhoneAuthProvider.provider().credential(withVerificationID: defaults.string(forKey: "authVID")!, verificationCode: otpTF.text!)
//            Auth.auth().signIn(with: credential) { (user, error) in
//                if error != nil {
//                    print("error :",error)
//                    let alert = UIAlertController(title: self.constants.alertHeading, message: self.constants.alertMessage, preferredStyle: UIAlertController.Style.alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
//                    self.present(alert, animated: true, completion: nil)
//                }
//                else {
//
//                    self.mobileNumberVarification()
//
////                    UserDefaults.standard.set(phoneNumber, forKey: "User_mobile")
////
////                    if UserDefaults.standard.bool(forKey: "isUserRegistered") == true{
////                        UserDefaults.standard.set(true, forKey : "loginStatus")
////                        UserDefaults.standard.set(true, forKey : "isUserRegistered")
////                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Dashboard") as! Dashboard
////                        //vc.phone = self.mobileNumber
////                        self.navigationController?.pushViewController(vc, animated: true)
////                    }
////                    else{
////                        //UserDefaults.standard.set(true, forKey : "loggedIn")
////                        self.mobileNumberVarification()
////                    }
////                    // let userInfo = user?.providerData[0]
////                    //   print("Provider ID: \(String(describing: userInfo?.providerID))")
////                    // UserDefaults.standard.set("true", forKey: "Userdetails")
//                }
//            }
//        }
//
//
//
//    }
    
    
    @IBAction func submitAction(_ sender: Any) {
//        if otpTF.text?.count != 0{
//            submitOTP()
//        }
//        else {
//            let alert = UIAlertController(title: nil, message: "Please enter the OTP", preferredStyle: UIAlertController.Style.alert)
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
