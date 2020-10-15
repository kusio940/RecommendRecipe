//
//  RecipeCardViewController.swift
//  RecommendRecipe
//
//  Created by 宮永祐介 on 2020/08/27.
//  Copyright © 2020 Miyanaga. All rights reserved.
//

import UIKit
import Koloda

class RecipeCardViewController: UIViewController {
    
    @IBOutlet private weak var cardCountLabel: UILabel!
    @IBOutlet private weak var undoButton: UIButton!
    @IBOutlet private weak var addFavoriteButton: UIButton!
    
    var navigationTitle: String?
    let recipeCardCount: NSInteger = 2
    
    let kolodaView = KolodaView()

    let activityIndicator = UIActivityIndicatorView()
    
    var recipeDataArray: [RecipeData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationItem()
        setKolodaView()
        setBackgroundColor()
        setUndoButtonColor()
        
        updateRecipeCard()
    }
    
    func setNavigationItem() {
        if let title = navigationTitle
        {
            navigationItem.title = title
        }
        
        let reloadBarButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadCard))
        navigationItem.rightBarButtonItem = reloadBarButton
    }
    
    @objc func reloadCard() {
        updateRecipeCard()
    }

    func setKolodaView() {
        let widthRatio: CGFloat = 1.2
        let heightRatio: CGFloat = 1.8
        
        let recipeCardWidth = view.bounds.width / widthRatio
        let recipeCardHeight = view.bounds.height / heightRatio
        kolodaView.frame = CGRect(x: .zero, y: .zero, width: recipeCardWidth, height: recipeCardHeight)
        kolodaView.center = view.center
        
        view.addSubview(kolodaView)
        kolodaView.dataSource = self
        kolodaView.delegate = self
    }
    
    func setBackgroundColor() {
        view.backgroundColor = UIColor(rgb: UIColor.baseColor)
    }
    
    func setUndoButtonColor() {
        undoButton.tintColor = UIColor(rgb: UIColor.undoButtonColor)
    }
    
    func updateRecipeCard(){
        
        let rakutenRecipeApiClient = RakutenRecipeApiClient()
        let fetchCount: Int = 2
        var beforeSmallCategoryNumber: Int = -1
        
        guard let categoryType = self.navigationItem.title else{ return }
        
        startIndicator(view: view, activityIndicatorView: activityIndicator)
        DispatchQueue.global(qos: .userInitiated).async {
            
            for _ in 0 ..< fetchCount {
                let smallCategoryNumber = self.generateRandamNumber(categoryType: categoryType, exclusionNumber: beforeSmallCategoryNumber)
                beforeSmallCategoryNumber = smallCategoryNumber
                
                guard let categoryID = RakutenRecipeCategoryId(rawValue: categoryType)?.getCategoryId(smallCategoryNumber: 0)
                else{
                    DispatchQueue.main.async {
                        self.stopIndicator(activityIndicatorView: self.activityIndicator)
                    }
                    return
                }
                
                let dataArray = rakutenRecipeApiClient.fetchCategoryRanking(categoryID: categoryID, categoryType: categoryType)
                self.recipeDataArray.append(contentsOf: dataArray)
            }
            
            DispatchQueue.main.async {
                self.stopIndicator(activityIndicatorView: self.activityIndicator)
                self.kolodaView.resetCurrentCardIndex()
            }
        }
    }
    
    func generateRandamNumber(categoryType: String, exclusionNumber: Int) -> Int{
        //アンラップ失敗時は、異常値として−１を返す
        guard let maxNumber = IncludedCategoryCount(rawValue: categoryType)?.CategoryCount else { return -1 }
        
        var resultNumber = Int.random(in: 0..<maxNumber)
        
        while(exclusionNumber == resultNumber)
        {
            resultNumber = Int.random(in: 0..<maxNumber)
        }
        
        return resultNumber
    }

}

// MARK: KolodaViewDataSource

extension RecipeCardViewController: KolodaViewDataSource {

    // 表示する件数を指定します
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return recipeDataArray.count
    }

    // カードフリック時のスピードを指定します.
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }

    // 指定indexで表示するViewを生成して返却します.
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {

        // CardのベースとなるView
        let recipeCardView = createRecipeCardView(parentView: koloda)
        //　画像を表示
        recipeCardView.addSubview(createRecipeImageView(parentView: recipeCardView, index: index))
        // ラベルを表示する
        recipeCardView.addSubview(createRecipeTitleLabel(parentView: recipeCardView, index: index))
        // レシピの説明を表示
        recipeCardView.addSubview(createRecipeDescriptionTextView(parentView: recipeCardView, index: index))

        return recipeCardView
    }
    
    func createRecipeCardView(parentView: KolodaView) -> UIView {
        let shadowOpacityValue: Float = 0.2
        let shadowOffsetHeight: CGFloat = 1.5
        
        let recipeCardView = UIView()
        recipeCardView.bounds = CGRect(x: .zero,
                                       y: .zero,
                                       width: parentView.bounds.width,
                                       height: parentView.bounds.height)
        
        recipeCardView.layer.backgroundColor = UIColor.white.cgColor
        recipeCardView.layer.shadowColor = UIColor.black.cgColor
        recipeCardView.layer.shadowOpacity = shadowOpacityValue
        recipeCardView.layer.shadowOffset = CGSize(width: .zero, height: shadowOffsetHeight)
        
        return recipeCardView
    }
    
    func createRecipeImageView(parentView: UIView, index: Int) -> UIImageView {
        
        let recipeImageView = UIImageView(frame: CGRect(x: parentView.bounds.origin.x,
                                                        y: parentView.bounds.origin.y,
                                                        width: parentView.bounds.width,
                                                        height: parentView.bounds.height))
        
        if(recipeDataArray.count >= recipeCardCount) {
            recipeImageView.loadImageAsynchronously(url: URL(string: recipeDataArray[index].recipeImageUrl),
                                                    defaultUIImage: nil)
        }
        recipeImageView.contentMode = UIView.ContentMode.scaleAspectFill
        recipeImageView.clipsToBounds = true
        
        return recipeImageView
    }
    
    func createRecipeTitleLabel(parentView: UIView, index: Int) -> UILabel {
        let xAxisMargin: CGFloat = 10
        let yAxisRatio: CGFloat = 15
        let widthMargin: CGFloat = 20
        let recipeTitleLabelHeight: CGFloat = 20.5
        
        let recipeTitleLabel = UILabel(frame: CGRect(x: xAxisMargin,
                                                     y: parentView.bounds.height / yAxisRatio,
                                                     width: parentView.bounds.width - widthMargin,
                                                     height: recipeTitleLabelHeight))

        recipeTitleLabel.textColor = UIColor.black
        
        if(recipeDataArray.count >= recipeCardCount) {
            recipeTitleLabel.text = recipeDataArray[index].recipeTitle
        }
        else {
           recipeTitleLabel.text = ""
        }

        let alphaValue:CGFloat = 0.7
        recipeTitleLabel.backgroundColor = .white
        recipeTitleLabel.alpha = alphaValue
        
        return recipeTitleLabel
    }
        
    func createRecipeDescriptionTextView(parentView: UIView, index: Int) -> UITextView {
        let xAxisMargin: CGFloat = 10
        let yAxisMargin: CGFloat = 5
        let widthMargin: CGFloat = 20
        let heightRatio: CGFloat = 4
        
        let recipeDescriptionTextView = UITextView(frame: CGRect(x: xAxisMargin,
                                                                 y: parentView.bounds.height - (parentView.bounds.height / heightRatio) - yAxisMargin,
                                                                 width: parentView.bounds.width - widthMargin,
                                                                 height: parentView.bounds.height / heightRatio))
        recipeDescriptionTextView.isEditable = false
        recipeDescriptionTextView.textColor = UIColor.black
        recipeDescriptionTextView.backgroundColor = UIColor.white
        
        if(recipeDataArray.count >= recipeCardCount) {
            recipeDescriptionTextView.text = recipeDataArray[index].recipeDescription
        }
        else {
            recipeDescriptionTextView.text = ""
        }
        
        let alphaValue:CGFloat = 0.7
        recipeDescriptionTextView.backgroundColor = .white
        recipeDescriptionTextView.alpha = alphaValue
        
        return recipeDescriptionTextView
    }

}

// MARK: KolodaViewDelegate

extension RecipeCardViewController: KolodaViewDelegate {

    // フリックできる方向を指定する
    func koloda(_ koloda: KolodaView, allowedDirectionsForIndex index: Int) -> [SwipeResultDirection] {
        return [.left, .right]
    }

    // カードを全て消費したときの処理を定義する
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
    }

    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
    }

    //カードタップ時のイベント
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
    }
}
