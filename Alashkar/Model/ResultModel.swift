//
//  ResultModel.swift
//  Know
//
//  Created by Rohit SIngh Dhakad on 20/04/24.
//

import UIKit

class ResultModel: NSObject {
    
    var answer: String?
    var correct_answer: String?
    var question: String?
    var isCorrect : String?
    var name : String?
    
    
    
    init(from dictionary: [String: Any]) {
        super.init()
        
        if let value = dictionary["answer"] as? String {
            answer = value
        }
        
        if let value = dictionary["correct_answer"] as? String {
            correct_answer = value
        }
        
        if let value = dictionary["question"] as? String {
            question = value
        }
        
        if let value = dictionary["name"] as? String {
            name = value
        }
        
        if let value = dictionary["isCorrect"] as? String {
            isCorrect = value
        }else if let value = dictionary["isCorrect"] as? Int {
            isCorrect = "\(value)"
        }
        
    }
}
