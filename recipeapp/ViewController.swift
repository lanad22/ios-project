//
//  ViewController.swift
//  recipeapp
//
//  Created by Lana Do on 11/6/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBAction func loginButtonTapped(_ sender: Any) {
        let email = emailTextField.text
        let password = passwordTextField.text
    }
}

