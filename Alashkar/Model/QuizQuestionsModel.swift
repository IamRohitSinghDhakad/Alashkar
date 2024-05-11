//
//  QuizQuestionsModel.swift
//  Know
//
//  Created by Dhakad, Rohit Singh (Cognizant) on 16/04/24.
//

import UIKit

class QuizQuestionsModel: NSObject {
    
    
    /*
     {
 "category_id" = 2;
 "category_image" = "https://knowapp.co/admin/";
 "category_name" = History;
 "correct_answer" = "1950-1953";
 entrydt = "2024-04-11 09:30:50";
 liked = 0;
 name = "When was this war?";
 options =             (
     "1337-1453",
     "1950-1953",
     "1803-1815",
     "1947-1991"
 );
 question = "Korean War";
 "quiz_id" = 4;
 "quiz_question_id" = 97;
 status = 1;
 "sub_category_id" = 7;
     */
    
    var category_id: String?
    var category_name: String?
    var name: String?
    var question: String?
    var quiz_id: String?
    var quiz_question_id: String?
    var options: [String]?
    var sub_category_id : String?
    var correct_answer : String?
        
    init(from dictionary: [String: Any]) {
        super.init()
        
        if let value = dictionary["category_id"] as? String {
            category_id = value
        }else if let value = dictionary["category_id"] as? Int {
            category_id = "\(value)"
        }
        
        if let value = dictionary["category_name"] as? String {
            category_name = value
        }
        
        
        if let value = dictionary["correct_answer"] as? String {
            correct_answer = value
        }
        
        
        if let value = dictionary["name"] as? String {
            name = value
        }
        
        if let value = dictionary["question"] as? String {
            question = value
        }
        
        if let value = dictionary["quiz_id"] as? String {
            quiz_id = value
        }else if let value = dictionary["quiz_id"] as? Int {
            quiz_id = "\(value)"
        }
        
        if let value = dictionary["quiz_question_id"] as? String {
            quiz_question_id = value
        }
        
        if let value = dictionary["options"] as? [String] {
            options = value
        }
        
        if let value = dictionary["sub_category_id"] as? String {
            sub_category_id = value
        }else if let value = dictionary["sub_category_id"] as? Int {
            sub_category_id = "\(value)"
        }
        
        
    }
}
