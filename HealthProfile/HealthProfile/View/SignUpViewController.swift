//
//  SignUpViewController.swift
//  HealthProfile
//
//  Created by Gimin Moon on 2/17/18.
//  Copyright © 2018 Gimin Moon. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: UIViewController, UITextFieldDelegate{
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var reenterPasswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailField.delegate = self
        self.passwordField.delegate = self
        self.reenterPasswordField.delegate = self
        self.hidKeyBoardWhenTapped()
        self.ref = Database.database().reference()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        //dismiss when its tapped
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createAccountTapped(_ sender: UIButton) {
        if passwordField.text == reenterPasswordField.text{
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!, completion: {(user,error) in
                if error != nil {
                    let signuperrorAlert = UIAlertController(title: "Sign Up Error", message: "\(String(describing: error?.localizedDescription)) Please try again later", preferredStyle: .alert)
                    signuperrorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(signuperrorAlert, animated: true, completion: nil)
                    return
                }
                print("hi")
                let user = Auth.auth().currentUser
                guard let uid = user?.uid else{
                    return
                }
                 print("hi2")
                //use ref from initialized in viewdidLoad
                let userReference = self.ref.child("users").child(uid)
                let values = ["email": self.emailField.text]
                userReference.updateChildValues(values, withCompletionBlock: {(err,ref) in
                    if err != nil {
                        print(err)
                        return
                    }
                    print("saved user in firebase")
                })
                self.dismiss(animated: true, completion: nil)
            })
        }
        else{
            let passNotMatch = UIAlertController(title: "Error!", message: "Passwords Do Not Match! Please try again", preferredStyle: .alert)
            passNotMatch.addAction(UIAlertAction(title: "OK", style: .default, handler: {(action) in
                self.passwordField.text = ""
                self.reenterPasswordField.text = ""
            }))
            present(passNotMatch, animated: true, completion: nil)
            
        }
    }

    // know this -> first responder
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        if textField == emailField{
            passwordField.becomeFirstResponder()
        } else if textField == passwordField{
            reenterPasswordField.becomeFirstResponder()
        } else{
            textField.resignFirstResponder()
        }
        return true
    }
}

