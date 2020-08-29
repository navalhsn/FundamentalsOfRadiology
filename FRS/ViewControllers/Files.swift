//
//  Files.swift
//  FRS
//
//  Created by Naval Hasan on 19/01/19.
//  Copyright © 2019 fragmentree. All rights reserved.
//

import UIKit
import Alamofire
import AVKit
import AVFoundation

class Files: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    // Outlets
    @IBOutlet weak var tabView: UITableView!
    
    // Declaration
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
    var name = [String](), price = NSArray(), filesId = NSArray(), topicId = String(), type = [String](), url = [String]()
    let constants = Constants()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabView.isOpaque = false
        tabView.backgroundColor = UIColor.white
        tabView.backgroundView  = nil
        
        getFiles()
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesTabCell") as! CategoriesTabCell
        
        cell.name.text = String(describing: name[indexPath.row])
        
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
        
        if type[indexPath.row] == "image" {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ImageViewer") as! ImageViewer
            nextViewController.imageUrl = String(describing: self.url[indexPath.row])
            nextViewController.name = String(describing: self.name[indexPath.row])
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
        else if type[indexPath.row] == "video" {
            
            let urlString = (self.url[indexPath.row]).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            
            let videoURL = URL(string: urlString!)
            let player = AVPlayer(url: videoURL!)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
        }
        else if type[indexPath.row] == "application" {
            
//            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PDFViewer") as! PDFViewer
//            nextViewController.pdfUrl = String(describing: self.url[indexPath.row])
//            nextViewController.name = String(describing: self.name[indexPath.row])
//            self.navigationController?.pushViewController(nextViewController, animated: true)
            
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PDFViewController") as! PDFViewController
            nextViewController.pdfUrl = String(describing: self.url[indexPath.row])
            nextViewController.name = String(describing: self.name[indexPath.row])
            self.navigationController?.pushViewController(nextViewController, animated: true)
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    // #MARK: API functions
    func getFiles() {
        // Activity indicator
        activityIndicator.center =  CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2)
        self.view.addSubview(activityIndicator)
        activityIndicator.color = UIColor.red
        self.activityIndicator.startAnimating()
        
        let params : [String : Any] = ["topic_id" : self.topicId]
        
        Alamofire.request(constants.baseUrl + "file_list.php", method: .post , parameters:params, encoding: URLEncoding.default, headers: nil).responseJSON {
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
                        let nameArr = data.value(forKey: "fi_name") as! NSArray
                        let typeArr = data.value(forKey: "fi_type") as! NSArray
                        let urlArr = data.value(forKey: "fi_url") as! NSArray
                        self.price = data.value(forKey: "top_price") as! NSArray
                        self.filesId = data.value(forKey: "top_id") as! NSArray
                        
                        var holder = String()
                        for i in nameArr {
                            print(i)
                            holder = String(describing: i).replacingOccurrences(of: "(\n    ", with: "")
                            holder = holder.replacingOccurrences(of: "\n)", with: "")
                            holder = holder.replacingOccurrences(of: "\"", with: "")
                            self.name.append(holder)
                        }
                        
                        for i in typeArr {
                            holder = String(describing: i).replacingOccurrences(of: "(\n    ", with: "")
                            holder = holder.replacingOccurrences(of: "\n)", with: "")
                            holder = holder.replacingOccurrences(of: "\"", with: "")
                            self.type.append(holder)
                        }
                        
                        for i in urlArr {
                            holder = String(describing: i).replacingOccurrences(of: "(\n    ", with: "")
                            holder = holder.replacingOccurrences(of: "\n)", with: "")
                            holder = holder.replacingOccurrences(of: "\"", with: "")
                            self.url.append(holder)
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
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
