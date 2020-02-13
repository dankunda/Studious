//
//  ViewController.swift
//  Studious
//
//  Created by Daniel Ankunda on 2/9/20.
//  Copyright © 2020 Daniel Ankunda. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let ref = Database.database().reference()
        ref.childByAutoId().setValue(["name" : "GDtheKID", "Role" : "C.E.O."])
        ref.childByAutoId().setValue(["name" : "Jared", "Role" : "Jester"])
    }


}

