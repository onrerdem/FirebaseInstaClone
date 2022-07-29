//
//  ViewController.swift
//  FirebaseInstagram
//
//  Created by onur erdem on 27.07.2022.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signinBtn(_ sender: Any) {
        
        let email = emailTxt.text
        let password = passwordTxt.text
        
        if (email != "") && (password != "") {
            Auth.auth().signIn(withEmail: email!, password: password!) { dataResult, signinError in
                if signinError != nil {
                    self.getAlert(errorInput: signinError?.localizedDescription ?? "Singin Error")
                } else {
                    self.performSegue(withIdentifier: "toTBC", sender: nil)
                }
            }
        } else {
            self.getAlert(errorInput: "Email/Password?")
        }
            
        
    }
    
    @IBAction func signupBtn(_ sender: Any) {
        
        let email = emailTxt.text
        let password = passwordTxt.text
        
        if email != "" && password != "" {
            Auth.auth().createUser(withEmail: email!, password: password!) { authData, error in
                if error != nil {
                    self.getAlert(errorInput: error?.localizedDescription ?? "Error")
                    
                }else{
                    self.performSegue(withIdentifier: "toTBC", sender: nil)
                }
            }
        }else{
            self.getAlert(errorInput: "Email/Password?")
        }
    }
    
    func getAlert(errorInput : String) -> Void {
        let alert = UIAlertController(title: "Error", message: errorInput, preferredStyle: UIAlertController.Style.alert)
        let alertBtn = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(alertBtn)
        self.present(alert, animated: true)
        
    }
    
}

