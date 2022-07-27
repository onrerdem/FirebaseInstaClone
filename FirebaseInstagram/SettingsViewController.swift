//
//  SettingsViewController.swift
//  FirebaseInstagram
//
//  Created by onur erdem on 27.07.2022.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {
    @IBOutlet weak var emailLbl: UILabel!
    var email = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutBtn(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toVC", sender: nil)
        } catch  {
            self.getAlert(errorInput: error.localizedDescription)
        }
        
        
    }

    func getAlert(errorInput : String) -> Void {
        let alert = UIAlertController(title: "Error", message: errorInput, preferredStyle: UIAlertController.Style.alert)
        let alertBtn = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(alertBtn)
        self.present(alert, animated: true)
        
    }

}
