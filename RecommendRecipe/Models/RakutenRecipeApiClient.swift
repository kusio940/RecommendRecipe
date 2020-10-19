//
//  RakutenRecipeApiClient.swift
//  RecommendRecipe
//
//  Created by 宮永祐介 on 2020/10/01.
//  Copyright © 2020 Miyanaga. All rights reserved.
//

import Foundation
import SwiftyJSON

class RakutenRecipeApiClient{

    func fetchCategoryRanking(categoryID: String, categoryType: String, complete: @escaping (Array<RecipeData>)->()) {
        
        var responseArray:[RecipeData] = []
        
        guard let url = createUrl(categoryID: categoryID) else { return }
        guard let request = createRequest(url: url) else { return }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let response = response {
                if((response as! HTTPURLResponse).statusCode == 200){
                    do {
                        let json = try JSON(data: data)
                        
                        for recipeData in json["result"].array! {
                            let recipeId = recipeData["recipeId"].int
                            let recipeTitle = recipeData["recipeTitle"].string
                            let recipeImageUrl = recipeData["foodImageUrl"].string
                            let recipeUrl = recipeData["recipeUrl"].string
                            let recipeDescription = recipeData["recipeDescription"].string
                            let categoryType = categoryType
                            
                            var recipeIdString = String(recipeId ?? -1)
                            if(recipeIdString == "-1") {
                                recipeIdString = ""
                            }
                        
                            responseArray.append(RecipeData(recipeId: recipeIdString,
                                                            recipeTitle: recipeTitle ?? "",
                                                            recipeImageUrl: recipeImageUrl ?? "",
                                                            recipeUrl: recipeUrl ?? "",
                                                            recipeDescription: recipeDescription ?? "",
                                                            categoryType: categoryType))
                        }

                    } catch {
                        print("parse error")
                    }
                } else{
                    print("URLSession error")
                }
            } else {
                print(error ?? "unknown error")
            }
            complete(responseArray)
        }

        task.resume()
    }
    
    func createUrl(categoryID: String) -> URL? {
        let urlString = R.string.rakutenRecipeApi.url() + categoryID
        print(urlString)
        return URL(string:urlString)
    }
    
    func createRequest(url: URL) -> URLRequest? {
        var request = URLRequest(url: url,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 10.0)
        request.httpMethod = "GET"
        
        return request
    }
}
