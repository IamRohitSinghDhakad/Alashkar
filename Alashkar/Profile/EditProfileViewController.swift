//
//  EditProfileViewController.swift
//  OneLastChance
//
//  Created by Dhakad, Rohit Singh on 03/05/24.
//

import UIKit

class EditProfileViewController: UIViewController,UINavigationControllerDelegate {

    @IBOutlet weak var imgVwUser: UIImageView!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfMobile: UITextField!
    @IBOutlet weak var lblEditProfile: UILabel!
    @IBOutlet weak var lblAddYourPhoto: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmailAddress: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var btnSubmit: UIButton!
    
    var imagePicker = UIImagePickerController()
    var pickedImage:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.lblEditProfile.text = "Profile".localized()
        self.imagePicker.delegate = self
        self.lblAddYourPhoto.text = "Add your professional photo".localized()
        self.lblName.text = "Full Name".localized()
        self.lblEmailAddress.text = "Email".localized()
        self.lblPhone.text = "Phone Number".localized()
        self.btnSubmit.setTitle("UPDATE".localized(), for: .normal)
        
        self.tfName.placeholder = "Full Name".localized()
        self.tfEmail.placeholder = "Email".localized()
        self.tfMobile.placeholder = "Phone Number".localized()
        
        if objAppShareData.currentLanguage == "ar"{
            self.tfName.textAlignment = .right
            self.tfEmail.textAlignment = .right
            self.tfMobile.textAlignment = .right
        }else{
            self.tfName.textAlignment = .left
            self.tfEmail.textAlignment = .left
            self.tfMobile.textAlignment = .left
        }
    }
    

    @IBAction func btnOnBack(_ sender: Any) {
        self.sideMenuController?.revealMenu()
    }
   
    @IBAction func btnOnUploadPicture(_ sender: Any) {
        self.setImage()
    }
    
    @IBAction func btnOnSubmit(_ sender: Any) {
        
    }
    
}


// MARK:- UIImage Picker Delegate
extension EditProfileViewController: UIImagePickerControllerDelegate{
    
    func setImage(){
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            self.openCamera()
        }
        
        let galleryAction = UIAlertAction(title: "Gallery", style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            self.openGallery()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        {
            UIAlertAction in
        }
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        alert.popoverPresentationController?.sourceView = self.view
        self.present(alert, animated: true, completion: nil)
    }
    
    // Open camera
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.modalPresentationStyle = .fullScreen
            self .present(imagePicker, animated: true, completion: nil)
        } else {
            self.openGallery()
        }
    }
    
    // Open gallery
    func openGallery()
    {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.modalPresentationStyle = .fullScreen
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            self.pickedImage = editedImage
            self.imgVwUser.image = self.pickedImage
            
            imagePicker.dismiss(animated: true, completion: nil)
        } else if let originalImage = info[.originalImage] as? UIImage {
            self.pickedImage = originalImage
            self.imgVwUser.image = pickedImage
            imagePicker.dismiss(animated: true, completion: nil)
        }
    }
    
    func cornerImage(image: UIImageView, color: UIColor ,width: CGFloat){
        image.layer.cornerRadius = image.layer.frame.size.height / 2
        image.layer.masksToBounds = false
        image.layer.borderColor = color.cgColor
        image.layer.borderWidth = width
        
    }

}

extension EditProfileViewController {
    
    func callWebserviceForUpdateProfile(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        objWebServiceManager.showIndicator()
        self.view.endEditing(true)
        
        var imageData = [Data]()
        var imgData : Data?
        if self.pickedImage != nil{
            imgData = (self.pickedImage?.jpegData(compressionQuality: 0.5))!
        }
        else {
            imgData = (self.imgVwUser.image?.jpegData(compressionQuality: 0.5))!
        }
        imageData.append(imgData!)
        
        let imageParam = ["image"]
        
        let dicrParam = [
            "user_id":objAppShareData.UserDetail.strUserId ?? "",
            "name":self.tfName.text!,
            "email":self.tfEmail.text!,
            "mobile":self.tfMobile.text!,
            "lang":""]as [String:Any]
        
        print(dicrParam)
        
        objWebServiceManager.uploadMultipartWithImagesData(strURL: WsUrl.url_UpdateProfile, params: dicrParam, showIndicator: true, customValidation: "", imageData: imgData, imageToUpload: imageData, imagesParam: imageParam, fileName: "image", mimeType: "image/jpeg") { (response) in
            objWebServiceManager.hideIndicator()
            print(response)
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            
            if status == MessageConstant.k_StatusCode{
                
                guard let user_details  = response["result"] as? [String:Any] else{
                    return
                }
                
                objAlert.showAlertSingleButtonCallBack(alertBtn: "OK", title: "", message: "Updated Succesfully", controller: self) {
                    
                }
                
                
            }else{
                objWebServiceManager.hideIndicator()
                objAlert.showAlert(message: message ?? "", title: "Alert", controller: self)
            }
        } failure: { (Error) in
            print(Error)
        }
    }
    
}
