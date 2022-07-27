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
        performSegue(withIdentifier: "toTBC", sender: nil)
    }
    
    @IBAction func signupBtn(_ sender: Any) {
        if emailTxt.text != "" && passwordTxt.text != "" {
            Auth.auth().createUser(withEmail: emailTxt.text!, password: passwordTxt.text!) { authData, error in
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

