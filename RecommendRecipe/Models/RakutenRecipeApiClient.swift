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

    func fetchCategoryRanking(categoryID: String, categoryType: String) -> Array<RecipeData> {
        
        let semaphore = DispatchSemaphore(value: 0)
        var responseArray:[RecipeData] = []
        
        guard let url = createUrl(categoryID: categoryID) else{ return responseArray }
        guard let request = createRequest(url: url) else{ return responseArray }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let response = response {
                if((response as! HTTPURLResponse).statusCode == 200){
                    do {
                        let json = try JSON(data: data)
                        
                        for recipeData in json["result"].array! {
                            let recipeId = recipeData["recipeId"].string
                            let recipeTitle = recipeData["recipeTitle"].string
                            let recipeImageUrl = recipeData["foodImageUrl"].string
                            let recipeUrl = recipeData["recipeUrl"].string
                            let recipeDescription = recipeData["recipeDescription"].string
                            let categoryType = categoryType
                            
                            responseArray.append(RecipeData(recipeId: recipeId ?? "",
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
            semaphore.signal()
        }

        task.resume()
        
        semaphore.wait()
        return responseArray
    }
    
    func createUrl(categoryID: String) -> URL? {
        let urlString = R.string.rakutenRecipeApi.url() + categoryID
        return URL(string:urlString + categoryID)
    }
    
    func createRequest(url: URL) -> URLRequest? {
        var request = URLRequest(url: url,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 10.0)
        request.httpMethod = "GET"
        
        return request
    }
}
