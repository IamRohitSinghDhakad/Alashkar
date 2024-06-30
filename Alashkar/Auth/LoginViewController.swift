//
//  LoginViewController.swift
//  Alashkar
//
//  Created by Rohit SIngh Dhakad on 10/05/24.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnLogIn: UIButton!
    @IBOutlet weak var btnForGotPassword: UIButton!
    @IBOutlet weak var lblAlreadyhaveAnaccount: UILabel!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tfEmail.placeholder = "Email Or Mobile Number".localized()
        self.tfPassword.placeholder = "Password".localized()
        self.lblAlreadyhaveAnaccount.text = "Sign Up Now".localized()
        self.btnLogIn.setTitle("Log In".localized(), for: .normal)
        self.btnForGotPassword.setTitle("Forgot Password?".localized(), for: .normal)
        
    }
    
    
    @IBAction func btnOnLogin(_ sender: Any) {
        
        if self.validateFields(){
            self.call_WsLogin()
        }
    }
    
    @IBAction func btnOnGoToRegistration(_ sender: Any) {
        pushVc(viewConterlerId: "SignUpViewController")
    }
    
    @IBAction func btnOnForgotPassword(_ sender: Any) {
        pushVc(viewConterlerId: "ForgotPasswordViewController")
    }
    
    func validateFields() -> Bool {
        guard let email = tfEmail.text, !email.isEmpty else {
            // Show an error message for empty email
            objAlert.showAlert(message: "Please Enter Email".localized(), controller: self)
            return false
        }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        guard emailPred.evaluate(with: email) else {
            // Show an error message for invalid email format
            objAlert.showAlert(message: "Email is not valid".localized(), controller: self)
            return false
        }
        
        guard let password = tfPassword.text, !password.isEmpty else {
            // Show an error message for empty password
            objAlert.showAlert(message: "Please Enter Password".localized(), controller: self)
            return false
        }
        
        // All validations pass
        return true
    }
    
    
}


extension LoginViewController {
    
    
    func call_WsLogin(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
        objWebServiceManager.showIndicator()
        
        var dicrParam = [String:Any]()

            dicrParam = ["username":self.tfEmail.text!,
                         "password":self.tfPassword.text!,
                         "device_type":"iOS",
                         "lang":objAppShareData.currentLanguage,
                         "device_token":objAppShareData.strFirebaseToken]as [String:Any]
        
        
        objWebServiceManager.requestGet(strURL: WsUrl.url_Login, params: dicrParam, queryParams: [:], strCustomValidation: "") { (response) in
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            print(response)
            if status == MessageConstant.k_StatusCode{
                if let user_details  = response["result"] as? [String:Any] {
                    
                    
                    if user_details["status"] as! String == "0"{
                        objAlert.showAlert(message: "Account not found please sign Up".localized(), controller: self)
                    }else{
                        objAppShareData.SaveUpdateUserInfoFromAppshareData(userDetail: user_details)
                        objAppShareData.fetchUserInfoFromAppshareData()
                        self.makeRootControllerHome()
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
    
    func makeRootControllerHome(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let vc = (self.mainStoryboard.instantiateViewController(withIdentifier: "SideMenuController") as? SideMenuController)!
        let navController = UINavigationController(rootViewController: vc)
        navController.isNavigationBarHidden = true
        appDelegate.window?.rootViewController = navController
    }
}
