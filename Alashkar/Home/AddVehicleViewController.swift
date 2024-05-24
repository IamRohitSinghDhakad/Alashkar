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
    
    
    var objcars : HomeModel?
    
    
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
        
        self.setData()
        
    }
    
    func setData(){
        self.tfVehicleBrand.text = self.objcars?.brand
        self.tfVehicleModel.text = self.objcars?.carModel
        self.tfVehicleVarient.text = self.objcars?.variant
        self.tfModelYear.text = self.objcars?.year
        self.tfVehicleRegistrationNumber.text = self.objcars?.registration
    }
    

    @IBAction func btnOnBack(_ sender: Any) {
        onBackPressed()
    }
    @IBAction func btnOnSubmit(_ sender: Any) {
        call_AddVehicle_Api()
    }
}

extension AddVehicleViewController {
    
   
    func call_AddVehicle_Api(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
        objWebServiceManager.showIndicator()
        
        let dicrParam = ["user_id":objAppShareData.UserDetail.strUserId!,
                         "vehicle_id":self.objcars?.vehicle_id ?? "",
                         "brand":self.tfVehicleBrand.text!,
                         "model":self.tfVehicleModel.text!,
                         "variant":self.tfVehicleVarient.text!,
                         "year":self.tfModelYear.text!,
                         "kraftstoffart":objcars?.kraftstoffart ?? "",
                         "hsn":self.objcars?.hsn ?? "",
                         "tsn":self.objcars?.tsn ?? "",
                         "registration":self.tfVehicleRegistrationNumber.text!,
                         "lang":objAppShareData.currentLanguage]as [String:Any]
        
        print(dicrParam)
        
        objWebServiceManager.requestPost(strURL: WsUrl.url_AddVehicle, queryParams: [:], params: dicrParam, strCustomValidation: "", showIndicator: false) { (response) in
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            print(response)
            
            if status == MessageConstant.k_StatusCode{
                if let user_details  = response["result"] as? [String:Any] {
                   
                    objAlert.showAlertSingleButtonCallBack(alertBtn: "OK".localized(), title: "", message: "Vehicle Added Succesfully", controller: self) {
                        self.onBackPressed()
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
