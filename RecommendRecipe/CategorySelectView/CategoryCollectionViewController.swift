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
    
    let sizeRatio:CGFloat = 0.5
    let cellSizeMergin: CGFloat = 7.5
    var cellSideLength:CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        self.navigationItem.title = R.string.titleWord.categoryCollectionViewController()
        
        self.cellSideLength = UIScreen.main.bounds.size.width  * sizeRatio - cellSizeMergin
        self.setCellLayout()

    }

    override func viewWillAppear(_ animated: Bool) {
        self.collectionView.isUserInteractionEnabled = true
    }
    
    func setCellLayout(){
        // レイアウト設定
        let cellLayout = UICollectionViewFlowLayout()
        cellLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        cellLayout.minimumInteritemSpacing = 0
        cellLayout.minimumLineSpacing = 5
        cellLayout.itemSize = CGSize(width: self.cellSideLength, height: self.cellSideLength)
        collectionView.collectionViewLayout = cellLayout
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
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

        let image = UIImage(named: categoryName)
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x:0, y:0, width:self.cellSideLength, height:self.cellSideLength)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        cell.contentView.addSubview(imageView)
        
        let labelBackground = UIView.init(frame: CGRect.init(x: 0, y: cell.frame.height - 35, width: self.cellSideLength, height: 24))
        labelBackground.backgroundColor = .white
        labelBackground.alpha = 0.7
        cell.contentView.addSubview(labelBackground)
        
        let categoryLabel = UILabel(frame: CGRect(x: 10, y: cell.frame.height - 35, width: cell.frame.width - 20, height: 24))
        categoryLabel.font =  UIFont.systemFont(ofSize: 24)
        categoryLabel.text = categoryName
        categoryLabel.textColor = UIColor.black
        cell.contentView.addSubview(categoryLabel)
        
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
