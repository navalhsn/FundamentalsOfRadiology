//
//  PDFViewController.swift
//  FRS
//
//  Created by NavalHasan on 20/10/19.
//  Copyright © 2019 infomatix. All rights reserved.
//

import UIKit
import PDFKit

class PDFViewController: UIViewController, PDFDocumentDelegate {

    // Outlets
    @IBOutlet weak var fileNameLab: UILabel!
    @IBOutlet var pdfView: PDFView!

    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
    
    // Declarations
    var pdfUrl = String(), name = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fileNameLab.text = name
        
        activityIndicator.center =  CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2)
        self.view.addSubview(activityIndicator)
        activityIndicator.color = UIColor.red
        self.activityIndicator.startAnimating()
        
        let urlString = (pdfUrl).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url: URL! = URL(string: urlString!)
        
        if let pdfDocument = PDFDocument(url: url) {
            pdfView.displayMode = .singlePageContinuous
            pdfView.autoScales = true
            pdfView.displayDirection = .vertical
            pdfView.document = pdfDocument
        }
       
        activityIndicator.stopAnimating()
    }
    
    
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
