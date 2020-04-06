//
//  DetailViewController.swift
//  Studious
//
//  Created by Daniel Ankunda on 4/3/20.
//  Copyright © 2020 Daniel Ankunda. All rights reserved.
//

import UIKit
import MessageUI
import Firebase

class DetailViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var goBackButton: UIButton!
    
    @IBOutlet weak var studentsProfileLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var majorsInLabel: UILabel!
    
    @IBOutlet weak var strongestClassesLabel: UILabel!
    
    @IBOutlet weak var hoursLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var emailToTutorButton: UIButton!
    
    @IBOutlet weak var emailFromTutorButton: UIButton!
    
    var fname = ""
    var lname = ""
    var major = ""
    var classes = ""
    var hours = NSNumber()
    var email = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.emailFromTutorButton.layer.cornerRadius = 12
        self.emailToTutorButton.layer.cornerRadius = 12
        self.goBackButton.layer.cornerRadius = 16
        
        studentsProfileLabel.text = "\(fname)'s Profile"
        nameLabel.text = fname + " " + lname
        majorsInLabel.text = "Majors in \(major)"
        strongestClassesLabel.text = "Strongest Class(es) are \(classes)"
        hoursLabel.text = "Hours: \(hours)"
        emailLabel.text = email
        emailToTutorButton.setTitle("Request to tutor \(fname)", for: .normal)
        emailFromTutorButton.setTitle("Request tutoring from \(fname)", for: .normal)
        
    }
    
    
    
    @IBAction func emailButtonTapped(_ sender: Any) {
        // Must be run on a device that can send mail
        showMailComposer()
        
        let user = Auth.auth().currentUser
        let uemail = user?.email
        let db = Firestore.firestore()
        
        
        db.collection("users").document(uemail!).updateData(["hours": FieldValue.increment(Int64(1))])
        
    }
    
    @IBAction func email2ButtonTapped(_ sender: Any) {
        
        let user = Auth.auth().currentUser
        let uemail = user?.email
        let db = Firestore.firestore()
        let dRef = db.collection("users").document(uemail!)
        
        dRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()
                
                let newhours = dataDescription!["hours"] as? Int64
                
                if newhours! < Int64(1) {
                    let alertController = UIAlertController(title: "Not enough hours", message: "Please acquire more hours by tutoring others before you request to be tutored.", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: .default))

                    self.present(alertController, animated: true, completion: nil)
                    
                } else {
                    
                    self.showMailComposer2()
                    
                    db.collection("users").document(uemail!).updateData(["hours": FieldValue.increment(Int64(-1))])
                    
                }
            }
            
        }
        
    }
        
    
    
    
    
    @IBAction func backTapped(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as? HomeViewController
        
        view.window?.rootViewController = vc
        view.window?.makeKeyAndVisible()
    }
    
    
    
    
    func showMailComposer() {
        // make sure current device can send mail
        guard MFMailComposeViewController.canSendMail() else {
            return
        }
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients([email])
        composer.setSubject("I'd like to tutor you.")
        composer.setMessageBody("Hey \(fname), I saw your profile on Studious and I'd like to set up a tutoring session!", isHTML: false)
        
        present(composer, animated: true)
    }
    
    
    func showMailComposer2() {
        // make sure current device can send mail
        guard MFMailComposeViewController.canSendMail() else {
            return
        }
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients([email])
        composer.setSubject("I'd like for you to tutor me.")
        composer.setMessageBody("Hey \(fname), I saw your profile on Studious and I'd like to set up a tutoring session!\nI could really use your help!", isHTML: false)
        
        present(composer, animated: true)
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        if let _ = error {
            controller.dismiss(animated: true)
            
        }
        
        controller.dismiss(animated: true)
    }
    
    
}
