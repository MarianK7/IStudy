//
//  SaveTaskView.swift
//  IStudy
//
//  Created by Marián Keszi on 28/05/2023.
//

import SwiftUI

struct SaveTaskView: View {
    @Binding var Sheet:Bool
    @Binding var textfiled: String
    @Binding var Add: Bool
    @EnvironmentObject var vm : Manager
    var body: some View {
        VStack{
            HStack{
                Text("Title")
                    .font(.headline)
                Spacer()
                Button(action: {
                    Sheet.toggle()
                    Add.toggle()
                }, label: {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .foregroundColor(.black)
                      
                })
               
            }
            TextField("Type title", text: $textfiled)
                 .padding()
                 .frame(width: 290, height: 45)
                 .background(.ultraThinMaterial.opacity(0.9))
                 .font(.headline)
                 .cornerRadius(5)
             Button(action: {
                 if !textfiled.isEmpty{
                     vm.SaveTask(title: textfiled, done: vm.done)
                     textfiled = ""
                     Add.toggle()
                     Sheet = false
                 }
             }, label: {
                 Text("Save").bold()
                     .foregroundColor(.black)
                 
             })
             .buttonStyle(.bordered)
        }
        .padding()
        .frame(width: 300, height: 150)
        .background(.ultraThinMaterial.opacity(0.9))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct SaveTaskView_Previews: PreviewProvider {
    static var previews: some View {
        SaveTaskView(Sheet: .constant(true), textfiled: .constant(""), Add: .constant(true))
            .environmentObject(Manager())
    }
}
