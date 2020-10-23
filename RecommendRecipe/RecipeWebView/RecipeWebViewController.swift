//
//  RecipeWebViewController.swift
//  RecommendRecipe
//
//  Created by 宮永祐介 on 2020/10/21.
//  Copyright © 2020 Miyanaga. All rights reserved.
//

import UIKit
import WebKit

class RecipeWebViewController: UIViewController {


    @IBOutlet weak var wkWebView: WKWebView!
    var urlString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBarController?.tabBar.isHidden = true
        
        if let url = URL(string: urlString!) {
            let request = URLRequest(url: url as URL)
            wkWebView.load(request as URLRequest)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    

}
