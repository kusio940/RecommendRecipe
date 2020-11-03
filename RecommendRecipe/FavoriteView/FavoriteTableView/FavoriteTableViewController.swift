//
//  FavoriteTableViewController.swift
//  RecommendRecipe
//
//  Created by 宮永祐介 on 2020/10/26.
//  Copyright © 2020 Miyanaga. All rights reserved.
//

import UIKit
import RealmSwift

private let reuseIdentifier = "favoriteCell"

class FavoriteTableViewController: UITableViewController {

    var navigationTitle: String?
    var favoriteData: Array<Favorite> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationItem()
        setBackgroundColor()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoriteData = []
        getFavoriteData()
        tableView.reloadData()
        view.isUserInteractionEnabled = true
    }
    
    func setNavigationItem() {
        if let title = navigationTitle {
            navigationItem.title = title
        }
    }
    
    func setBackgroundColor() {
        view.backgroundColor = UIColor(rgb: UIColor.baseColor)
    }

    func getFavoriteData() {
        if let title = navigationTitle {
            let object = RealmManager.shared.getObject(type: Favorite.self).filter("categoryType == %@",title).sorted(byKeyPath: "time", ascending: false)
            for i in 0..<object.count{
                favoriteData.append(object[i] as! Favorite)
            }
        }
    }
    
    func setRecipeImage(cell: UITableViewCell, index: Int) {
        let recipeImageTag = 1
        let recipeImageView = cell.viewWithTag(recipeImageTag) as! UIImageView
        recipeImageView.loadImageAsynchronously(url: URL(string: favoriteData[index].recipeImageUrl ),
                                                defaultUIImage: nil)
    }
    
    func setRecipeTitle(cell: UITableViewCell, index: Int) {
        let recipeTitleLabelTag = 2
        let recipeTitleLabel = cell.viewWithTag(recipeTitleLabelTag) as! UILabel
        recipeTitleLabel.text = favoriteData[index].recipeTitle
    }
    
    func addHistory(index: Int) {
        guard !favoriteData.isEmpty else { return }
                
        let currentRecipeData = favoriteData[index]
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
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        setRecipeImage(cell: cell, index: indexPath.row)
        setRecipeTitle(cell: cell, index: indexPath.row)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //DB保存
        addHistory(index: indexPath.row)
        limitHistory()
        
        //画面遷移
        view.isUserInteractionEnabled = false
        let nextViewController = UIStoryboard(name: "RecipeWebView", bundle: nil).instantiateViewController(withIdentifier: "RecipeWebView") as! RecipeWebViewController

        let recipeUrl = favoriteData[indexPath.row].recipeUrl

        nextViewController.urlString = recipeUrl
        navigationController?.pushViewController(nextViewController, animated: true)
    }


}
