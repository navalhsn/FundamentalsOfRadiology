//
//  ViewController.swift
//  MFSDKDemo-Swift
//
//  Created by Elsayed Hussein on 5/19/19.
//  Copyright © 2019 Elsayed Hussein. All rights reserved.
//

import UIKit
//import MFSDK
import Alamofire

class ViewController: UIViewController {
    
}
//{
//
//    //MARK: Variables
//    var paymentMethods: [MFPaymentMethod]?
//    var selectedPaymentMethodIndex: Int?
//    let productList = NSMutableArray()
//
//    var constants = Constants()
//    var productPrice = String(),topicId = String(),topicName = String()
//
//    //MARK: Outlet
//    @IBOutlet weak var errorcodeLabel : UILabel!
//    @IBOutlet weak var payButton: UIButton!
//    @IBOutlet weak var amountTextField: UITextField!
//    @IBOutlet weak var resultTextView: UITextView!
//    @IBOutlet weak var collectionView: UICollectionView!
//    @IBOutlet var cardInfoStackViews: [UIStackView]!
//    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
//    @IBOutlet weak var cardNumberTextField: UITextField!
//    @IBOutlet weak var monthTextField: UITextField!
//    @IBOutlet weak var yearTextField: UITextField!
//    @IBOutlet weak var secureCodeTextField: UITextField!
//    @IBOutlet weak var sendPaymentButton: UIButton!
//    @IBOutlet weak var sendPaymentActivityIndicator: UIActivityIndicatorView!
//
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        payButton.isEnabled = false
//
//        productPrice = UserDefaults.standard.value(forKey: "subscribePrice") as! String
//        amountTextField.text = productPrice
//
//        setCardInfo()
//        initiatePayment()
//    }
//
//
//    // #MARK: Api functions
//
//    func paymentResult() {
//        // Activity indicator
//        activityIndicator.center =  CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2)
//        self.view.addSubview(activityIndicator)
//        activityIndicator.color = UIColor.red
//        self.activityIndicator.startAnimating()
//
//        let phone = UserDefaults.standard.value(forKey: "User_mobile")!
//
//        let params : [String : Any] = ["topic_id" : self.topicId,
//                                       "topic_name" : self.topicName,
//                                       "phone" : "\(phone)",
//                                       "amount" : productPrice]
//
//        print(params)
//
//        Alamofire.request(constants.baseUrl + "payment_result.php", method: .post , parameters:params, encoding: URLEncoding.default, headers: nil).responseJSON {
//            response in
//
//            switch(response.result) {
//
//            case .success(_):
//
//                if response.result.value != nil {
//                    self.activityIndicator.stopAnimating()
//                    let JSON = response.result.value as? NSDictionary
//                    print("success data", JSON ?? "No data")
//
//                    let alertController = UIAlertController(title: "Congratulations!", message: "You have purchased this item successfully.", preferredStyle: .alert)
//                    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
//                        UIAlertAction in
//
//                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Dashboard") as! Dashboard
//                        self.navigationController?.pushViewController(vc, animated: true)
//
//                    }
//
//                    alertController.addAction(okAction)
//                    self.present(alertController, animated: true, completion: nil)
//
//                }
//                break
//            case .failure(_):
//                self.activityIndicator.stopAnimating()
//                break
//
//            }
//        }
//    }
//
//
//
//    @IBAction func payDidPRessed(_ sender: Any) {
//        if let paymentMethods = paymentMethods, !paymentMethods.isEmpty {
//            if let selectedIndex = selectedPaymentMethodIndex {
//                if paymentMethods[selectedIndex].isDirectPayment {
//                    executeDirectPayment(paymentMethodId: paymentMethods[selectedIndex].paymentMethodId)
//                } else {
//                    executePayment(paymentMethodId: paymentMethods[selectedIndex].paymentMethodId)
//                }
//            }
//        }
//
//        //paymentResult()
//    }
//
//    @IBAction func backAction(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
//    }
//
//
//    @IBAction func sendPaymentDidTapped(_ sender: Any) {
//        sendPayment()
//    }
//}

//extension ViewController  {
//    func startSendPaymentLoading() {
//        errorcodeLabel.text = "Status:"
//        resultTextView.text = "Result:"
//        sendPaymentButton.setTitle("", for: .normal)
//        sendPaymentActivityIndicator.startAnimating()
//    }
//    func stopSendPaymentLoading() {
//        sendPaymentButton.setTitle("Send Payment", for: .normal)
//        sendPaymentActivityIndicator.stopAnimating()
//    }
//    func startLoading() {
//        errorcodeLabel.text = "Status:"
//        resultTextView.text = "Result:"
//        payButton.setTitle("", for: .normal)
//        activityIndicator.startAnimating()
//    }
//    func stopLoading() {
//        payButton.setTitle("Pay", for: .normal)
//        activityIndicator.stopAnimating()
//    }
//    func showSuccess(_ message: String) {
//        errorcodeLabel.text = "Succes"
//        resultTextView.text = "result: \(message)"
//
//        paymentResult()
//
//    }
//
//    func showFailError(_ error: MFFailResponse) {
//        errorcodeLabel.text = "responseCode: \(error.statusCode)"
//        resultTextView.text = "Error: \(error.errorDescription)"
//    }
//}

//extension ViewController {
//    func hideCardInfoStacksView(isHidden: Bool) {
//        for stackView in cardInfoStackViews {
//            stackView.isHidden = isHidden
//        }
//    }
//    private func setCardInfo() {
//        cardNumberTextField.text = "5123450000000008"
//        monthTextField.text = "05"
//        yearTextField.text = "21"
//        secureCodeTextField.text = "100"
//    }
//}

