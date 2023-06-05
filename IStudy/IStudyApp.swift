//
//  IStudyApp.swift
//  IStudy
//
//  Created by Marián Keszi on 11/05/2023.
//

import SwiftUI
import Firebase

@main
struct IStudyApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
