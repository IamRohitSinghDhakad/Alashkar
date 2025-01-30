//
//  HomeViewController.swift
//  Alashkar
//
//  Created by Rohit SIngh Dhakad on 10/05/24.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tblVw: UITableView!
    @IBOutlet weak var lblHomeHeading: UILabel!
    @IBOutlet weak var imgVw: UIImageView!
    @IBOutlet weak var lblNoText: UILabel!
    
    var arrCars = [HomeModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.lblHomeHeading.text = "Home".localized()
        
       
        self.lblNoText.text = "No vehicle added yet".localized()
        self.imgVw.setImageColor(color:  UIColor(hexString: "#C5403D"))
        
        call_GetProfile_Api()
        self.tblVw.delegate = self
        self.tblVw.dataSource = self
        let nib = UINib(nibName: "HomeTableViewCell", bundle: nil)
        self.tblVw.register(nib, forCellReuseIdentifier: "HomeTableViewCell")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        call_GetVehicle_Api()
        // Determine user's preferred language
        let preferredLanguage = LocalizationSystem.sharedInstance.getLanguage()
        
        // Check if the language is Arabic
        if preferredLanguage.lowercased().hasPrefix("ar") {
            // Set app layout to right-to-left
            objAppShareData.currentLanguage = "ar"
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        } else {
            // Set app layout to left-to-right (default)
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            objAppShareData.currentLanguage = "de"
        }
    }
    
    @IBAction func btnOnOpenSideMenu(_ sender: Any) {
        self.sideMenuController?.revealMenu()
    }
    
    @IBAction func btnAddVehicle(_ sender: Any) {
        pushVc(viewConterlerId: "AddVehicleViewController")
    }
    
    
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrCars.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblVw.dequeueReusableCell(withIdentifier: "HomeTableViewCell")as! HomeTableViewCell
        
        let obj = self.arrCars[indexPath.row]
        
        cell.lblCarName.text = "\(obj.brand ?? "") \(obj.carModel ?? ""), \(obj.variant ?? "")"
        cell.lblYear.text = "\(objAppShareData.year.localized()) \(obj.year ?? "NA")"
        cell.lblCarNumber.text = "\(objAppShareData.registration.localized()) \(obj.registration ?? "NA")"
        cell.lblLastService.text = "\(objAppShareData.lastService.localized()) \(obj.last_service_date ?? "NA")"
        cell.lblUpdateService.text = "\(objAppShareData.nextService.localized()) \(obj.next_service_date ?? "NA")"
        cell.lblNextServiceDate.text = "\(obj.days_remaining_for_next_service ?? "NA")"
        
        cell.btnEdit.tag = indexPath.row
        cell.btnDelete.tag = indexPath.row
        
        cell.btnEdit.addTarget(self, action: #selector(btnOnEdit(sender: )), for: .touchUpInside)
        cell.btnDelete.addTarget(self, action: #selector(btnOnDelete(sender: )), for: .touchUpInside)
        
        return cell
    }
    
    @objc func btnOnEdit(sender: UIButton){
        print(sender.tag)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddVehicleViewController")as! AddVehicleViewController
        vc.objcars = self.arrCars[sender.tag]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func btnOnDelete(sender: UIButton){
        print(sender.tag)
        call_DeleteVehicle_Api(strVehicleId: self.arrCars[sender.tag].vehicle_id ?? "")
    }
    
    
}




extension HomeViewController {
    
    func call_GetVehicle_Api(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
        objWebServiceManager.showIndicator()
        
        let dicrParam = ["user_id":objAppShareData.UserDetail.strUserId!,
                         "vehicle_id":"",
                         "lang":objAppShareData.currentLanguage]as [String:Any]
        
        objWebServiceManager.requestPost(strURL: WsUrl.url_GetVehicle, queryParams: [:], params: dicrParam, strCustomValidation: "", showIndicator: false) { (response) in
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            print(response)
            
            if status == MessageConstant.k_StatusCode{
                if let user_details  = response["result"] as? [[String:Any]] {
                    self.arrCars.removeAll()
                    for data in user_details{
                        let obj = HomeModel.init(from: data)
                        self.arrCars.append(obj)
                    }
                    
                    if self.arrCars.count == 0{
                        self.tblVw.isHidden = true
                        self.imgVw.isHidden = false
                        self.lblNoText.isHidden = false
                    }else{
                        self.tblVw.isHidden = false
                        self.imgVw.isHidden = true
                        self.lblNoText.isHidden = true
                    }
                    
                    self.tblVw.reloadData()
                    
                }
            }else{
                objWebServiceManager.hideIndicator()
                if let msgg = response["result"]as? String{
                    self.arrCars.removeAll()
                    self.tblVw.isHidden = true
                    self.imgVw.isHidden = false
                    self.lblNoText.isHidden = false
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
    

    //============================== XXXX ========================//
    
    
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
//                    self.objUser = UserModel.init(from: user_details)
//                    
//                    self.lblEmail.text = self.objUser?.email
//                    self.lblUserName.text = self.objUser?.name
//                    self.lblPassword.text = self.objUser?.mobile
//                    self.lblFollowersCount.text = self.objUser?.strFollowers
//                    self.lblFollowingCount.text = self.objUser?.strFollowing
//                    
//                    let imageUrl  = self.objUser?.userImage
//                    if imageUrl != "" {
//                        let url = URL(string: imageUrl ?? "")
//                        self.imgVwUser.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "logo_one"))
//                    }else{
//                        self.imgVwUser.image = #imageLiteral(resourceName: "logo_one")
//                    }
                    
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
    
    
    
    func call_DeleteVehicle_Api(strVehicleId:String){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
        objWebServiceManager.showIndicator()
        
        let dicrParam = ["user_id":objAppShareData.UserDetail.strUserId!,
                         "vehicle_id":strVehicleId,
                         "lang":objAppShareData.currentLanguage]as [String:Any]
        
        objWebServiceManager.requestPost(strURL: WsUrl.url_DeleteVehicle, queryParams: [:], params: dicrParam, strCustomValidation: "", showIndicator: false) { (response) in
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            print(response)
            
            if status == MessageConstant.k_StatusCode{
                if response["result"] is String {
                    self.call_GetVehicle_Api()
                }
            }else{
                objWebServiceManager.hideIndicator()
                if let msgg = response["result"]as? String{
                    self.arrCars.removeAll()
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

extension UIColor {
        convenience init(hexString: String) {
            let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
            var int = UInt64()
            Scanner(string: hex).scanHexInt64(&int)
            let a, r, g, b: UInt64
            switch hex.count {
            case 3: // RGB (12-bit)
                (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
            case 6: // RGB (24-bit)
                (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
            case 8: // ARGB (32-bit)
                (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            default:
                (a, r, g, b) = (255, 0, 0, 0)
            }
            self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
        }
}

