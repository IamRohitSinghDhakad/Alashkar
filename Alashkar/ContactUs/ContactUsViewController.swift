//
//  ContactUsViewController.swift
//  OneLastChance
//
//  Created by Dhakad, Rohit Singh on 08/05/24.
//

import UIKit

class ContactUsViewController: UIViewController {

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
           // self.callWebserviceForContactUs()
        }
    }
}

extension ContactUsViewController{
    
    
    
}
