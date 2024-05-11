//
//  AnswerModel.swift
//  Know
//
//  Created by Rohit SIngh Dhakad on 28/01/24.
//

import UIKit

class AnswerModel: NSObject {
    
    var strDescription: String?
    var empire: String?
    var estimated_population_at_peak: String?
    var time_period: String?
    
    var answer: String?
    var answer_id: String?
    var answer_type: String?
    var position : String?
    
    init(from dictionary: [String: Any]) {
        super.init()
        
        if let value = dictionary["description"] as? String {
            strDescription = value
        }
        
        if let value = dictionary["empire"] as? String {
            empire = value
        }
        
        if let value = dictionary["estimated_population_at_peak"] as? String {
            estimated_population_at_peak = value
        }
        
        if let value = dictionary["time_period"] as? String {
            time_period = value
        }
        
        if let value = dictionary["answer"] as? String {
            answer = value
        }
        
        if let value = dictionary["answer_id"] as? String {
            answer_id = value
        }
        
        if let value = dictionary["answer_type"] as? String {
            answer_type = value
        }
        
        if let value = dictionary["position"] as? String {
            position = value
        }else if let value = dictionary["position"] as? Int {
            position = "\(value)"
        }
        
        
    }
    
}
