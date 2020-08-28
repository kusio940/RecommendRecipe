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

    let cellSideLength:CGFloat = UIScreen.main.bounds.size.width  / 2.0 - 7.5
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        self.navigationItem.title = R.string.titleWord.categoryCollectionViewController()
        
        // レイアウト設定
        let cellLayout = UICollectionViewFlowLayout()
        cellLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        cellLayout.minimumInteritemSpacing = 0
        cellLayout.minimumLineSpacing = 5
        cellLayout.itemSize = CGSize(width: cellSideLength, height: cellSideLength)
        collectionView.collectionViewLayout = cellLayout

    }

    override func viewWillAppear(_ animated: Bool) {
        self.collectionView.isUserInteractionEnabled = true
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
        case 0:
            categoryName = R.string.categoryType.meat()
        case 1:
            categoryName = R.string.categoryType.fish()
        case 2:
            categoryName = R.string.categoryType.egg()
        case 3:
            categoryName = R.string.categoryType.tofu()
        case 4:
            categoryName = R.string.categoryType.rice()
        case 5:
            categoryName = R.string.categoryType.powder()
        case 6:
            categoryName = R.string.categoryType.noodle()
        case 7:
            categoryName = R.string.categoryType.bread()
        case 8:
            categoryName = R.string.categoryType.soup()
        case 9:
            categoryName = R.string.categoryType.casserole()
        case 10:
            categoryName = R.string.categoryType.vegetable()
        case 11:
            categoryName = R.string.categoryType.salad()
        case 12:
            categoryName = R.string.categoryType.sweets()
        case 13:
            categoryName = R.string.categoryType.fruit()
        case 14:
            categoryName = R.string.categoryType.overseasCuisine()
        case 15:
            categoryName = R.string.categoryType.bento()
        default:
            break
        }

        let image = UIImage(named: categoryName)
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x:0, y:0, width:cellSideLength, height:cellSideLength)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        cell.contentView.addSubview(imageView)
        
        let labelBackground = UIView.init(frame: CGRect.init(x: 0, y: cell.frame.height - 35, width: cellSideLength, height: 24))
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
        case 0:
            categoryName = R.string.categoryType.meat()
        case 1:
            categoryName = R.string.categoryType.fish()
        case 2:
            categoryName = R.string.categoryType.egg()
        case 3:
            categoryName = R.string.categoryType.tofu()
        case 4:
            categoryName = R.string.categoryType.rice()
        case 5:
            categoryName = R.string.categoryType.powder()
        case 6:
            categoryName = R.string.categoryType.noodle()
        case 7:
            categoryName = R.string.categoryType.bread()
        case 8:
            categoryName = R.string.categoryType.soup()
        case 9:
            categoryName = R.string.categoryType.casserole()
        case 10:
            categoryName = R.string.categoryType.vegetable()
        case 11:
            categoryName = R.string.categoryType.salad()
        case 12:
            categoryName = R.string.categoryType.sweets()
        case 13:
            categoryName = R.string.categoryType.fruit()
        case 14:
            categoryName = R.string.categoryType.overseasCuisine()
        case 15:
            categoryName = R.string.categoryType.bento()
        default:
            break
        }
        
        nextViewController.navigationTitle = categoryName
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }

}
