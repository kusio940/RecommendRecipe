//
//  CategoryCollectionViewController.swift
//  RecommendRecipe
//
//  Created by 宮永祐介 on 2020/08/27.
//  Copyright © 2020 Miyanaga. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CategoryCollectionViewController: UICollectionViewController {

    enum CategoryType:Int{
        case meat
        case fish
        case egg
        case tofu
        case rice
        case powder
        case noodle
        case bread
        case soup
        case casserole
        case vegetable
        case salad
        case sweets
        case fruit
        case overseasCuisine
        case bento
    }
    
    let categoryTypeCount:Int = 16
    var cellSideLength:CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        self.navigationItem.title = R.string.titleWord.categoryCollectionViewController()
        
        let sizeRatio:CGFloat = 0.5
        let cellSizeMergin: CGFloat = 7.5
        self.cellSideLength = UIScreen.main.bounds.size.width  * sizeRatio - cellSizeMergin
        self.setCellLayout()

    }

    override func viewWillAppear(_ animated: Bool) {
        self.collectionView.isUserInteractionEnabled = true
    }
    
    func setCellLayout() {
        let cellEdgeMergin:CGFloat = 5.0
        let cellMinimumInteritemSpacing:CGFloat = 0
        let cellMinimumLineSpacing:CGFloat = 5.0
        
        let cellLayout = UICollectionViewFlowLayout()
        cellLayout.sectionInset = UIEdgeInsets(top: cellEdgeMergin, left: cellEdgeMergin, bottom: cellEdgeMergin, right: cellEdgeMergin)
        cellLayout.minimumInteritemSpacing = cellMinimumInteritemSpacing
        cellLayout.minimumLineSpacing = cellMinimumLineSpacing
        cellLayout.itemSize = CGSize(width: self.cellSideLength, height: self.cellSideLength)
        collectionView.collectionViewLayout = cellLayout
    }
    
    func createCategoryImageView(imageName: String)-> UIImageView {
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        
        imageView.frame = CGRect(x:0, y:0, width:self.cellSideLength, height:self.cellSideLength)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }
    
    func createtLabelBackground(parentView: UIView) -> UIView{
        let yAxisMargin:CGFloat = 35
        let viewHeight:CGFloat = 24
        let alphaValue:CGFloat = 0.7
        
        let labelBackground = UIView.init(frame: CGRect.init(x: 0,
                                                             y: parentView.frame.height - yAxisMargin,
                                                             width: self.cellSideLength,
                                                             height: viewHeight))
        labelBackground.backgroundColor = .white
        labelBackground.alpha = alphaValue
        
        return labelBackground
    }
    
    func createCategoryLabel(parentView: UIView, labelText: String) -> UILabel{
        let xAxisMargin:CGFloat = 10
        let yAxisMargin:CGFloat = 35
        let labelwidthMargin:CGFloat = 20
        let labelHeight:CGFloat = 24
        
        let categoryLabel = UILabel(frame: CGRect(x: xAxisMargin,
                                                  y: parentView.frame.height - yAxisMargin,
                                                  width: parentView.frame.width - labelwidthMargin,
                                                  height: labelHeight))
        categoryLabel.font =  UIFont.systemFont(ofSize: 24)
        categoryLabel.text = labelText
        categoryLabel.textColor = UIColor.black
        
        return categoryLabel
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryTypeCount
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        cell.contentView.subviews.forEach {
            $0.removeFromSuperview()
        }
    
        var categoryName:String!

        switch indexPath.row {
            
        case CategoryType.meat.rawValue:
            categoryName = R.string.categoryType.meat()

        case CategoryType.fish.rawValue:
            categoryName = R.string.categoryType.fish()
            
        case CategoryType.egg.rawValue:
            categoryName = R.string.categoryType.egg()
            
        case CategoryType.tofu.rawValue:
            categoryName = R.string.categoryType.tofu()
            
        case CategoryType.rice.rawValue:
            categoryName = R.string.categoryType.rice()
            
        case CategoryType.powder.rawValue:
            categoryName = R.string.categoryType.powder()
            
        case CategoryType.noodle.rawValue:
            categoryName = R.string.categoryType.noodle()
            
        case CategoryType.bread.rawValue:
            categoryName = R.string.categoryType.bread()
            
        case CategoryType.soup.rawValue:
            categoryName = R.string.categoryType.soup()
            
        case CategoryType.casserole.rawValue:
            categoryName = R.string.categoryType.casserole()
            
        case CategoryType.vegetable.rawValue:
            categoryName = R.string.categoryType.vegetable()
            
        case CategoryType.salad.rawValue:
            categoryName = R.string.categoryType.salad()
            
        case CategoryType.sweets.rawValue:
            categoryName = R.string.categoryType.sweets()
            
        case CategoryType.fruit.rawValue:
            categoryName = R.string.categoryType.fruit()
            
        case CategoryType.overseasCuisine.rawValue:
            categoryName = R.string.categoryType.overseasCuisine()
            
        case CategoryType.bento.rawValue:
            categoryName = R.string.categoryType.bento()
            
        default:
            break
            
        }
        
        cell.contentView.addSubview(self.createCategoryImageView(imageName: categoryName))
        cell.contentView.addSubview(self.createtLabelBackground(parentView: cell))
        cell.contentView.addSubview(self.createCategoryLabel(parentView: cell, labelText: categoryName))
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.collectionView.isUserInteractionEnabled = false
        let nextViewController = UIStoryboard(name: "RecipeCardView", bundle: nil).instantiateViewController(withIdentifier: "RecipeCardView") as! RecipeCardViewController
        
        var categoryName:String!

        switch indexPath.row {
            
        case CategoryType.meat.rawValue:
            categoryName = R.string.categoryType.meat()
            
        case CategoryType.fish.rawValue:
            categoryName = R.string.categoryType.fish()
            
        case CategoryType.egg.rawValue:
            categoryName = R.string.categoryType.egg()
            
        case CategoryType.tofu.rawValue:
            categoryName = R.string.categoryType.tofu()
            
        case CategoryType.rice.rawValue:
            categoryName = R.string.categoryType.rice()
            
        case CategoryType.powder.rawValue:
            categoryName = R.string.categoryType.powder()
            
        case CategoryType.noodle.rawValue:
            categoryName = R.string.categoryType.noodle()
            
        case CategoryType.bread.rawValue:
            categoryName = R.string.categoryType.bread()
            
        case CategoryType.soup.rawValue:
            categoryName = R.string.categoryType.soup()
            
        case CategoryType.casserole.rawValue:
            categoryName = R.string.categoryType.casserole()
            
        case CategoryType.vegetable.rawValue:
            categoryName = R.string.categoryType.vegetable()
            
        case CategoryType.salad.rawValue:
            categoryName = R.string.categoryType.salad()
            
        case CategoryType.sweets.rawValue:
            categoryName = R.string.categoryType.sweets()
            
        case CategoryType.fruit.rawValue:
            categoryName = R.string.categoryType.fruit()
            
        case CategoryType.overseasCuisine.rawValue:
            categoryName = R.string.categoryType.overseasCuisine()
            
        case CategoryType.bento.rawValue:
            categoryName = R.string.categoryType.bento()
            
        default:
            break
            
        }
        
        nextViewController.navigationTitle = categoryName
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }

}
