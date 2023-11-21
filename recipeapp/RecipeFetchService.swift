//
//  RecipeFetchService.swift
//  recipeapp
//
//  Created by Lana Do on 11/13/23.
//

import Foundation

struct RecipeFetchService {
    //search by name
    func fetchRecipes(withRecipeName: String, completion: @escaping (Result<[Recipe.RecipeDescription], Error>) -> Void) {
        let urlString = "https://api.spoonacular.com/recipes/complexSearch?query=\(withRecipeName)&number=2&apiKey=3857cfd46a694bcba671969e6bf77753"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
                return
            }
            if let rawApiResponse = String(data: data, encoding: .utf8) {
                print("API Response: \(rawApiResponse)")
            }
            do {
                let recipeData = try JSONDecoder().decode(Recipe.self, from: data)
                completion(.success(recipeData.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    func searchRecipeById(by id: Int, results: @escaping (Recipe.RecipeDescription) -> Void) {
        let urlString = "https://api.spoonacular.com/recipes/\(id)/information?includeNutrition=true&apiKey=3857cfd46a694bcba671969e6bf77753"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print("Error: \(error!.localizedDescription)")
                return
            }
            
            // Print the raw data for debugging
            if let data = data {
                print("Raw data: \(String(data: data, encoding: .utf8) ?? "No data")")
                
                do {
                    let decodedData = try JSONDecoder().decode(Recipe.RecipeDescription.self, from: data)
                    results(decodedData)
                } catch {
                    print("Decoding error: \(error)")
                }
            } else {
                print("No data received from API")
            }
        }.resume()
    }
}



