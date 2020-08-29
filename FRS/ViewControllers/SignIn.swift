//
//  SignIn.swift
//  FRS
//
//  Created by Naval Hasan on 19/01/19.
//  Copyright © 2019 fragmentree. All rights reserved.
//

import UIKit
import Alamofire
import FirebaseAuth
// import FacebookLogin
// import FBSDKLoginKit
import CountryPicker
import AuthenticationServices

class SignIn: UIViewController, UITextFieldDelegate, CountryPickerDelegate {
    
    // #MARK: Outlets
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var countryCode: UITextField!
    @IBOutlet weak var picker: CountryPicker!
    
    // #MARK: Declarations
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
    var dict : [String : AnyObject]!, fbDict = NSDictionary()
    let constants = Constants()
    
    var appleLogInButton : ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton()
        button.addTarget(self, action: #selector(handleLogInWithAppleID), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
//        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
//        loginButton.center = view.center
//
//        view.addSubview(loginButton)
        
//        let appleLogButton = appleLogInButton
//        appleLogButton.center = view.center
//        view.addSubview(appleLogButton)
        
        picker.isHidden = true
        let locale = Locale.current
        let code = (locale as NSLocale).object(forKey: NSLocale.Key.countryCode) as! String?
        //init Picker
       // picker.displayOnlyCountriesWithCodes = ["DK", "SE", "NO", "DE"] //display only
      //  picker.exeptCountriesWithCodes = ["RU"] //exept country
        let theme = CountryViewTheme(countryCodeTextColor: .white, countryNameTextColor: .white, rowBackgroundColor: .black, showFlagsBorder: false)
        picker.theme = theme
        picker.countryPickerDelegate = self
        picker.showPhoneNumbers = true
        picker.setCountry(code!)

        addDoneButtonOnKeyboard()
        
        
        
    }
    
   
    
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        mobile.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction(){
        mobile.resignFirstResponder()
        picker.isHidden = true
    }
    
    
    
    // #MARK : Apple login button
    
    @objc func handleLogInWithAppleID() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        
        controller.delegate = self
        controller.presentationContextProvider = self
        
        controller.performRequests()
    }
    
    
    // #MARK: Country code functions
    
    func countryPhoneCodePicker(_ picker: CountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
        //pick up anythink
        self.countryCode.text = phoneCode
    }
    
    
    // #MARK: TextField functions
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == countryCode{
            textField.resignFirstResponder()
            picker.isHidden = false
       //     countryPickerView.showCountriesList(from: self)
        }

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == countryCode{
            picker.isHidden = true
        }

    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField .isEqual(mobile) {
            let mobileNum = mobile.text?.count
            
            if mobileNum! >= 14 && range.length == 0 {
                return false
            }
        }   
        else if textField .isEqual(countryCode) {
            let country = countryCode.text?.count
            
            if country! >= 5 && range.length == 0 {
                return false
            }
        }
        
        
        return true
        
    }
    
    


    
    
    // #MARK: Facebook login

//    func getFBUserData(){
//        if((FBSDKAccessToken.current()) != nil){
//            //, picture.type(large) --> removed
//            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, email"]).start(completionHandler: { (connection, result, error) -> Void in
//                if (error == nil){
//                    self.dict = result as? [String : AnyObject]
//                //    print(result!)
//                //    print(self.dict)
//                    
//                    let name = self.dict["name"]
//                    print(name!)
//                    UserDefaults.standard.set(name, forKey: "User_name")
//                    self.fbDict = result as! NSDictionary
//                    
//                      print(self.fbDict.count)
//                    
//                    if self.fbDict.count == 2{
//                        self.AlertWithText()
//                    }
//                    else{
//                     //   self.fbEmailHolder = String(describing: self.fbDict.value(forKey: "email")!)
//                      ///  self.facebookLogin()
//                    }
//                    
//                }
//            })
//        }
//        else{
//            //    print("no data found")
//        }
//    }
    

    
    func AlertWithText() {
        
        let alert = UIAlertController(title: "Almost there", message: "Your Mobile Number privacy was not public.So we were not able to fetch your Mobile Number. please provide it here.", preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Done", style: .default) { (alertAction) in
            let mob = (alert.textFields![0] as UITextField).text!
            
            UserDefaults.standard.set(mob, forKey: "User_mobile")
            UserDefaults.standard.set(true, forKey : "isUserRegistered")
            UserDefaults.standard.set(true, forKey: "loginStatus")
            // go to dash
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Dashboard") as! Dashboard
            //vc.phone = self.mobileNumber
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (alertAction) in
            self.mobile = alert.textFields![0] as UITextField
            
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Enter your mobile"
            textField.keyboardType = .numberPad
            textField.reloadInputViews()
        }
        alert.addAction(action)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // #MARK: Actions
    
    @IBAction func signInAction(_ sender: Any) {
        
        if countryCode.text?.count ?? 0 < 6 && countryCode.text?.count ?? 0 > 1{
            if mobile.text?.count ?? 0 < 15 && mobile.text?.count ?? 0 > 5{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "OTP") as! OTP
                vc.mobileNumber = self.mobile.text!
                vc.countryCode = self.countryCode.text!
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else{
                let alert = UIAlertController(title: nil, message: "Please enter a valid mobile number", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        else{
            let alert = UIAlertController(title: nil, message: "Invalid country code", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
    
    @IBAction func facebookSignInAction(_ sender: Any) {
        
//        let loginManager = LoginManager()
//        //  self.getFBUserData()
//
//        loginManager.logIn(readPermissions: [ .publicProfile ], viewController: self) { loginResult in
//            switch loginResult {
//            case .failed(let error):
//                print(error)
//            case .cancelled:
//                print("User cancelled login.")
//            case .success(_, _, _):
//                self.getFBUserData()
//            }
//        }
    }
    
}


extension SignIn: ASAuthorizationControllerDelegate {
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    switch authorization.credential {
    case let appleIDCredential as ASAuthorizationAppleIDCredential:
        let userIdentifier = appleIDCredential.user
    
        let defaults = UserDefaults.standard
        defaults.set(userIdentifier, forKey: "userIdentifier1")
        print(userIdentifier)
        //Save the UserIdentifier somewhere in your server/database
        
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OTP") as! OTP
        vc.mobileNumber = self.mobile.text!
        vc.countryCode = self.countryCode.text!
        self.navigationController?.pushViewController(vc, animated: true)
        
        break
    default:
        break
    }
}
}

extension SignIn: ASAuthorizationControllerPresentationContextProviding {
    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
           return self.view.window!
    }
}
