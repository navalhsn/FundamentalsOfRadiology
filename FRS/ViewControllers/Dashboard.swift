//
//  Dashboard.swift
//  FRS
//
//  Created by Naval Hasan on 19/01/19.
//  Copyright © 2019 fragmentree. All rights reserved.
//

import UIKit
import Alamofire

class Dashboard: UIViewController, UITableViewDataSource, UITableViewDelegate {
   

    // Outlets
    @IBOutlet weak var tabView: UITableView!
    
    // Declarations
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
    var catNameArr = [String](), catIdArr = [String]()
    let constants = Constants()
    var feedback = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        getCategories()
      //  tabView.backgroundView?.backgroundColor = UIColor.white
        tabView.isOpaque = false
        tabView.backgroundColor = UIColor.white
        tabView.backgroundView  = nil
    }
    
    
    // #MARK: tableView functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catNameArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabView.dequeueReusableCell(withIdentifier: "CategoriesTabCell") as! CategoriesTabCell
        cell.name.text = String(describing: catNameArr[indexPath.row])
        
        if indexPath.row % 3 == 0 {
            cell.bg.image = UIImage(named : "greenBg")
        }
        else if indexPath.row % 2 == 0 {
            cell.bg.image = UIImage(named : "meroonBg")
        }
        else{
            cell.bg.image = UIImage(named : "blueBg")
        }

        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Topics") as! Topics
        nextViewController.catId = String(describing: self.catIdArr[indexPath.row])
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    
    // #MARK: API functions
    func getCategories() {
        // Activity indicator
        activityIndicator.center =  CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2)
        self.view.addSubview(activityIndicator)
        activityIndicator.color = UIColor.red
        self.activityIndicator.startAnimating()
        
        UserDefaults.standard.set("9567733309", forKey : "User_mobile")
        let phone = UserDefaults.standard.string(forKey: "User_mobile")!
        let params : [String : Any] = ["phone" : phone]
        print(params)
        Alamofire.request(constants.baseUrl + "category_list.php", method: .post , parameters:params, encoding: URLEncoding.default, headers: nil).responseJSON {
            response in
            
            print("Direct response : ",response)
            
            switch(response.result) {
                
            case .success(_):
                
                if response.result.value != nil {
                    self.activityIndicator.stopAnimating()
                    let JSON = response.result.value as? NSDictionary
                    print("success data", JSON ?? "No data")

                    let data = JSON?.value(forKey: "data") as! NSArray
                    let catArr = data.value(forKey: "cat_name") as! NSArray

                    var holder = String()
                    for i in catArr {
                        holder = String(describing: i).replacingOccurrences(of: "(\n    ", with: "")
                        holder = holder.replacingOccurrences(of: "\n)", with: "")
                        self.catNameArr.append(holder)
                    }
                    
                    let catId = data.value(forKey: "cat_id") as! NSArray
                    
                    for i in catId {
                        holder = String(describing: i).replacingOccurrences(of: "(\n    ", with: "")
                        holder = holder.replacingOccurrences(of: "\n)", with: "")
                        self.catIdArr.append(holder)
                    }
                    
   
                    
                    let subscribePrice = String(describing: (JSON?.value(forKey: "price") as! NSArray)[0])
                    let subscribeStatus = String(describing: (JSON?.value(forKey: "subscribe") as! NSArray)[0])
                    
                    if subscribeStatus == "0" {
                        UserDefaults.standard.set(false, forKey: "subscribeStatus")
                    }
                    else{
                        UserDefaults.standard.set(true, forKey: "subscribeStatus")
                    }
                    
                    UserDefaults.standard.set(subscribePrice, forKey: "subscribePrice")
                    
                    self.tabView.reloadData()
                }
                break
            case .failure(_):
                self.activityIndicator.stopAnimating()
                break
                
            }
        }
    }
    
    func postFeedback() {
        // Activity indicator
        activityIndicator.center =  CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2)
        self.view.addSubview(activityIndicator)
        activityIndicator.color = UIColor.red
        self.activityIndicator.startAnimating()
        
        let phone = UserDefaults.standard.string(forKey: "User_mobile")!
        let name = UserDefaults.standard.string(forKey: "User_name") ?? "user"
        
        let params : [String : Any] = ["phone" : phone,
                                       "name" : name,
                                       "message" : self.feedback]
        print(params)
        Alamofire.request(constants.baseUrl + "insert_feedback.php", method: .post , parameters:params, encoding: URLEncoding.default, headers: nil).responseJSON {
            response in
            
            print("Direct response : ",response)
            
            switch(response.result) {
                
            case .success(_):
                
                if response.result.value != nil {
                    self.activityIndicator.stopAnimating()
                    let JSON = response.result.value as? NSDictionary
                    print("success data", JSON ?? "No data")
                    
                }
                break
            case .failure(_):
                self.activityIndicator.stopAnimating()
                break
                
            }
        }
    }
    
    
    func AlertWithText() {
        
        let alert = UIAlertController(title: "We love to hear from you!", message: "Please share your valuable feedback here. We appreciate it.", preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Done", style: .default) { (alertAction) in
            self.feedback = (alert.textFields![0] as UITextField).text ?? " "
            print("feed : ", self.feedback)
            self.postFeedback()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (alertAction) in
            
            
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Enter your feedback"
            self.feedback = textField.text ?? " "
        }
        alert.addAction(action)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func menuAction(_ sender: Any) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            
            // Cancel button tappped.
            self.dismiss(animated: true) {
            }
        }))

        actionSheet.addAction(UIAlertAction(title: "Share", style: .default, handler: { action in
            

                UIGraphicsBeginImageContext(self.view.frame.size)
                self.view.layer.render(in: UIGraphicsGetCurrentContext()!)
                let image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                let textToShare = "Check out my app"
                
                if let myWebsite = URL(string: "http://itunes.apple.com/app/idXXXXXXXXX") {//Enter link to your app here
                    let objectsToShare = [textToShare, myWebsite, image ?? #imageLiteral(resourceName: "app-logo")] as [Any]
                    let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                    
                    //Excluded Activities
                    activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
                    //
                    
                    activityVC.popoverPresentationController?.sourceView = sender as? UIView
                    self.present(activityVC, animated: true, completion: nil)
                }
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Feedback", style: .default, handler: { action in
            
            self.AlertWithText()
        }))
        
//        actionSheet.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { action in
//
//
//            let alertController = UIAlertController(title: nil, message: "Are you sure you want to logout?", preferredStyle: .alert)
//
//            // Create the actions
//            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
//                UIAlertAction in
//
//                UserDefaults.standard.set(false, forKey: "loginStatus")
//                UserDefaults.standard.set(nil, forKey: "User_mobile")
//                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignIn") as! SignIn
//                //vc.phone = self.mobileNumber
//                self.navigationController?.pushViewController(vc, animated: false)
//            }
//            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
//                UIAlertAction in
//                NSLog("Cancel Pressed")
//            }
//
//            // Add the actions
//            alertController.addAction(okAction)
//            alertController.addAction(cancelAction)
//
//            // Present the controller
//          //  self.present(alertController, animated: true, completion: nil)
//
//            alertController.popoverPresentationController?.sourceView = self.view // works for both iPhone & iPad
//
//            self.present(alertController, animated: true) {
//                print("option menu presented")
//            }
//
//
//        }))
        // Present action sheet.
        // present(actionSheet, animated: true)
        
       // actionSheet.popoverPresentationController?.sourceView = self.view // works for both iPhone & iPad

        
        if let popoverController = actionSheet.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        self.present(actionSheet, animated: true) {
            print("option menu presented")
        }
    }
    

}
