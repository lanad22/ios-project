//
//  Recipe.swift
//  recipeapp
//
//  Created by Lana Do on 11/13/23.
//


import Foundation

struct Recipe: Decodable {
    let results: [RecipeDescription]
}

// MARK: - results
extension Recipe {
    struct RecipeDescription: Decodable {
        let id: Int
        let title: String
        let image: String?
        /*let instructions: String?
        let readyInMinutes: Int
        let servings: Int
        let extendedIngredients: [Ingredients]
        //let dishTypes: [String]?
        let nutrition: NutritionInfo?*/
    }
    
    //MARK: - extendedIngredients
    struct Ingredients: Decodable {
        let id: Int
        let name: String
        let amount: Double
        let unit: String?
    }
    
    //MARK: - nutrition
    struct NutritionInfo: Decodable {
        let nutrients: [NutrientsDetails]
    }
    
    //MARK: - nutrients
    struct NutrientsDetails: Decodable {
        let amount: Float
    }
}


