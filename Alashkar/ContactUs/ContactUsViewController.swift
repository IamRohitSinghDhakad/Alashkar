//
//  ContactUsViewController.swift
//  OneLastChance
//
//  Created by Dhakad, Rohit Singh on 08/05/24.
//

import UIKit
import MessageUI

class ContactUsViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var tfSubject: UITextField!
    @IBOutlet weak var txtVwMsg: UITextView!
    @IBOutlet weak var lblContactUs: UILabel!
    @IBOutlet weak var lblDontHesistate: UILabel!
    @IBOutlet weak var lblSubject: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var btnContactEmail: UIButton!
    @IBOutlet weak var btnContactMobile: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.lblContactUs.text = "Contact Us".localized()
        self.lblDontHesistate.text = "".localized()
        self.lblSubject.text = "Subject".localized()
        self.lblMessage.text = "Message".localized()
        self.btnSubmit.setTitle("Submit".localized(), for: .normal)
        self.btnContactEmail.setTitle("Contact With Email".localized(), for: .normal)
        self.btnContactMobile.setTitle("Contact With Mobile".localized(), for: .normal)
        
        if objAppShareData.currentLanguage == "ar"{
            self.tfSubject.textAlignment = .right
            self.txtVwMsg.textAlignment = .right
        }else{
            self.tfSubject.textAlignment = .left
            self.txtVwMsg.textAlignment = .left
        }
    }
    

    @IBAction func btnOnBack(_ sender: Any) {
        self.sideMenuController?.revealMenu()
    }
    

    @IBAction func btnOnSUbmit(_ sender: Any) {
        
        self.tfSubject.text = self.tfSubject.text?.trim()
        self.txtVwMsg.text = self.txtVwMsg.text?.trim()
        
        if tfSubject.text == ""{
            objAlert.showAlert(message: "Please enter Subject", controller: self)
        }else  if txtVwMsg.text == ""{
            objAlert.showAlert(message: "Please enter message", controller: self)
        }else{
            self.call_ContactUs_Api()
        }
    }
    
    @IBAction func btnOnMail(_ sender: Any) {
        sendEmail()
    }
    @IBAction func btnOnMobile(_ sender: Any) {
        dialNumber()
    }
    
    func sendEmail() {
           guard MFMailComposeViewController.canSendMail() else {
               // Show alert if mail services are not available
               let alert = UIAlertController(title: "Error", message: "Mail services are not available", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               present(alert, animated: true, completion: nil)
               return
           }
           
           let mailComposeVC = MFMailComposeViewController()
           mailComposeVC.mailComposeDelegate = self
           mailComposeVC.setToRecipients(["info@alashkar-werkstatt.de"]) // Set your demo email ID
           mailComposeVC.setSubject("Subject")
           mailComposeVC.setMessageBody("Message body", isHTML: false)
           
           present(mailComposeVC, animated: true, completion: nil)
       }
    
    func dialNumber() {
            let phoneNumber = "tel://491766871487" // Replace with your phone number
            if let url = URL(string: phoneNumber), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                // Show alert if the dialer cannot be opened
                let alert = UIAlertController(title: "Error", message: "Cannot open the dialer", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        }
    
    // MFMailComposeViewControllerDelegate method
       func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
           controller.dismiss(animated: true, completion: nil)
       }
    
}

extension ContactUsViewController{
    
    func call_ContactUs_Api(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
        objWebServiceManager.showIndicator()
        
        let dicrParam = ["user_id":objAppShareData.UserDetail.strUserId!,
                         "subject":self.tfSubject.text!,
                         "message":self.txtVwMsg.text!,
                         "lang":objAppShareData.currentLanguage]as [String:Any]
        
        objWebServiceManager.requestPost(strURL: WsUrl.url_ContactUs, queryParams: [:], params: dicrParam, strCustomValidation: "", showIndicator: false) { (response) in
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            print(response)
            
            if status == MessageConstant.k_StatusCode{
                if let user_details  = response["result"] as? [[String:Any]] {
                  
                    objAlert.showAlertSingleButtonCallBack(alertBtn: "OK".localized(), title: "", message: "Your request submitted succesfully", controller: self) {
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        let vc = (self.mainStoryboard.instantiateViewController(withIdentifier: "SideMenuController") as? SideMenuController)!
                        let navController = UINavigationController(rootViewController: vc)
                        navController.isNavigationBarHidden = true
                        appDelegate.window?.rootViewController = navController
                    }
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
