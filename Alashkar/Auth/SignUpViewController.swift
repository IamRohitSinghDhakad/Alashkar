//
//  SignUpViewController.swift
//  Alashkar
//
//  Created by Rohit SIngh Dhakad on 10/05/24.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfMail: UITextField!
    @IBOutlet weak var tfMobile: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnAlreadyHaveAnAccount: UILabel!
    
    var currentLanguage = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.currentLanguage = Locale.current.languageCode ?? "de"
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tfName.placeholder = "Enter Full Name".localized()
        self.tfMail.placeholder = "Enter Email Address".localized()
        self.tfPassword.placeholder = "Enter Password".localized()
        self.tfPassword.placeholder = "Enter Password".localized()
        self.tfMobile.placeholder = "Enter Mobile".localized()
        self.btnAlreadyHaveAnAccount.text = "Log In Now".localized()
        self.btnSignUp.setTitle("Sign Up".localized(), for: .normal)
    }
    
    @IBAction func btnOnGoBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnOnRegsitration(_ sender: Any) {
        if let validationError = validateAllFields() {
            showAlert(message: validationError)
        } else {
            self.call_WsSignUp()
        }
    }
    
    private func validateAllFields() -> String? {
        if let name = tfName.text, name.isEmpty {
            return "Enter Full Name".localized()
        }
        
        if let email = tfMail.text, !isValidEmail(email) {
            return "Enter Email Address".localized()
        }
        
        if let mobile = tfMobile.text, mobile.isEmpty {
            return "Enter Mobile".localized()
        }
        
        if let password = tfPassword.text, password.isEmpty {
            return "Enter Password".localized()
        }
        
        return nil
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private func isValidMobile(_ mobile: String) -> Bool {
        let mobileRegEx = "^[0-9]{10}$"
        let mobilePred = NSPredicate(format: "SELF MATCHES %@", mobileRegEx)
        return mobilePred.evaluate(with: mobile)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Validation Error".localized(), message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK".localized(), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}


extension SignUpViewController {
    
    func call_WsSignUp(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
        objWebServiceManager.showIndicator()
        
        var dicrParam = [String:Any]()
        
        dicrParam = ["name":self.tfName.text!,
                     "email":self.tfMail.text!,
                     "password":self.tfPassword.text!,
                     "mobile":self.tfMobile.text!,
                     "device_type":"iOS",
                     "lang":currentLanguage,
                     "device_token":objAppShareData.strFirebaseToken]as [String:Any]
        
        
        objWebServiceManager.requestGet(strURL: WsUrl.url_SignUp, params: dicrParam, queryParams: [:], strCustomValidation: "") { (response) in
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            print(response)
            if status == MessageConstant.k_StatusCode{
                if let user_details  = response["result"] as? [String:Any] {
                    
                    objAppShareData.SaveUpdateUserInfoFromAppshareData(userDetail: user_details)
                    objAppShareData.fetchUserInfoFromAppshareData()
                    self.makeRootControllerHome()
                    
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
