//
//  profileView.swift
//  IStudy
//
//  Created by Marián Keszi on 19/05/2023.
//

import SwiftUI
import FirebaseAuth

enum Tab
{
    case home
    case ToDo
    case flashCard
    case Chat
}

struct profileView: View {
    
    @Binding var showProfile: Bool
    @State var selectedTab:Tab = .home
    @State var onMode = false
    @State var trimValue:CGFloat = 0.0
    
    init(showProfile: Binding<Bool>) {
        _showProfile = showProfile
        
        UITabBar.appearance().backgroundColor = UIColor(Color.gray.opacity(0.6))
        UITabBar.appearance().unselectedItemTintColor = .black
        
       }
    
    var body: some View {
        
        
        TabView(selection: $selectedTab)
        {
            homeView(showProfile: $showProfile).tag(Tab.home).tabItem{
                VStack {
                    Text("Home")
                    Image(systemName: "house")
                }
            }
            ToDoView().environmentObject(Manager()).tag(Tab.ToDo).tabItem{
                VStack {
                    Text("ToDo")
                    Image(systemName: "checklist")
                }
            }
            flashCardView().environmentObject(Manager()).tag(Tab.flashCard).tabItem{
                VStack {
                    Text("FlashCards")
                    Image(systemName: "mail.stack")
                }
            }
        }
    }
}

struct profileView_Previews: PreviewProvider {
    static var previews: some View {
        profileView(showProfile: .constant(true))
            .environmentObject(Manager())
    }
}
