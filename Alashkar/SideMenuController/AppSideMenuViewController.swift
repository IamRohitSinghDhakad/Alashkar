//
//  AppSideMenuViewController.swift
//  Paing
//
//  Created by Akshada on 21/05/21.
//

import UIKit

class SideMenuOptions: Codable {
    var menuName: String = ""
    var menuImageName: String = ""
    var menuSelectedImageName: String = ""
    init(menuName: String, menuImageName: String, menuSelectedImageName: String) {
        self.menuName = menuName
        self.menuImageName = menuImageName
        self.menuSelectedImageName = menuSelectedImageName
    }
}

class Preferences {
    static let shared = Preferences()
    var enableTransitionAnimation = false
}

class AppSideMenuViewController: UIViewController {
    
    @IBOutlet var imgVwUser: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var selectionMenuTrailingConstraint: NSLayoutConstraint!
    
    var selectedIndexpath = 0
    var strBadgeCount = ""
    
    private let menus: [SideMenuOptions] = [SideMenuOptions(menuName: "Home".localized(), menuImageName: "", menuSelectedImageName: ""),
                                            SideMenuOptions(menuName: "Profile".localized(), menuImageName: "", menuSelectedImageName: ""),
                                            SideMenuOptions(menuName: "About Us".localized(), menuImageName: "", menuSelectedImageName: ""),
                                            SideMenuOptions(menuName: "Contact Us".localized(), menuImageName: "", menuSelectedImageName: ""),
                                            SideMenuOptions(menuName: "Language".localized(), menuImageName: "", menuSelectedImageName: ""),
                                            SideMenuOptions(menuName: "Privacy Policy".localized(), menuImageName: "", menuSelectedImageName: ""),
                                            SideMenuOptions(menuName: "Log Out".localized(), menuImageName: "", menuSelectedImageName: ""),
                                            SideMenuOptions(menuName: "Delete Account".localized(), menuImageName: "", menuSelectedImageName: "")]
    
    
    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureView()
        
        // Along with auto layout, these are the keys for enabling variable cell height
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        
        controllerMenuSetup()
    
        sideMenuController?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

//        let profilePic = objAppShareData.UserDetail.strProfilePicture .trim().addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//            if profilePic != "" {
//                let url = URL(string: profilePic!)
//                self.imgVwUser.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "user-1"))
//            }

    }
    
    private func controllerMenuSetup() {
        
        sideMenuController?.cache(viewControllerGenerator: {
            self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController")
        }, with: "0")
        
        sideMenuController?.cache(viewControllerGenerator: {
            self.storyboard?.instantiateViewController(withIdentifier: "EditProfileViewController")
            
        }, with: "1")
        
        sideMenuController?.cache(viewControllerGenerator: {
            self.storyboard?.instantiateViewController(withIdentifier: "PrivacyPolicyViewController")
        }, with: "2")
        
        sideMenuController?.cache(viewControllerGenerator: {
            self.storyboard?.instantiateViewController(withIdentifier: "ContactUsViewController")
        }, with: "3")
        
        sideMenuController?.cache(viewControllerGenerator: {
            self.storyboard?.instantiateViewController(withIdentifier: "SelectLanguageViewController")
        }, with: "4")
        
        sideMenuController?.cache(viewControllerGenerator: {
            self.storyboard?.instantiateViewController(withIdentifier: "PrivacyPolicyViewController")
        }, with: "5")
    }
    
    private func configureView() {
        SideMenuController.preferences.basic.menuWidth = view.frame.width * 0.6
        let sidemenuBasicConfiguration = SideMenuController.preferences.basic
        let showPlaceTableOnLeft = (sidemenuBasicConfiguration.position == .under) != (sidemenuBasicConfiguration.direction == .right)
        if showPlaceTableOnLeft {
            selectionMenuTrailingConstraint.constant = SideMenuController.preferences.basic.menuWidth - view.frame.width
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let sideMenuBasicConfiguration = SideMenuController.preferences.basic
        let showPlaceTableOnLeft = (sideMenuBasicConfiguration.position == .under) != (sideMenuBasicConfiguration.direction == .right)
        selectionMenuTrailingConstraint.constant = showPlaceTableOnLeft ? SideMenuController.preferences.basic.menuWidth - size.width : 0
        view.layoutIfNeeded()
    }
    
}

extension AppSideMenuViewController: SideMenuControllerDelegate {
    func sideMenuController(_ sideMenuController: SideMenuController,
                            animationControllerFrom fromVC: UIViewController,
                            to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BasicTransitionAnimator(options: .transitionFlipFromLeft, duration: 0.6)
    }
    
    func sideMenuController(_ sideMenuController: SideMenuController, willShow viewController: UIViewController, animated: Bool) {
        print("[Example] View controller will show [\(viewController)]")
    }
    
    func sideMenuController(_ sideMenuController: SideMenuController, didShow viewController: UIViewController, animated: Bool) {
        print("[Example] View controller did show [\(viewController)]")
    }
    
    func sideMenuControllerWillHideMenu(_ sideMenuController: SideMenuController) {
        print("[Example] Menu will hide")
    }
    
    func sideMenuControllerDidHideMenu(_ sideMenuController: SideMenuController) {
        print("[Example] Menu did hide.")
    }
    
    func sideMenuControllerWillRevealMenu(_ sideMenuController: SideMenuController) {
        print("[Example] Menu will reveal.")
    }
    
    func sideMenuControllerDidRevealMenu(_ sideMenuController: SideMenuController) {
        print("[Example] Menu did reveal.")
    }
}

extension AppSideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    // swiftlint:disable force_cast
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppSideMenuTableViewCell", for: indexPath) as! AppSideMenuTableViewCell
        let row = indexPath.row
        if self.selectedIndexpath == indexPath.row{
         //   cell.imgVw.image = UIImage(named: menus[row].menuImageName)
        }else{
           // cell.imgVw.image = UIImage(named: menus[row].menuImageName)
        }
                
        
        cell.menuName.text = menus[row].menuName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        
        self.selectedIndexpath = row
        
//        if objAppShareData.isDemoMode == true{
//            if row == 1{
//
//            }
//        }
        
        switch row {
        case 1:
                sideMenuController?.setContentViewController(with: "\(row)", animated: Preferences.shared.enableTransitionAnimation)
                sideMenuController?.hideMenu()
                
                if let identifier = sideMenuController?.currentCacheIdentifier() {
                    print("[Example] View Controller Cache Identifier: \(identifier)")
                }
        case 6:
            sideMenuController?.hideMenu()
            objAlert.showAlertCallBack(alertLeftBtn: "Yes".localized(), alertRightBtn: "No".localized(), title: "Logout?".localized(), message: "Do you want to log out?".localized(), controller: self) {
                AppSharedData.sharedObject().signOut()
            }
        case 7:
            sideMenuController?.hideMenu()
            objAlert.showAlertCallBack(alertLeftBtn: "Yes".localized(), alertRightBtn: "No".localized(), title: "Delete Account?".localized(), message: "Do you want to Delete account?".localized(), controller: self) {
                self.callWebserviceForDeleteAccount()
            }
        default:
            sideMenuController?.setContentViewController(with: "\(row)", animated: Preferences.shared.enableTransitionAnimation)
            sideMenuController?.hideMenu()
            
            if let identifier = sideMenuController?.currentCacheIdentifier() {
                print("[Example] View Controller Cache Identifier: \(identifier)")
            }
        }
        self.tableView.reloadData()
    }
    
    func callWebserviceForDeleteAccount(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        objWebServiceManager.showIndicator()
        self.view.endEditing(true)
        
        
        let dicrParam = [
            "user_id":objAppShareData.UserDetail.strUserId ?? "",
            "status":"0"]as [String:Any]
        
        print(dicrParam)
        
        objWebServiceManager.requestPost(strURL: WsUrl.url_UpdateProfile, queryParams: [:], params: dicrParam, strCustomValidation: "", showIndicator: false) { response in
            
            objWebServiceManager.hideIndicator()
            print(response)
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            
            if status == MessageConstant.k_StatusCode{
                
                guard response["result"] is [String:Any] else{
                    return
                }
                AppSharedData.sharedObject().signOut()
                
                
            }else{
                objWebServiceManager.hideIndicator()
                AppSharedData.sharedObject().signOut()
            }
        } failure: { (Error) in
            print(Error)
        }
    }
}



extension UITableView
{
    func updateRow(row: Int, section: Int = 0)
    {
        let indexPath = IndexPath(row: row, section: section)
        
        self.beginUpdates()
        self.reloadRows(at: [indexPath], with: .automatic)
        self.endUpdates()
    }
    
}
