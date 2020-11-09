//
//  RecipeCardViewController.swift
//  RecommendRecipe
//
//  Created by 宮永祐介 on 2020/08/27.
//  Copyright © 2020 Miyanaga. All rights reserved.
//

import UIKit
import Koloda
import RealmSwift

class RecipeCardViewController: UIViewController {
    
    @IBOutlet private weak var cardCountLabel: UILabel!
    @IBOutlet private weak var undoButton: UIButton!
    @IBOutlet private weak var addFavoriteButton: UIButton!
    
    var navigationTitle: String?
    let recipeCardCount: NSInteger = 8
    
    let kolodaView = KolodaView()
    
    let activityIndicator = UIActivityIndicatorView()
    
    var recipeDataArray: [RecipeData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationItem()
        setKolodaView()
        setCardCountLabelColor()
        setBackgroundColor()
        setButtonTarget()
        
        updateRecipeCard()
    }
    override func viewWillAppear(_ animated: Bool) {
        
        view.isUserInteractionEnabled = true
    }

    func setNavigationItem() {
        if let title = navigationTitle {
            navigationItem.title = title
        }
        
        let reloadBarButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadCard))
        navigationItem.rightBarButtonItem = reloadBarButton
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
    
    func setCardCountLabelColor() {
        cardCountLabel.textColor = .black
    }
    
    func setBackgroundColor() {
        view.backgroundColor = UIColor(rgb: UIColor.baseColor)
        undoButton.tintColor = UIColor.gray
        addFavoriteButton.tintColor = UIColor.gray
    }
    
    func setButtonTarget() {
        undoButton.addTarget(self, action: #selector(undoCard), for: .touchUpInside)
        addFavoriteButton.addTarget(self, action: #selector(addFavorite), for: .touchUpInside)
    }
    
    func updateFavotiteButton() {
        guard !recipeDataArray.isEmpty else { return }
        
        let currentIndex = kolodaView.currentCardIndex
        let currentRecipeId = recipeDataArray[currentIndex].recipeId
        
        let isExistRecipeId = RealmManager.shared.isExistRecipeId(realmObject: Favorite.self, recipeId: currentRecipeId)
        addFavoriteButton.tintColor = isExistRecipeId ? .systemYellow : .gray
    }
        
    func updateUndoButton() {
        let currentIndex = kolodaView.currentCardIndex
        let firstIndex: Int = .zero
        
        if (currentIndex == firstIndex) {
            undoButton.tintColor = UIColor.gray
            undoButton.isEnabled = false
        } else {
            undoButton.tintColor = UIColor(rgb: UIColor.undoButtonColor)
            undoButton.isEnabled = true
        }
    }
    
    func updateCardCountLabel() {
        let currentCount = kolodaView.currentCardIndex + 1
        
        if (recipeDataArray.count != recipeCardCount) {
            cardCountLabel.text = "Error"
        }
        else if (currentCount <= recipeCardCount) {
            cardCountLabel.text = String(currentCount) + "/" + String(recipeCardCount)
        }
    }
    
    func updateRecipeCard() {
        
        let rakutenRecipeApiClient = RakutenRecipeApiClient()
        let fetchCount: Int = 2
        var beforeSmallCategoryNumber: Int = -1
        let waitTime: Float = 1.5
        let lastCount: Int = fetchCount - 1
        
        guard let categoryType = self.navigationItem.title else { return }
        
        startIndicator(view: view, activityIndicatorView: activityIndicator)
        
        for currentCount in 0 ..< fetchCount {
            let smallCategoryNumber = self.generateRandamNumber(categoryType: categoryType, exclusionNumber: beforeSmallCategoryNumber)
            beforeSmallCategoryNumber = smallCategoryNumber
            
            guard let categoryID = RakutenRecipeCategoryId(rawValue: categoryType)?.getCategoryId(smallCategoryNumber: smallCategoryNumber)
            else {
                stopIndicator(activityIndicatorView: self.activityIndicator)
                return
            }
            
            rakutenRecipeApiClient.fetchCategoryRanking(categoryID: categoryID, categoryType: categoryType) { (dataArray) in
                if (!dataArray.isEmpty) {
                    self.recipeDataArray.append(contentsOf: dataArray)
                }
                
                if (currentCount == lastCount) {
                    DispatchQueue.main.async {
                        self.stopIndicator(activityIndicatorView: self.activityIndicator)
                        
                        if (self.recipeDataArray.count != self.recipeCardCount) {
                            self.recipeDataArray = []
                        }
                        self.kolodaView.resetCurrentCardIndex()
                        self.updateCardCountLabel()
                        self.updateUndoButton()
                        self.updateFavotiteButton()
                    }
                }
            }
            
            if (currentCount != lastCount) {
                //API連続呼び出しができないので一定時間待つ
                Thread.sleep(forTimeInterval: TimeInterval(waitTime))
            }
        }
    }
    
    func generateRandamNumber(categoryType: String, exclusionNumber: Int) -> Int {
        //アンラップ失敗時は、異常値として−１を返す
        guard let maxNumber = IncludedCategoryCount(rawValue: categoryType)?.CategoryCount else { return -1 }
        
        var resultNumber = Int.random(in: 0..<maxNumber)
        
        while(exclusionNumber == resultNumber)
        {
            resultNumber = Int.random(in: 0..<maxNumber)
        }
        
        return resultNumber
    }
    
    @objc func addFavorite() {
        guard !recipeDataArray.isEmpty else { return }
        
        let currentIndex = kolodaView.currentCardIndex
        let currentRecipeData = recipeDataArray[currentIndex]
        guard let categoryType = navigationItem.title else { return }
        
        let isExistRecipeId = RealmManager.shared.isExistRecipeId(realmObject: Favorite.self, recipeId: currentRecipeData.recipeId)
        if (isExistRecipeId) {
            let favorite = RealmManager.shared.getObject(type: Favorite.self).filter("recipeId = %@", currentRecipeData.recipeId).first!
            RealmManager.shared.deleteData(object: favorite)
        }
        else {
            let favorite = Favorite()
            
            favorite.recipeId = currentRecipeData.recipeId
            favorite.recipeTitle = currentRecipeData.recipeTitle
            favorite.recipeImageUrl = currentRecipeData.recipeImageUrl
            favorite.recipeUrl = currentRecipeData.recipeUrl
            favorite.categoryType = categoryType
            favorite.time = Date().getCurrentTime()
            
            RealmManager.shared.addDbData(object: favorite)
        }
        updateFavotiteButton()
    }
    
    func addHistory() {
        guard !recipeDataArray.isEmpty else { return }
                
        let currentIndex = kolodaView.currentCardIndex
        let currentRecipeData = recipeDataArray[currentIndex]
        let history = History()
        
        history.recipeId = currentRecipeData.recipeId
        history.recipeTitle = currentRecipeData.recipeTitle
        history.recipeImageUrl = currentRecipeData.recipeImageUrl
        history.recipeUrl = currentRecipeData.recipeUrl
        history.time = Date().getCurrentTime()
        
        RealmManager.shared.addDbData(object: history)
    }
    
    func limitHistory() {
        let historyLimit = 100
        let historyData = RealmManager.shared.getObject(type: History.self).sorted(byKeyPath: "time", ascending: false)
        guard let oldestHistory = historyData.last else { return }
        
        if (historyData.count > historyLimit) {
            RealmManager.shared.deleteData(object: oldestHistory)
        }
        
    }
    
    @objc func reloadCard() {
        self.recipeDataArray = []
        updateRecipeCard()
    }
    
    @objc func undoCard() {
        kolodaView.revertAction()
        updateCardCountLabel()
        updateUndoButton()
        updateFavotiteButton()
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
        recipeCardView.addSubview(createRecipeDescriptionLabel(parentView: recipeCardView, index: index))

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
        
        if (recipeDataArray.count >= recipeCardCount) {
            recipeImageView.loadImageAsynchronously(url: URL(string: recipeDataArray[index].recipeImageUrl),
                                                    defaultUIImage: nil)
        }
        recipeImageView.contentMode = UIView.ContentMode.scaleAspectFill
        recipeImageView.clipsToBounds = true
        
        return recipeImageView
    }
    
    func createRecipeTitleLabel(parentView: UIView, index: Int) -> UILabel {
        let xAxisMargin: CGFloat = 10
        let yAxisRatio: CGFloat = 30
        let widthMargin: CGFloat = 20
        let recipeTitleLabelHeight: CGFloat = 20.5
        
        let recipeTitleLabel = UILabel(frame: CGRect(x: xAxisMargin,
                                                     y: parentView.bounds.height / yAxisRatio,
                                                     width: parentView.bounds.width - widthMargin,
                                                     height: recipeTitleLabelHeight))

        recipeTitleLabel.textColor = UIColor.black
        recipeTitleLabel.font = UIFont.boldSystemFont(ofSize: recipeTitleLabelHeight)
        
        if (recipeDataArray.count >= recipeCardCount) {
            recipeTitleLabel.text = recipeDataArray[index].recipeTitle
        }
        else {
           recipeTitleLabel.text = ""
        }

        let alphaValue:CGFloat = 0.7
        recipeTitleLabel.backgroundColor = .white
        recipeTitleLabel.alpha = alphaValue
        
        recipeTitleLabel.numberOfLines = 0
        recipeTitleLabel.sizeToFit()
        
        return recipeTitleLabel
    }
        
    func createRecipeDescriptionLabel(parentView: UIView, index: Int) -> UILabel {
        let xAxisMargin: CGFloat = 10
        let yAxisMargin: CGFloat = 5
        let widthMargin: CGFloat = 20
        let heightRatio: CGFloat = 4
        let recipeDescriptionLabelHeight: CGFloat = 20.5
        
        let recipeDescriptionLabel = UILabel(frame: CGRect(x: xAxisMargin,
                                                           y: parentView.bounds.height - (parentView.bounds.height / heightRatio) - yAxisMargin,
                                                           width: parentView.bounds.width - widthMargin,
                                                           height: recipeDescriptionLabelHeight))
        
        recipeDescriptionLabel.textColor = UIColor.black
        recipeDescriptionLabel.backgroundColor = UIColor.white
        
        if (recipeDataArray.count >= recipeCardCount) {
            recipeDescriptionLabel.text = recipeDataArray[index].recipeDescription
        }
        else {
            recipeDescriptionLabel.text = ""
        }
        
        let alphaValue:CGFloat = 0.7
        recipeDescriptionLabel.backgroundColor = .white
        recipeDescriptionLabel.alpha = alphaValue
        
        recipeDescriptionLabel.numberOfLines = 0
        recipeDescriptionLabel.sizeToFit()
        
        recipeDescriptionLabel.frame.origin.y = parentView.bounds.height - recipeDescriptionLabel.bounds.height - yAxisMargin
        
        return recipeDescriptionLabel
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
        let maxIndex = recipeCardCount - 1
        if (index < maxIndex) {
            updateCardCountLabel()
            updateUndoButton()
            updateFavotiteButton()
        }
    }

    //カードタップ時のイベント
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        //DB保存
        addHistory()
        limitHistory()
        
        //画面遷移
        view.isUserInteractionEnabled = false
        let nextViewController = UIStoryboard(name: "RecipeWebView", bundle: nil).instantiateViewController(withIdentifier: "RecipeWebView") as! RecipeWebViewController

        let recipeUrl = recipeDataArray[index].recipeUrl

        nextViewController.urlString = recipeUrl
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}
