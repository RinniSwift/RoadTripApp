//
//  LoginViewController.swift
//  RoadTrip
//
//  Created by Rinni Swift on 12/8/18.
//  Copyright © 2018 sarinswift. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    
    // MARK: Actions
    @IBAction func logInButtonTapped(_ sender: UIButton) {
        if emailTextField.text == "" || passwordTextField.text == "" {
            displayAlert(title: "Missing Information", message: "Please provide a valid email and password for your account.")
        } else {
            if let email = emailTextField.text {
                if let password = passwordTextField.text {
                    Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                        if error != nil {
                            self.displayAlert(title: "Error", message: error!.localizedDescription)
                        } else {
                            // success sign in
                            print("sign in succed!")
                            self.performSegue(withIdentifier: "loginToMap", sender: nil)
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func createAccountButtonTapped(_ sender: UIButton) {
        if emailTextField.text == "" || passwordTextField.text == "" {
            displayAlert(title: "Missing Information", message: "Please provide both an email and password for your account.")
        }
        
        if let email = emailTextField.text {
            if (passwordTextField.text?.count)! >= 6 {
                print("password more than 6 characters")
                if let password = passwordTextField.text {
                    Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
                        guard let user = authResult?.user else { return }
                        if error != nil {
                            self.displayAlert(title: "Error", message: error!.localizedDescription)
                        } else {
                            // success account created
                            print("created account!")
                            self.performSegue(withIdentifier: "loginToMap", sender: nil)
                        }
                    }
                }
            } else {
                displayAlert(title: "Error", message: "The password must be 6 characters long or more.")
            }
        }
        
    }
    
    // MARK: Functions
    func displayAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
}
