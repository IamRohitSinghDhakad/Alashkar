//
//  NotificationViewController.swift
//  Alashkar
//
//  Created by Rohit SIngh Dhakad on 04/10/24.
//

import UIKit

class NotificationViewController: UIViewController {
    
    @IBOutlet weak var tblVw: UITableView!
    @IBOutlet weak var lblTitleHead: UILabel!
    
    var arrNotificationModel = [NotificationModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblTitleHead.text = "Notification".localized()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.call_GetNotification_Api()
    }
    
    @IBAction func btnOnBack(_ sender: Any) {
        self.sideMenuController?.revealMenu()
    }

}


extension NotificationViewController : UITabBarDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrNotificationModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell")as! NotificationTableViewCell
        
        let obj = self.arrNotificationModel[indexPath.row]
        
        cell.lblHeading.text = obj.title
        cell.lblTitleTwo.text = obj.message
        
        return cell
    }
    
}

extension NotificationViewController{
    
    func call_GetNotification_Api(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
        objWebServiceManager.showIndicator()
        
        let dicrParam = ["user_id":objAppShareData.UserDetail.strUserId!,
                         "lang":objAppShareData.currentLanguage]as [String:Any]
        
        objWebServiceManager.requestPost(strURL: WsUrl.url_GetNotificationList, queryParams: [:], params: dicrParam, strCustomValidation: "", showIndicator: false) { (response) in
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            print(response)
            
            if status == MessageConstant.k_StatusCode{
                if let user_details  = response["result"] as? [[String:Any]] {
                  
                    for data in user_details{
                        let obj = NotificationModel(from: data)
                        self.arrNotificationModel.append(obj)
                    }
                    
                    self.tblVw.displayBackgroundText(text: "")
                    self.tblVw.reloadData()
                }
            }else{
                objWebServiceManager.hideIndicator()
                if let msgg = response["result"]as? String{
                    self.tblVw.displayBackgroundText(text: msgg)
                    self.tblVw.reloadData()
                    //objAlert.showAlert(message: msgg, title: "", controller: self)
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
