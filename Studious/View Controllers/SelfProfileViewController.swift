//
//  SelfProfileViewController.swift
//  Studious
//
//  Created by Daniel Ankunda on 2/26/20.
//  Copyright © 2020 Daniel Ankunda. All rights reserved.
//

import UIKit
import Firebase

class SelfProfileViewController: UIViewController {
    
    @IBOutlet weak var yourNameLabel: UILabel!
    
    @IBOutlet weak var yourEmailLabel: UILabel!
    
    @IBOutlet weak var yourMajorLabel: UILabel!
    
    @IBOutlet weak var yourClassesLabel: UILabel!
    
    @IBOutlet weak var yourHoursLabel: UILabel!
    
    
    override func viewDidLoad() {

        // Do any additional setup after loading the view.
        
        func convertToDictionary(text: String) -> [String: Any]? {
            if let data = text.data(using: .utf8) {
                do {
                    return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                } catch {
                    print(error.localizedDescription)
                }
            }
            return nil
        }
        
        
        let user = Auth.auth().currentUser
        
        if let user = user {
            
            let email = user.email
            
            let db = Firestore.firestore()
            let docRef = db.collection("users").document(email!)
            
            
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let dataDescription = document.data()
                    
                    self.yourNameLabel.text = (dataDescription?["first_name"] as? String)! + " " + (dataDescription?["last_name"] as? String)!
                    self.yourEmailLabel.text = email
                    self.yourMajorLabel.text = dataDescription?["major"] as? String
                    self.yourClassesLabel.text = dataDescription?["classes"] as? String
                    let hoursHolder = dataDescription?["hours"] as? NSNumber
                    self.yourHoursLabel.text = hoursHolder?.stringValue
                } else {
                    print("Document does not exist")
                    
                }
            }
            
        }
        super.viewDidLoad()
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
