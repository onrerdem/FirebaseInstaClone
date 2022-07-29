//
//  UploadViewController.swift
//  FirebaseInstagram
//
//  Created by onur erdem on 27.07.2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
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
        
        if let imageData = ımageView.image?.jpegData(compressionQuality: 0.5){
            
            let uuid = UUID().uuidString
            let imageRef = mediaFolder.child("media/\(uuid).jpeg")
            imageRef.putData(imageData, metadata: nil) { metaData, putError in
                if putError != nil {
                    self.getAlert(errorInput: putError?.localizedDescription ?? "FirebaseStorage putdata error")
                }else{
                    imageRef.downloadURL { imageUrl, urlError in
                        if let img = imageUrl?.absoluteString as? String{
                            self.commentLbl.text = img
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
