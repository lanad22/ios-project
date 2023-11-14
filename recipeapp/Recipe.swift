//
//  Recipe.swift
//  recipeapp
//
//  Created by Lana Do on 11/13/23.
//

import Foundation

class Recipe {

    let ingredients: String?
    let title: String?
    let href: String? // Spoonacular may not provide a direct href. Adjust accordingly.
    let thumbnail: String?

    struct RecipeAPIKeys {
        static let ingredients = "usedIngredients" // or "usedIngredients" depending on your requirement
        static let title = "title"
        static let href =  "sourceUrl" // Use an appropriate field from Spoonacular
        static let thumbnail = "image"
    }
    
    init(withDictionary dictionary: [String: Any]) {
        title = dictionary[RecipeAPIKeys.title] as? String
        thumbnail = dictionary[RecipeAPIKeys.thumbnail] as? String
        href = dictionary[RecipeAPIKeys.href] as? String

        if let ingredientsArray = dictionary[RecipeAPIKeys.ingredients] as? [[String: Any]] {
            let ingredientNames = ingredientsArray.compactMap { $0["name"] as? String }
            ingredients = ingredientNames.joined(separator: ", ")
        } else {
            ingredients = nil
        }
    }
    
}//End class Recipe

