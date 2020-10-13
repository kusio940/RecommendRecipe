//
//  UIViewController+Extension.swift
//  RecommendRecipe
//
//  Created by 宮永祐介 on 2020/09/18.
//  Copyright © 2020 Miyanaga. All rights reserved.
//

import UIKit

extension UIViewController{
    
    func startIndicator(view:UIView, activityIndicatorView:UIActivityIndicatorView){
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .large
        activityIndicatorView.color = .black
        view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
    }
    
    func stopIndicator(activityIndicatorView:UIActivityIndicatorView){
        activityIndicatorView.stopAnimating()
    }
}
