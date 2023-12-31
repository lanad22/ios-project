//
//  RecipeTableViewController.swift
//  recipeapp
//
//  Created by Lana Do on 11/13/23.
//

import UIKit

class RecipeTableViewController: UITableViewController {

    
    //Class Properties
    var recipes : [Recipe.RecipeDescription]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipes = [Recipe.RecipeDescription]()
        print("Received recipes: \(recipes)")
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
       // return 10
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeViewCell", for: indexPath) as! RecipeTableViewCell
        let recipe = recipes[indexPath.row]
        
        // Set up your cell with recipe data
        cell.configure(with: recipe)
        
        return cell
    }
    
    
    @IBAction func closeTapped(_ sender: Any) {
      navigationController?.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func backTapped(_ sender: Any) {
    navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  performSegue(withIdentifier: "toWebView", sender: indexPath)
    }
    
    // MARK: - Navigation
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWebView" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let webViewVC = segue.destination as? WebViewController
                webViewVC?.urlString = recipes[indexPath.row].href
            }
            
        }
    }*/
    

}
