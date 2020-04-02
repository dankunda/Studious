//
//  HomeViewController.swift
//  Studious
//
//  Created by Daniel Ankunda on 2/12/20.
//  Copyright © 2020 Daniel Ankunda. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var filterButton: UIButton!
    
    @IBOutlet weak var userTableView: UITableView!
    
    var usersArray = [String]()
    var db: Firestore!
    var users = ["tcook@icloud.com", "jdoe@syr.edu", "dan.am@aol.com"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userTableView.delegate = self
        userTableView.dataSource = self
        userTableView.register(UserCell.self,forCellReuseIdentifier:"userCell")
        // Do any additional setup after loading the view.
        db = Firestore.firestore()
//        loadData()
        
        for user in users {
            self.usersArray.append(user)
        }
        
    }
    
    
    func loadData() {
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    
                    print("Here's all the document ID's: \(document.documentID)")

                    self.usersArray.append(document.documentID)
                }
            }
            print(self.usersArray)

        }
        self.userTableView.reloadData()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("Tableview setup \(usersArray.count)")
        return usersArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userTableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserCell
        let user1 = usersArray[indexPath.row]

        cell.fullNameLabel.text = user1
        print("Array is populated \(usersArray)")

        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
