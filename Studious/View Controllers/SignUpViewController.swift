//
//  SignUpViewController.swift
//  Studious
//
//  Created by Daniel Ankunda on 2/12/20.
//  Copyright © 2020 Daniel Ankunda. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var majorTextField: UITextField!
    
    @IBOutlet weak var classesTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var goBackButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
        
    }
    
    func setUpElements() {
        
        // Hide the error label
        errorLabel.alpha = 0
        
    }
    
    // Check fields are filled in and accurate;
    // if everything is correct, return nil. Otherwise return error message.
    func validateFields() -> String? {
        
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || majorTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "You must fill in all the required fields."
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

    
    @IBAction func signUpTapped(_ sender: Any) {
        
        let error = validateFields()
        
        if error != nil {
            
            // if there's something wrong with fields, show error message
            showError(error!)
        }
        else {
            
            // create cleaned versions of the user input data, free of whitespaces and new lines
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let major = majorTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                // check for errors
                if err != nil {
                    // there was an error creating the user
                    self.showError("Error creating user")
                }
                else {
                    // user was created successfully, store first name and last name
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["first_name": firstName, "last_name": lastName, "major": major, "uid": result!.user.uid])
                        
                    }
                    
                // transition to home screen/view
                self.transitionToHome()
                    
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
