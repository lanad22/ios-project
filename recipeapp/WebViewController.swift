//
//  WebViewController.swift
//  recipeapp
//
//  Created by Lana Do on 11/13/23.
//

import UIKit

class WebViewController: UIViewController {

    //UI Properties
    @IBOutlet weak var recipeWebView: UIWebView!
    
    //Class Properties
    var urlString : String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: urlString!) {
            let requestObj = URLRequest(url: url)
            recipeWebView.loadRequest(requestObj)
        }
    }


}
