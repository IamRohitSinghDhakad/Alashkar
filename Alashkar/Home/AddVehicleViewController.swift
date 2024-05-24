//
//  AddVehicleViewController.swift
//  Alashkar
//
//  Created by Dhakad, Rohit Singh (Cognizant) on 11/05/24.
//

import UIKit

class AddVehicleViewController: UIViewController {

    @IBOutlet weak var tfVehicleBrand: UITextField!
    @IBOutlet weak var tfVehicleModel: UITextField!
    @IBOutlet weak var tfVehicleVarient: UITextField!
    @IBOutlet weak var tfModelYear: UITextField!
    @IBOutlet weak var tfVehicleRegistrationNumber: UITextField!
    @IBOutlet weak var lblAddVehicle: UILabel!
    @IBOutlet weak var lblVehicleBrand: UILabel!
    @IBOutlet weak var lblVehicleModel: UILabel!
    @IBOutlet weak var lblVehicleVarient: UILabel!
    @IBOutlet weak var lblVehicleModelYear: UILabel!
    @IBOutlet weak var lblVehicleRegistrationNumber: UILabel!
    @IBOutlet weak var btnSubmit: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.lblAddVehicle.text = "Add Vehicle".localized()
        
        self.lblVehicleBrand.text = "Vehicle Brand".localized()
        self.lblVehicleModel.text = "Vehicle Model".localized()
        self.lblVehicleVarient.text = "Vehicle Variant".localized()
        self.lblVehicleModelYear.text = "Vehicle Model Year".localized()
        self.lblVehicleRegistrationNumber.text = "Vehicle Registration Number".localized()
        self.btnSubmit.setTitle("Submit".localized(), for: .normal)
        
        
        if objAppShareData.currentLanguage == "ar"{
            self.tfVehicleBrand.textAlignment = .right
            self.tfVehicleModel.textAlignment = .right
            self.tfVehicleVarient.textAlignment = .right
            self.tfModelYear.textAlignment = .right
            self.tfVehicleRegistrationNumber.textAlignment = .right
        }else{
            self.tfVehicleBrand.textAlignment = .left
            self.tfVehicleModel.textAlignment = .left
            self.tfVehicleVarient.textAlignment = .left
            self.tfModelYear.textAlignment = .left
            self.tfVehicleRegistrationNumber.textAlignment = .left
        }
    }
    

    @IBAction func btnOnBack(_ sender: Any) {
        onBackPressed()
    }
    @IBAction func btnOnSubmit(_ sender: Any) {
    }
}
