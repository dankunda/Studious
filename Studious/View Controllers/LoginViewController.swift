//
//  LoginViewController.swift
//  Studious
//
//  Created by Daniel Ankunda on 2/12/20.
//  Copyright © 2020 Daniel Ankunda. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var goBackButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.goBackButton.layer.cornerRadius = 16
        self.loginButton.layer.cornerRadius = 8
        setUpElements()
        
    }
    
    func setUpElements() {
        //        Hide the error label
        errorLabel.alpha = 0
        
    }
    
    func validateFields() -> String? {
        
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all required fields."
        }
        
        return nil
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func loginTapped(_ sender: Any) {
        
        let error = validateFields()
        
        if error != nil {
            
            // if there's something wrong with fields, show error message
            showError(error!)
        }
        else {
            
            // clean user input data in text fields
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // sign in user
            Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
                
                if err != nil {
                    // couldn't sign in
                    self.showError("Error, double check your credentials")
                }
                else {
                    // transition to home screen/view
                    self.transitionToHome()
                    
                }
            }
        }
        
    }
    
    
    
    func showError(_ message:String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome() {
        
        let homeViewController = storyboard?.instantiateViewController(identifier: "HomeVC") as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
    
}
