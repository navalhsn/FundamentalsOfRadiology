//
//  ImageViewer.swift
//  FRS
//
//  Created by Naval Hasan on 12/02/19.
//  Copyright © 2019 fragmentree. All rights reserved.
//

import UIKit
import SDWebImage

class ImageViewer: UIViewController {

    // Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var fileNameLab: UILabel!
    
    // Declarations
    var imageUrl = String(), name = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fileNameLab.text = name
        let urlString = (imageUrl).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        imageView.sd_setImage(with: URL(string: urlString!), placeholderImage: UIImage(named: "logo"))


    }
    

    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}


