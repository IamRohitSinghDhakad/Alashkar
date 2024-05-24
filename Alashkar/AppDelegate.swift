//
//  AppDelegate.swift
//  Alashkar
//
//  Created by Rohit SIngh Dhakad on 09/05/24.
//

import UIKit
import IQKeyboardManagerSwift

let ObjAppdelegate = UIApplication.shared.delegate as! AppDelegate

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    var navController: UINavigationController?
    
    private static var AppDelegateManager: AppDelegate = {
        let manager = UIApplication.shared.delegate as! AppDelegate
        return manager
    }()
    // MARK: - Accessors
    class func AppDelegateObject() -> AppDelegate {
        return AppDelegateManager
    }
    
    func determineInitialInterfaceStyle() -> UIUserInterfaceStyle {
        if #available(iOS 13.0, *) {
            let currentTraitCollection = UIScreen.main.traitCollection
            return currentTraitCollection.userInterfaceStyle
        } else {
            // Fallback for earlier iOS versions
            return .light
        }
    }
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //MARK: IQKeyBord Default Settings
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        // Determine user's preferred language
        let preferredLanguage = LocalizationSystem.sharedInstance.getLanguage()
        
        // Check if the language is Arabic
        if preferredLanguage.lowercased().hasPrefix("ar") {
            // Set app layout to right-to-left
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        } else {
            // Set app layout to left-to-right (default)
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        
        self.settingRootController()
        
        return true
        
    }
    
}

extension AppDelegate{
    
    func LoginNavigation(){
        let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
        navController = sb.instantiateViewController(withIdentifier: "LoginNav") as? UINavigationController
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
    }
    
    func settingRootController() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        appDelegate.window?.rootViewController = vc
    }
    
}
