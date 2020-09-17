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

    enum CategoryType: Int{
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
        
        var name: String {
            switch self {
            case .meat:            return R.string.categoryType.meat()
            case .fish:            return R.string.categoryType.fish()
            case .egg:             return R.string.categoryType.egg()
            case .tofu:            return R.string.categoryType.tofu()
            case .rice:            return R.string.categoryType.rice()
            case .powder:          return R.string.categoryType.powder()
            case .noodle:          return R.string.categoryType.noodle()
            case .bread:           return R.string.categoryType.bread()
            case .soup:            return R.string.categoryType.soup()
            case .casserole:       return R.string.categoryType.casserole()
            case .vegetable:       return R.string.categoryType.vegetable()
            case .salad:           return R.string.categoryType.salad()
            case .sweets:          return R.string.categoryType.sweets()
            case .fruit:           return R.string.categoryType.fruit()
            case .overseasCuisine: return R.string.categoryType.overseasCuisine()
            case .bento:           return R.string.categoryType.bento()
            }
        }
    }
    
    let categoryTypeCount:Int = 16
    var cellSideLength:CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let collectionView = self.collectionView else { return }
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        self.navigationItem.title = R.string.titleWord.categoryCollectionViewController()
        
        let sizeRatio:CGFloat = 0.5
        let cellSizeMergin: CGFloat = 7.5
        self.cellSideLength = UIScreen.main.bounds.size.width  * sizeRatio - cellSizeMergin
        self.setCellLayout()
        
        self.collectionView.backgroundColor = UIColor.init(rgb: UIColor.baseColor)

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
        
        imageView.frame = CGRect(x:.zero, y:.zero, width:self.cellSideLength, height:self.cellSideLength)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }
    
    func createtLabelBackground(parentView: UIView) -> UIView{
        let yAxisMargin:CGFloat = 35
        let viewHeight:CGFloat = 24
        let alphaValue:CGFloat = 0.7
        
        let labelBackground = UIView.init(frame: CGRect.init(x: .zero,
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
        
        cell.contentView.subviews.forEach { childView in
            childView.removeFromSuperview()
        }
    
        let optionalCategoryName = CategoryType(rawValue: indexPath.row)?.name
        
        guard let categoryName = optionalCategoryName else { return cell }
        cell.contentView.addSubview(self.createCategoryImageView(imageName: categoryName))
        cell.contentView.addSubview(self.createtLabelBackground(parentView: cell))
        cell.contentView.addSubview(self.createCategoryLabel(parentView: cell, labelText: categoryName))
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.collectionView.isUserInteractionEnabled = false
        let nextViewController = UIStoryboard(name: "RecipeCardView", bundle: nil).instantiateViewController(withIdentifier: "RecipeCardView") as! RecipeCardViewController
        
        let optionalCategoryName = CategoryType(rawValue: indexPath.row)?.name
        
        guard let categoryName = optionalCategoryName else { return }
        nextViewController.navigationTitle = categoryName
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }

}
