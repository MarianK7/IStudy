//
//  QuestionDataModel.swift
//  IStudy
//
//  Created by Marián Keszi on 28/05/2023.
//

import Foundation

struct QuestionModel:Identifiable,Codable{
    var id:String
    var userId: String
    var name:String
    var fliping:Bool = false
    var question:String
    var answer:String
}
