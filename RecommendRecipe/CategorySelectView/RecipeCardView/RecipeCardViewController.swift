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
    
    let kolodaView = KolodaView()
    
    let activityIndicatorView = UIActivityIndicatorView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let title = navigationTitle
        {
            navigationItem.title = title
        }
        
        let reloadBarButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadCard))
        navigationItem.rightBarButtonItem = reloadBarButton
                
        setKolodaView()
        setBackgroundColor()
        setUndoButtonColor()
    }
    
    @objc func reloadCard(){
        kolodaView.resetCurrentCardIndex()
    }

    func setKolodaView(){
        let widthRatio:CGFloat = 1.2
        let heightRatio:CGFloat = 1.8
        
        let recipeCardWidth = view.bounds.width / widthRatio
        let recipeCardHeight = view.bounds.height / heightRatio
        kolodaView.frame = CGRect(x: .zero, y: .zero, width: recipeCardWidth, height: recipeCardHeight)
        kolodaView.center = view.center
        
        view.addSubview(kolodaView)
        kolodaView.dataSource = self
        kolodaView.delegate = self
    }
    
    func setBackgroundColor(){
        view.backgroundColor = UIColor(rgb: UIColor.baseColor)
    }
    
    func setUndoButtonColor(){
        undoButton.tintColor = UIColor(rgb: UIColor.undoButtonColor)
    }

}

extension RecipeCardViewController: KolodaViewDataSource {

    // 表示する件数を指定します
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return 10
    }

    // カードフリック時のスピードを指定します.
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }

    // 指定indexで表示するViewを生成して返却します.
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {

        // CardのベースとなるView
        let recipeCardView = createRecipeCardView(parentView: koloda)
        // ラベルを表示する
        recipeCardView.addSubview(createRecipeTitleLabel(parentView: recipeCardView))
        //　画像を表示
        recipeCardView.addSubview(createRecipeImageView(parentView: recipeCardView))
        // レシピの説明を表示
        recipeCardView.addSubview(createRecipeDescriptionTextView(parentView: recipeCardView))

        return recipeCardView
    }
    
    func createRecipeCardView(parentView:KolodaView) -> UIView{
        let shadowOpacityValue:Float = 0.2
        let shadowOffsetHeight:CGFloat = 1.5
        
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
    
    func createRecipeTitleLabel(parentView:UIView) -> UILabel{
        let xAxisRatio:CGFloat = 2
        let yAxisRatio:CGFloat = 15
        
        let recipeTitleLabel = UILabel()
        recipeTitleLabel.text = ""
        recipeTitleLabel.sizeToFit()
        recipeTitleLabel.layer.position = CGPoint(x: parentView.bounds.width / xAxisRatio,
                                                  y:parentView.bounds.height / yAxisRatio)
        recipeTitleLabel.textColor = UIColor.black
        
        return recipeTitleLabel
    }
    
    func createRecipeImageView(parentView:UIView) -> UIImageView{
        let xAxisMargin:CGFloat = 10
        let yAxisRatio:CGFloat = 8
        let widthMargin:CGFloat = 20
        let heightRatio:CGFloat = 2.0
        
        let recipeImageView = UIImageView(frame: CGRect(x: xAxisMargin,
                                                        y: parentView.bounds.height / yAxisRatio,
                                                        width: parentView.bounds.width - widthMargin,
                                                        height: parentView.bounds.height / heightRatio))

        return recipeImageView
    }
    
    func createRecipeDescriptionTextView(parentView:UIView) -> UITextView{
        let xAxisMargin:CGFloat = 10
        let yAxisRatio:CGFloat = 1.5
        let widthMargin:CGFloat = 20
        let heightRatio:CGFloat = 2.3
        
        let recipeDescriptionTextView = UITextView(frame: CGRect(x: xAxisMargin,
                                                                 y: parentView.bounds.height / yAxisRatio,
                                                                 width: parentView.bounds.width - widthMargin,
                                                                 height: parentView.bounds.height / heightRatio))
        recipeDescriptionTextView.isEditable = false
        recipeDescriptionTextView.text = ""
        recipeDescriptionTextView.textColor = UIColor.black
        recipeDescriptionTextView.sizeToFit()
        recipeDescriptionTextView.backgroundColor = UIColor.white
        
        return recipeDescriptionTextView
    }

}

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
