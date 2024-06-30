//
//  EditProfileViewController.swift
//  OneLastChance
//
//  Created by Dhakad, Rohit Singh on 03/05/24.
//

import UIKit
import SDWebImage

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
    
    var objUser : UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imagePicker.delegate = self
        self.call_GetProfile_Api()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        if validateInputs() {
            // Call your API submission function here
            self.callWebserviceForUpdateProfile()
        }
    }
    
    func validateInputs() -> Bool {
           guard let name = tfName.text, !name.isEmpty else {
               showAlert(message: "Enter Full Name".localized())
               return false
           }
           
           guard let mobile = tfMobile.text, !mobile.isEmpty else {
               showAlert(message: "Enter Mobile".localized())
               return false
           }
           
           return true
       }
       
       func isValidMobileNumber(_ mobile: String) -> Bool {
           let mobileRegEx = "^[0-9]{10}$"
           let mobileTest = NSPredicate(format:"SELF MATCHES %@", mobileRegEx)
           return mobileTest.evaluate(with: mobile)
       }
       
       func showAlert(message: String) {
           let alert = UIAlertController(title: "Validation Error".localized(), message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK".localized(), style: .default, handler: nil))
           self.present(alert, animated: true, completion: nil)
       }
    
}


// MARK:- UIImage Picker Delegate
extension EditProfileViewController: UIImagePickerControllerDelegate{
    
    func setImage(){
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        let alert:UIAlertController=UIAlertController(title: "Choose Image".localized(), message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let cameraAction = UIAlertAction(title: "Camera".localized(), style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            self.openCamera()
        }
        
        let galleryAction = UIAlertAction(title: "Gallery".localized(), style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            self.openGallery()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel".localized(), style: UIAlertAction.Style.cancel)
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
        
        let imageParam = ["user_image"]
        
        let dicrParam = [
            "user_id":objAppShareData.UserDetail.strUserId ?? "",
            "name":self.tfName.text!,
            "email":self.tfEmail.text!,
            "mobile":self.tfMobile.text!,
            "lang":""]as [String:Any]
        
        print(dicrParam)
        
        objWebServiceManager.uploadMultipartWithImagesData(strURL: WsUrl.url_UpdateProfile, params: dicrParam, showIndicator: true, customValidation: "", imageData: imgData, imageToUpload: imageData, imagesParam: imageParam, fileName: "user_image", mimeType: "image/jpeg") { (response) in
            objWebServiceManager.hideIndicator()
            print(response)
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            
            if status == MessageConstant.k_StatusCode{
                
                guard response["result"] is [String:Any] else{
                    return
                }
                
                objAlert.showAlertSingleButtonCallBack(alertBtn: "OK".localized(), title: "", message: "Updated Succesfully".localized(), controller: self) {
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    let vc = (self.mainStoryboard.instantiateViewController(withIdentifier: "SideMenuController") as? SideMenuController)!
                    let navController = UINavigationController(rootViewController: vc)
                    navController.isNavigationBarHidden = true
                    appDelegate.window?.rootViewController = navController
                }
                
                
            }else{
                objWebServiceManager.hideIndicator()
                objAlert.showAlert(message: message ?? "", title: "Alert", controller: self)
            }
        } failure: { (Error) in
            print(Error)
        }
    }
    
    
    
    func call_GetProfile_Api(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
        objWebServiceManager.showIndicator()
        
        let dicrParam = ["user_id":objAppShareData.UserDetail.strUserId!]as [String:Any]
        
        objWebServiceManager.requestPost(strURL: WsUrl.url_getUserProfile, queryParams: [:], params: dicrParam, strCustomValidation: "", showIndicator: false) { (response) in
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            print(response)
            
            if status == MessageConstant.k_StatusCode{
                if let user_details  = response["result"] as? [String:Any] {
//
                    self.objUser = UserModel.init(from: user_details)

                    self.tfName.text = self.objUser?.name
                    self.tfEmail.text = self.objUser?.email
                    self.tfMobile.text = self.objUser?.mobile

                    let imageUrl  = self.objUser?.userImage
                    if imageUrl != "" {
                        let url = URL(string: imageUrl ?? "")
                        self.imgVwUser.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "image"))
                    }else{
                        self.imgVwUser.image = #imageLiteral(resourceName: "image")
                    }
                    
                }
                else {
                    objAlert.showAlert(message: "Something went wrong!", title: "", controller: self)
                }
            }else{
                objWebServiceManager.hideIndicator()
                if let msgg = response["result"]as? String{
                    objAlert.showAlert(message: msgg, title: "", controller: self)
                }else{
                    objAlert.showAlert(message: message ?? "", title: "", controller: self)
                }
            }
            
            
        } failure: { (Error) in
            //  print(Error)
            objWebServiceManager.hideIndicator()
        }
    }
    
}
