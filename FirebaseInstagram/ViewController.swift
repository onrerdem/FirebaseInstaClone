//
//  ViewController.swift
//  FirebaseInstagram
//
//  Created by onur erdem on 27.07.2022.
//

import UIKit

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
    }
}

