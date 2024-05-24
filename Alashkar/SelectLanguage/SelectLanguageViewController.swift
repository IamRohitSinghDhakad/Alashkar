//
//  SelectLanguageViewController.swift
//  Alashkar
//
//  Created by Rohit SIngh Dhakad on 13/05/24.
//

import UIKit

class SelectLanguageViewController: UIViewController {

    @IBOutlet weak var imgVwGermanTick: UIImageView!
    @IBOutlet weak var imgVwArabicTick: UIImageView!
    @IBOutlet weak var lblTitleHeading: UILabel!
    @IBOutlet weak var lblSelectLanguage: UILabel!
    @IBOutlet weak var lblDeutsch: UILabel!
    @IBOutlet weak var lblArabisch: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.lblTitleHeading.text = "Select Language".localized()
        self.lblSelectLanguage.text = "Select Language".localized()
        
        self.lblDeutsch.text = "German".localized()
        self.lblArabisch.text = "Arabic".localized()
        // Do any additional setup after loading the view.
        
        updateLanguageSelection()
    }

    func updateLanguageSelection() {
        if objAppShareData.currentLanguage == "ar" {
            self.imgVwArabicTick.isHidden = false
            self.imgVwGermanTick.isHidden = true
        } else {
            self.imgVwArabicTick.isHidden = true
            self.imgVwGermanTick.isHidden = false
        }
    }

    @IBAction func btnOnBack(_ sender: Any) {
        self.sideMenuController?.revealMenu()
    }

    @IBAction func btnOnGerman(_ sender: Any) {
        showAlertForLanguageChange(to: "de")
    }

    @IBAction func btnOnArabic(_ sender: Any) {
        showAlertForLanguageChange(to: "ar")
    }

    func showAlertForLanguageChange(to languageCode: String) {
            let alert = UIAlertController(title: "Change Language".localized(), message: "Are you sure you want to change the language? After changing the language, you need to quit the app and reopen it.".localized(), preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "Confirm".localized(), style: .default) { _ in
                self.changeLanguage(to: languageCode)
            }
            let cancelAction = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
            
            alert.addAction(confirmAction)
            alert.addAction(cancelAction)
            
            self.present(alert, animated: true, completion: nil)
        }

        func changeLanguage(to languageCode: String) {
            LocalizationSystem.sharedInstance.setLanguage(languageCode: languageCode)
            objAppShareData.currentLanguage = languageCode
            
            // Update UI direction based on the language
            if languageCode == "ar" {
                UIView.appearance().semanticContentAttribute = .forceRightToLeft
            } else {
                UIView.appearance().semanticContentAttribute = .forceLeftToRight
            }

            // Simulate quitting the app
            exit(0)
        }
}
