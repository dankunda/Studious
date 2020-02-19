//
//  SignUpViewController.swift
//  Studious
//
//  Created by Daniel Ankunda on 2/12/20.
//  Copyright © 2020 Daniel Ankunda. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
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
        //        Hide the error label
        errorLabel.alpha = 0
        
    }
    
    // Check fields are filled in and accurate;
    // if everything is correct, return nil. Otherwise return error message.
    func validateFields() -> String? {
        
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
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
            
            // create the user
            
            
        }
        
    }
    
    
    
    func showError(_ message:String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
}
