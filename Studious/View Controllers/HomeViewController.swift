//
//  HomeViewController.swift
//  Studious
//
//  Created by Daniel Ankunda on 2/12/20.
//  Copyright © 2020 Daniel Ankunda. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var filterButton: UIButton!
    
    @IBOutlet weak var userTableView: UITableView!
    
    var fNamesArray = [String]()
    var lNamesArray = [String]()
    var majorsArray = [String]()
    var classesArray = [String]()
    var hoursArray = [NSNumber]()
    var emailsArray = [String]()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        userTableView.delegate = self
        userTableView.dataSource = self
        // Do any additional setup after loading the view.
        
        loadData()
        
    }
    
    
    func loadData() {
        
        let db = Firestore.firestore()
        
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {

                    self.fNamesArray.append((document.data()["first_name"] as? String ?? "None"))
                    self.lNamesArray.append((document.data()["last_name"] as? String ?? "None"))
                    self.majorsArray.append((document.data()["major"] as? String ?? "None"))
                    self.classesArray.append((document.data()["classes"] as? String ?? "None"))
                    let hoursHolder = document.data()["hours"] as? NSNumber
                    self.hoursArray.append(hoursHolder ?? 0)
                    self.emailsArray.append(document.documentID)
                    
                }
                
            }
            self.userTableView.reloadData()
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 99
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailsArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = userTableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserCell

        let fname = fNamesArray[indexPath.row]
        let lname = lNamesArray[indexPath.row]
        let major = majorsArray[indexPath.row]

        cell.nameLabel.text = fname + " " + lname
        cell.majorLabel.text = "\(major) Student"

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailViewController
        
        vc?.fname = fNamesArray[indexPath.row]
        vc?.lname = lNamesArray[indexPath.row]
        vc?.major = majorsArray[indexPath.row]
        vc?.classes = classesArray[indexPath.row]
        vc?.hours = hoursArray[indexPath.row]
        vc?.email = emailsArray[indexPath.row]
        
        view.window?.rootViewController = vc
        view.window?.makeKeyAndVisible()
    }
    



}
