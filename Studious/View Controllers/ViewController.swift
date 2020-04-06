//
//  ViewController.swift
//  Studious
//
//  Created by Daniel Ankunda on 2/9/20.
//  Copyright © 2020 Daniel Ankunda. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.signUpButton.layer.cornerRadius = 8
        self.loginButton.layer.cornerRadius = 8
    

    }


}

