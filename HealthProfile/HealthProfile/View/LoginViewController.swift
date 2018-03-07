//
//  LoginViewController.swift
//  HealthProfile
//
//  Created by Gimin Moon on 2/17/18.
//  Copyright © 2018 Gimin Moon. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailField.delegate = self
        self.passwordField.delegate = self
        self.hidKeyBoardWhenTapped()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logInButtonTapped(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!){
            (user, error) in
            //wrong error credientials
            if(error != nil){
                let loginerrorAlert = UIAlertController(title: "Login error!", message: "\(error!.localizedDescription) Please try again.", preferredStyle: .alert)
                loginerrorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(loginerrorAlert, animated: true, completion: nil)
                return
            }
            //if logged in, move on to the next viewcontroller
            //self.performSegue(withIdentifier: "ToHomeScreen", sender: nil)
            
            let storyboard:UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
            let homeVC:UINavigationController = storyboard.instantiateViewController(withIdentifier: "mainNavigationController") as! UINavigationController
            self.present(homeVC, animated: true, completion: nil)
            
    
            }
        }
    
    @IBAction func forgotPasswordTapped(_ sender: Any) {
        let forgotPwAlert = UIAlertController(title:"Forgot Password?", message : "Enter your email to reset your password", preferredStyle: .alert)
        forgotPwAlert.addTextField{(textField) in textField.placeholder = "Enter your email address"
        }
        forgotPwAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        forgotPwAlert.addAction(UIAlertAction(title: "Reset Password", style: .default, handler: {(action) in
            let resetEmail = forgotPwAlert.textFields?.first?.text
            Auth.auth().sendPasswordReset(withEmail: resetEmail!, completion: {(error) in
                if error != nil{
                    let resetFailedAlert = UIAlertController(title: "Reset Failed", message: "Error: \(String(describing: error?.localizedDescription))", preferredStyle: .alert)
                    resetFailedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(resetFailedAlert, animated: true, completion: nil)
                }else{
                    let resetEmalSentAlert = UIAlertController(title: "Reset Email Sent", message: "A password reset email has been sent to your registered email. Please check your email for further password reset instructions", preferredStyle: .alert)
                    
                    //creates an ok button so when the user taps, the alert goes away
                    resetEmalSentAlert.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
                    //need to present to show it to the user
                    self.present(resetEmalSentAlert, animated: true, completion: nil)
                }
            })
        }))
        self.present(forgotPwAlert, animated: true, completion: nil)
    }
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.emailField{
            passwordField.becomeFirstResponder()
        }else{
            self.emailField.becomeFirstResponder()
        }
        return true
    }
}

extension UIViewController{
    func hidKeyBoardWhenTapped(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}
