//
//  Topics.swift
//  FRS
//
//  Created by Naval Hasan on 19/01/19.
//  Copyright © 2019 fragmentree. All rights reserved.
//

import UIKit
import Alamofire
import StoreKit

class Topics: UIViewController, UITableViewDataSource, UITableViewDelegate{

    // #MARK: Outlets
    @IBOutlet weak var tabView: UITableView!
    
    // #MARK: Declaration
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
    var name = NSArray(), price = NSArray(), topicId = [String](), catId = String(), payFlag = NSArray()
    let constants = Constants()
    
    // SK
    var productsRequest = SKProductsRequest()
    var validProducts = [SKProduct]()
    var productIndex = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabView.isOpaque = false
        tabView.backgroundColor = UIColor.white
        tabView.backgroundView  = nil
        
        getTopics()
        fetchAvailableProducts()
    }
    
    
    
    // #MARK: TableView functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopicsTabCell") as! TopicsTabCell
        cell.name.text = String(describing: name[indexPath.row])
        cell.lab.layer.cornerRadius = cell.lab.bounds.height / 2
        cell.lab.clipsToBounds = true
        if String(describing: price[indexPath.row]) == "0"{
            cell.price.text = "Free"
        } else {
            cell.price.text = "Paid"
        }
        
        
        cell.bgView.layer.shadowColor = UIColor.gray.cgColor
        cell.bgView.layer.shadowOpacity = 0.3
        cell.bgView.layer.shadowOffset = CGSize.zero
        cell.bgView.layer.shadowRadius = 6
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if String(describing: price[indexPath.row]) == "0" {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Files") as! Files
            nextViewController.topicId = String(describing: self.topicId[indexPath.row])
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
        else{

            print(UserDefaults.standard.bool(forKey: "subscribeStatus"))
            
            if UserDefaults.standard.bool(forKey: "subscribeStatus") {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Files") as! Files
                nextViewController.topicId = String(describing: self.topicId[indexPath.row])
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
            else{
                
                let alertController = UIAlertController(title: nil, message: "This file is not free. You can purchase the app to get access of all the files. Would you like to purchase the App?", preferredStyle: .alert)
                
                
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    
                    if self.validProducts.count != 0 {
                        self.purchaseMyProduct(self.validProducts[0])
                    }
                    
                    
//                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
//                  //  nextViewController.productPrice = (String(describing: self.price[indexPath.row]))
//                    nextViewController.topicId = (String(describing: self.topicId[indexPath.row]))
//                    nextViewController.topicName = (String(describing: self.name[indexPath.row]))
//                    self.navigationController?.pushViewController(nextViewController, animated: true)
                    
                }
                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                    UIAlertAction in
                    NSLog("Cancel Pressed")
                }
                
                alertController.addAction(okAction)
                alertController.addAction(cancelAction)
                
                self.present(alertController, animated: true, completion: nil)
 
            }
            


        }
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    // #MARK: API functions
    func getTopics() {
        // Activity indicator
        activityIndicator.center =  CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2)
        self.view.addSubview(activityIndicator)
        activityIndicator.color = UIColor.red
        self.activityIndicator.startAnimating()
        
        let phone = UserDefaults.standard.string(forKey: "User_mobile")!
        let params : [String : Any] = ["cat_id" : self.catId , "phone" : phone]
        
        Alamofire.request(constants.baseUrl + "topic_list.php", method: .post , parameters:params, encoding: URLEncoding.default, headers: nil).responseJSON {
            response in
            
            print("Direct response : ",response)
            
            switch(response.result) {
                
            case .success(_):
                
                if response.result.value != nil {
                    self.activityIndicator.stopAnimating()
                    let JSON = response.result.value as? NSDictionary
                    print("success data", JSON ?? "No data")
                    
                    if JSON?.count ?? 0 > 0 {
                        let data = JSON?.value(forKey: "data") as! NSArray
                        self.name = data.value(forKey: "top_name") as! NSArray
                        self.price = data.value(forKey: "top_price") as! NSArray
                        let topicId = data.value(forKey: "top_id") as! NSArray
                        self.payFlag = data.value(forKey: "pay_flag") as! NSArray
                        
                        var holder = String()
                        for i in topicId {
                            holder = String(describing: i).replacingOccurrences(of: "(\n    ", with: "")
                            holder = holder.replacingOccurrences(of: "\n)", with: "")
                            self.topicId.append(holder)
                        }
    
                        self.tabView.reloadData()
                    }

                }
                break
            case .failure(_):
                self.activityIndicator.stopAnimating()
                break
                
            }
        }
    }
 
 // #MARK: Actions
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}



extension Topics : SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    func fetchAvailableProducts()  {
        let productIdentifiers = NSSet(objects:
            "com.radio.app123",         // 0
            "120021"  // 1
        )
        productsRequest = SKProductsRequest(productIdentifiers: productIdentifiers as! Set<String>)
        productsRequest.delegate = self
        productsRequest.start()
    }
    
    func productsRequest (_ request:SKProductsRequest, didReceive response:SKProductsResponse) {
        if (response.products.count > 0) {
            validProducts = response.products
            
            // 1st IAP Product
            let prod100coins = response.products[0] as SKProduct
            let prodUnlockPro = response.products[1] as SKProduct
            print("1st rpoduct: " + prod100coins.localizedDescription)
            print("2nd product: " + prodUnlockPro.localizedDescription)
            
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, shouldAddStorePayment payment: SKPayment, for product: SKProduct) -> Bool {
        return true
    }
    
    
    func canMakePurchases() -> Bool {  return SKPaymentQueue.canMakePayments()  }
    
    
    func purchaseMyProduct(_ product: SKProduct) {
        if self.canMakePurchases() {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().add(payment)
        } else { print("Purchases are disabled in your device!") }
    }
    
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction:AnyObject in transactions {
            if let trans:SKPaymentTransaction = transaction as? SKPaymentTransaction {
                switch trans.transactionState {
                    
                case .purchased:
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    if productIndex == 0 {
                        print("You've bought 100 coins!")
                      //  buy100coinsButton.setTitle("Buy another 100 Coins Chest", for: .normal)
                    } else {
                        print("You've unlocked the Pro version!")
//                        unlockProButton.isEnabled = false
//                        unlockProButton.setTitle("PRO version purchased", for: .normal)
                    }
                    break
                    
                case .failed:
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    print("Payment has failed.")
                    break
                case .restored:
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    print("Purchase has been successfully restored!")
                    break
                    
                default: break
        }}}
    }
    
    
    
    func restorePurchase() {
        SKPaymentQueue.default().add(self as SKPaymentTransactionObserver)
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        print("The Payment was successfull!")
    }
    
    
    
    
}
