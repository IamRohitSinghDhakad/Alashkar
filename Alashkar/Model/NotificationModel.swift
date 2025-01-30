//
//  NotificationModel.swift
//  Alashkar
//
//  Created by Rohit SIngh Dhakad on 04/10/24.
//

import UIKit

class NotificationModel: NSObject {
    
    var message: String?
    var datetime: String?
    var notification_id: String?
    var title: String?
    
//    var kraftstoffart: String?
//    var last_service_date: String?
//    var carModel: String?
//    var next_service_date : String?
//    var registration : String?
//    var tsn : String?
//    var variant: String?
//    var user_id: String?
//    var vehicle_id: String?
//    var year: String?
    
    
    
    init(from dictionary: [String: Any]) {
        super.init()
        
        if let value = dictionary["notification_id"] as? String {
            notification_id = value
        }else if let value = dictionary["notification_id"] as? Int {
            notification_id = "\(value)"
        }
        
        if let value = dictionary["title"] as? String {
            title = value
        }
        
        if let value = dictionary["message"] as? String {
            message = value
        }
        
        //============//
        
//        if let value = dictionary["entrydt"] as? String {
//            entrydt = value
//        }
//        
//        if let value = dictionary["hsn"] as? String {
//            hsn = value
//        }
//        
//        if let value = dictionary["last_service_date"] as? String {
//            last_service_date = value
//        }
//        
//        if let value = dictionary["kraftstoffart"] as? String {
//            kraftstoffart = value
//        }
//        
//        if let value = dictionary["model"] as? String {
//            carModel = value
//        }
//        
//        if let value = dictionary["next_service_date"] as? String {
//            next_service_date = value
//        }
//        
//        if let value = dictionary["registration"] as? String {
//            registration = value
//        }
//        
//        if let value = dictionary["tsn"] as? String {
//            tsn = value
//        }
//        
//        if let value = dictionary["variant"] as? String {
//            variant = value
//        }
//        
//        if let value = dictionary["vehicle_id"] as? Int {
//            vehicle_id = "\(value)"
//        }else if let value = dictionary["vehicle_id"] as? String {
//            vehicle_id = value
//        }
//        
//        if let value = dictionary["year"] as? String {
//            year = value
//        }
        
    }
}
