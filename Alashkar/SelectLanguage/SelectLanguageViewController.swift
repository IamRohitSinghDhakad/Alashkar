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
        
        if objAppShareData.currentLanguage == "ar"{
            self.imgVwArabicTick.isHidden = false
            self.imgVwGermanTick.isHidden = true
        }else{
            self.imgVwArabicTick.isHidden = true
            self.imgVwGermanTick.isHidden = false
        }
    }
    

    @IBAction func btnOnBack(_ sender: Any) {
        self.sideMenuController?.revealMenu()
    }
   
    @IBAction func btnOnGerman(_ sender: Any) {
        
    }
    
    @IBAction func btnOnArabic(_ sender: Any) {
        
    }
}
