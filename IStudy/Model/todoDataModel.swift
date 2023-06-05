//
//  ToDoDataModel.swift
//  IStudy
//
//  Created by Marián Keszi on 28/05/2023.
//

import Foundation

struct ToDoDataModel:Identifiable{
    var id:String
    var userId: String
    var done:Bool = false
    var title:String
}
