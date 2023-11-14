//
//  HomeViewController.swift
//  recipeapp
//
//  Created by Lana Do on 11/13/23.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var foodNameTextField: UITextField!
    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var resultCountButton: UIButton!
    @IBOutlet weak var getFoodButton: UIButton!
    
    var recipes : [Recipe]?
    
    //First Loading Func
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //Get Recipes when Tapped
    @IBAction func getFoodTapped(_ sender: Any) {
        
        let fetcher = RecipeFetchService()
        
        if !(foodNameTextField.text?.isEmpty)! && (ingredientTextField.text?.isEmpty)! {
            let foodName = foodNameTextField.text!
            fetcher.fetchRecipe(withRecipeName: foodName, completion: { (fetchedRecipes) in
                DispatchQueue.main.async {
                    print("Inside main thread") // Check if DispatchQueue is working properly
                    
                    self.recipes = fetchedRecipes
                    self.resultCountButton.setTitle("Result: \(self.recipes?.count ?? 0)", for: .normal)
                    
                    // Print the recipes
                    if let recipes = self.recipes, !recipes.isEmpty {
                        print("Fetched recipes: \(recipes)")
                    } else {
                        print("No recipes were fetched or there was a parsing error")
                    }
                }
            })
        }else if (foodNameTextField.text?.isEmpty)! && !(ingredientTextField.text?.isEmpty)!{
            let ingredients = ingredientTextField.text!
            fetcher.fetchRecipe(withIngredients: ingredients, completion: { (fetchedRecipes) in
                DispatchQueue.main.async {
                    self.recipes = fetchedRecipes
                    self.resultCountButton.setTitle("Result: \(self.recipes!.count)", for: .normal)
                    print("Fetched recipes by name: \(self.recipes)")
                }
            })
            
        }else if !(foodNameTextField.text?.isEmpty)! && !(ingredientTextField.text?.isEmpty)!{
            let ingredients = ingredientTextField.text!
            let foodName = foodNameTextField.text!
            fetcher.fetchRecipe(withIngredients: ingredients, recipeName: foodName, completion: { (fetchedRecipe) in
                DispatchQueue.main.async {
                    self.recipes = fetchedRecipe
                    self.resultCountButton.setTitle("Result: \(self.recipes!.count)", for: .normal)
                    print("Fetched recipes by name: \(self.recipes)")
                }
            })
            
        }else {
            print("Fields are Empty")
            (sender as! UIButton).isEnabled = false
            (sender as! UIButton).backgroundColor = UIColor.darkGray
        }
        
        
        
    }
    
    //Reset the fields and Button state
    @IBAction func resetButtonTapped(_ sender: Any) {
        foodNameTextField.text = ""
        foodNameTextField.placeholder = "Eg: Banana or Banana+bread"
        ingredientTextField.text = ""
        ingredientTextField.placeholder = "Eg: onions,garlic,peas"
        recipes = [Recipe]()
        getFoodButton.isEnabled = true
        getFoodButton.backgroundColor = UIColor.orange
        resultCountButton.titleLabel?.text = "Results: "
    }
    
    //Dismiss TextFields
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //Populate Recipe For TableView
    func populateNextViewWithRecipes(recipes: [Recipe]){
        let tableVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RecipeTableViewController")
    }
    
    
    //Show Result Tapped
    @IBAction func showResultTapped(_ sender: Any) {
        //performSegue(withIdentifier: "toTableView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTableView" {
            if let destinationVC = segue.destination as? RecipeTableViewController {
                destinationVC.recipes = self.recipes
                
            }
        }
    }
    
    
}

