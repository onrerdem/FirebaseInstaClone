//
//  UploadViewController.swift
//  FirebaseInstagram
//
//  Created by onur erdem on 27.07.2022.
//

import UIKit
import FirebaseStorage

class UploadViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var uploadBtn: UIButton!
    @IBOutlet weak var commentLbl: UITextField!
    @IBOutlet weak var ımageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ımageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageSelected))
        ımageView.addGestureRecognizer(gestureRecognizer)
        
        

    }
    
    @objc func imageSelected(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
 
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        ımageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
        
    }
    
    @IBAction func uploadBtn(_ sender: Any) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let mediaFolder = storageRef.child("media")
        
        if let data = ımageView.image?.jpegData(compressionQuality: 0.5){
            
            let uuid = UUID().uuidString
            let imageRef = mediaFolder.child("\(uuid).png")
            
            imageRef.putData(data) { metaData, error in
                if error != nil {
                    self.getAlert(errorInput: error!.localizedDescription)
                }else{
                    imageRef.downloadURL { url, error in
                        if error != nil{
                            self.getAlert(errorInput: error?.localizedDescription ?? "Error")
                        }else{
                            let imageUrl = url?.absoluteString
                            print(imageUrl)
                        }
                        
                    }
                }
            }
        }
            
        
    }
    
    func getAlert(errorInput : String) -> Void {
        
        let alert = UIAlertController(title: "Error", message: errorInput, preferredStyle: UIAlertController.Style.alert)
        let alertBtn = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(alertBtn)
        self.dismiss(animated: true)
        
    }
    
}
