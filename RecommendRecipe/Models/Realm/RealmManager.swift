//
//  RealmManager.swift
//  RecommendRecipe
//
//  Created by 宮永祐介 on 2020/10/18.
//  Copyright © 2020 Miyanaga. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    
    let realm = try! Realm()
    static let shared = RealmManager()
    let realmFilePath =  NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? "" + "/default.realm"
    
    func getObject(type: Object.Type) -> Results<Object> {
        return realm.objects(type.self)
    }
    
    func addDbData(object: Object) {
        try! realm.write {
            realm.add(object, update: .all)
        }
    }
    
    func deleteData(object: Object) {
         try! realm.write {
             realm.delete(object)
         }
     }
    
    func isExistRecipeId<Element: Object>(realmObject: Element.Type, recipeId:String)-> Bool {
        if(!FileManager.default.fileExists(atPath: realmFilePath)){
            return false
        }
        
        let results = realm.object(ofType: Element.self, forPrimaryKey: recipeId)
        if(results == nil){
            return false
        }
        
        return true
    }
    
}
