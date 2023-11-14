//
//  RecipeFetchService.swift
//  recipeapp
//
//  Created by Lana Do on 11/13/23.
//

import Foundation

class RecipeFetchService {
    
    // Base URL for Spoonacular API
    let baseURL = "https://api.spoonacular.com/recipes"
    let apiKey = "3857cfd46a694bcba671969e6bf77753" // Replace with your actual API key
    
    typealias RecipeResultDictionary = ([Recipe]) -> Void
    
    // Fetches recipes by ingredients
    func fetchRecipe(withIngredients ingredients: String, completion: @escaping RecipeResultDictionary) {
        let ingredientsEncoded = ingredients.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = URL(string: "\(baseURL)/findByIngredients?ingredients=\(ingredientsEncoded)&number=10&apiKey=\(apiKey)")
        performNetworkCall(with: url, completion: completion)
    }
    
    // Fetches recipes by recipe name
    func fetchRecipe(withRecipeName recipeName: String, completion: @escaping RecipeResultDictionary) {
        let recipeNameEncoded = recipeName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = URL(string: "\(baseURL)/complexSearch?query=\(recipeNameEncoded)&number=10&apiKey=\(apiKey)")
        performNetworkCall(with: url, completion: completion)
    }
    
    // Fetches recipes by both ingredients and recipe name
    func fetchRecipe(withIngredients ingredients: String, recipeName: String, completion: @escaping RecipeResultDictionary) {
        let ingredientsEncoded = ingredients.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let recipeNameEncoded = recipeName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = URL(string: "\(baseURL)/complexSearch?query=\(recipeNameEncoded)&includeIngredients=\(ingredientsEncoded)&number=10&apiKey=\(apiKey)")
        performNetworkCall(with: url, completion: completion)
    }
    
    // Generic network call function
    private func performNetworkCall(with url: URL?, completion: @escaping RecipeResultDictionary) {
        guard let url = url else { return }
        let networkCall = Network(url: url)
        
        networkCall.downloadJSONData { (jsonResponse) in
            print("Raw API Response: \(jsonResponse)")
            var recipes = [Recipe]()
            // Processing the JSON response according to Spoonacular's format
            if let jsonArray = jsonResponse as? [[String: Any]] {
                for item in jsonArray {
                    let recipe = Recipe(withDictionary: item)
                    recipes.append(recipe)
                }
                completion(recipes)
            }
        }
    }
    
    // Ensure that the NetworkProcessor and Recipe classes are updated
    // to match the requirements of the Spoonacular API.
}

