//
//  Categories.swift
//  FRS
//
//  Created by Naval Hasan on 19/01/19.
//  Copyright © 2019 fragmentree. All rights reserved.
//

import UIKit
import Alamofire

class Categories: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Outlets
    @IBOutlet weak var tabView: UITableView!
    
    // Declarations
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
    var catNameArr = [String](), catIdArr = NSArray()
    var phone = String()
    var constants = Constants()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    

    // #MARK: tableView functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catNameArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabView.dequeueReusableCell(withIdentifier: "CategoriesTabCell") as! CategoriesTabCell
        cell.textLabel?.text = String(describing: catNameArr[indexPath.row])
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor(red: 140/255.0, green: 137/255.0, blue: 87/255.0, alpha: 1.0)
        }
        else{
            cell.backgroundColor = UIColor(red: 48/255.0, green: 126/255.0, blue: 100/255.0, alpha: 1.0)
        }
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    // #MARK: API functions
    func getCategories() {
        // Activity indicator
        activityIndicator.center =  CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2)
        self.view.addSubview(activityIndicator)
        activityIndicator.color = UIColor.red
        self.activityIndicator.startAnimating()
        
        let params : [String : Any] = ["phone" : self.phone]
        
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
                    
                    self.catIdArr = data.value(forKey: "cat_id") as! NSArray
                    
                    
                    self.tabView.reloadData()
                }
                break
            case .failure(_):
                self.activityIndicator.stopAnimating()
                break
                
            }
        }
    }
    
    
}
