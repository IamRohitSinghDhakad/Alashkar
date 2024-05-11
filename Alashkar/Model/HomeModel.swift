//
//  HomeModel.swift
//  GMS
//
//  Created by Rohit SIngh Dhakad on 17/11/23.
//

import UIKit

class HomeModel: NSObject {
    
    var category_id: String?
    var category_name: String?
    var category_image: String?
    
    var sub_category_id: String?
    var sub_category_name: String?
    var sub_category_liked: String?
    
    var quiz_score_percentage: Double?
    var no_of_topics : String?
    
    var strTotal_questions : String?
    
    var strHasQuiz : String?
    
    init(from dictionary: [String: Any]) {
        super.init()
        
        if let value = dictionary["category_id"] as? String {
            category_id = value
        }
        
        if let value = dictionary["category_name"] as? String {
            category_name = value
        }
        
        if let value = dictionary["category_image"] as? String {
            category_image = value
        }
        
        //============//
        
        if let value = dictionary["sub_category_id"] as? String {
            sub_category_id = value
        }
        
        if let value = dictionary["sub_category_name"] as? String {
            sub_category_name = value
        }
        
        if let value = dictionary["liked"] as? Int {
            sub_category_liked = "\(value)"
        }
        
        if let value = dictionary["quiz_score_percentage"] as? Double {
            quiz_score_percentage = value
        }
        
        if let value = dictionary["no_of_topics"] as? String {
            no_of_topics = value
        }else if let value = dictionary["no_of_topics"] as? Int {
            no_of_topics = "\(value)"
        }
        
        if let value = dictionary["total_questions"] as? String {
            strTotal_questions = value
        }else if let value = dictionary["total_questions"] as? Int {
            strTotal_questions = "\(value)"
        }
        
        if let value = dictionary["has_quiz"] as? String {
            strHasQuiz = value
        }else if let value = dictionary["has_quiz"] as? Int {
            strHasQuiz = "\(value)"
        }
        
    }
}
