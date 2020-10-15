//
//  UIImageView+Extension.swift
//  RecommendRecipe
//
//  Created by 宮永祐介 on 2020/10/14.
//  Copyright © 2020 Miyanaga. All rights reserved.
//

import UIKit

extension UIImageView {

    func loadImageAsynchronously(url: URL?, defaultUIImage: UIImage? = nil){

        self.contentMode =  UIView.ContentMode.scaleAspectFit
        
        if url == nil {
            self.image = defaultUIImage
            return
        }

        DispatchQueue.global().async {
            do {
                let imageData: Data? = try Data(contentsOf: url!)
                DispatchQueue.main.async {
                    if let data = imageData {
                        self.image = UIImage(data: data)
                    } else {
                        self.image = defaultUIImage
                    }
                }
            }
            catch {
                DispatchQueue.main.async {
                    self.image = defaultUIImage
                }
            }
        }
    }

}

