//
//  QuestionModel.swift
//  Know
//
//  Created by Rohit SIngh Dhakad on 27/01/24.
//

import UIKit

class QuestionModel: NSObject {

    var answer_type: String?
    var category_id: String?
    var category_name: String?
    var category_image: String?
    var strQuestion: String?
    var position: String?
    var short_name: String?
    var strDescription: String?
    var strShortDes : String?
    var strShortDesValue : String?
    var topicId : String?
    var strTopicName : String?
    var strTopicBy : String?
    var subCategory_id: String?
    var subCategory_name: String?
    var topicLiked : String?
    var deep_dives : String?
    
    
/*
 {
"category_id" = 2;
"category_image" = "https://knowapp.co/admin/";
"category_name" = History;
description = "1. The Spark in Sarajevo: World War I, which lasted from 1914 to 1918, began with the assassination of Archduke Franz Ferdinand of Austria in Sarajevo, setting off a chain of diplomatic failures and alliances that led to the war's outbreak. This event exemplifies the fragile state of international relations at the time and the domino effect in the complex web of alliances. 2. A War of Firsts and Technological Advances: The Great War introduced many firsts in warfare, including the use of tanks, chemical weapons, and extensive trench warfare. These innovations significantly increased the war's lethality and marked a turning point in military strategy and technology. 3. Unprecedented Global Impact: Involving many of the world's great powers and fought on several continents, World War I reshaped global politics, economics, and societies. It led to the fall of empires, including the Austro-Hungarian, Ottoman, Russian, and German empires, drastically altering the world map and international relations. 4. The Human Cost: The war was one of the deadliest conflicts in history, with an estimated 16 million deaths and 21 million wounded. The vast scale of casualties and the war's brutal nature had a profound impact on those who lived through it, influencing generations to come. 5. The Treaty of Versailles and Its Aftermath: The war officially ended with the Treaty of Versailles in 1919, imposing heavy reparations and territorial losses on Germany. The treaty's terms are often cited as a cause of World War II, highlighting the interconnectedness of the 20th century's two global conflicts and the challenges of achieving lasting peace in the aftermath of total war.";
entrydt = "2024-04-17 20:47:10";
liked = 0;
position = 1;
"short_desc" = "World War I (1914-1918): Also known as the Great War, it involved many of the world\U2019s great powers, resulting in significant loss of life, political changes, and the redrawing of national borders.";
status = 1;
"sub_category_id" = 7;
"sub_category_name" = Wars;
"topic_by" = "1914-1918";
"topic_id" = 166;
"topic_name" = "World War I";
},
 */
    
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
        
        if let value = dictionary["answer_type"] as? String {
            answer_type = value
        }
        
        if let value = dictionary["question"] as? String {
            strQuestion = value
        }
        
        if let value = dictionary["position"] as? String {
            position = value
        }else if let value = dictionary["position"] as? Int {
            position = "\(value)"
        }
        
        if let value = dictionary["sub_category_id"] as? String {
            subCategory_id = value
        }else if let value = dictionary["sub_category_id"] as? Int {
            subCategory_id = "\(value)"
        }
        
        if let value = dictionary["deep_dives"] as? String {
            deep_dives = value
        }else if let value = dictionary["deep_dives"] as? Int {
            deep_dives = "\(value)"
        }
        
        
        
        if let value = dictionary["liked"] as? String {
            topicLiked = value
        }else if let value = dictionary["liked"] as? Int {
            topicLiked = "\(value)"
        }
        
        if let value = dictionary["topic_id"] as? String {
            topicId = value
        }else if let value = dictionary["topic_id"] as? Int {
            topicId = "\(value)"
        }
        
        if let value = dictionary["short_name"] as? String {
            short_name = value
        }
        
        if let value = dictionary["description"] as? String {
            strDescription = value
        }
        
        if let value = dictionary["short_desc"] as? String {
            strShortDes = value
        }
        
        if let value = dictionary["short_desc_value"] as? String {
            strShortDesValue = value
        }
        
        
        
        if let value = dictionary["topic_by"] as? String {
            strTopicBy = value
        }
        
        if let value = dictionary["topic_name"] as? String {
            strTopicName = value
        }
        
        if let value = dictionary["sub_category_name"] as? String {
            subCategory_name = value
        }
    }

}
