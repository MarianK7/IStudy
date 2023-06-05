//
//  UpDateTaskView.swift
//  IStudy
//
//  Created by Marián Keszi on 29/05/2023.
//

import SwiftUI

struct UpDateTaskView: View {
    @Binding var selectedTask: ToDoDataModel?
    @Binding var newTitle: String
    @Binding var EditSheet: Bool
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm: Manager
    var body: some View {
        VStack(spacing: 10){
            Spacer()
            VStack(alignment: .leading,spacing: 10){
                Button {
                    dismiss()
                    EditSheet.toggle()
                } label: {
                    Spacer()
                    Image(systemName: "xmark").bold()
                        .imageScale(.large)
                        .foregroundColor(.black)
                }
                Text("New title:")
                    .font(.title)
                    .bold()
                TextEditor(text: $newTitle).bold()
                    .frame(width: UIScreen.main.bounds.width - 30)
                    .frame(height: 80)
                    .background(.gray)
                    .opacity(0.7)
                    .cornerRadius(10)
                
            }
            .padding(.horizontal)
            Button {
                vm.UpdateTask(task: selectedTask!, newTitle: newTitle)
                newTitle = ""
                dismiss()
                EditSheet.toggle()
            } label: {
                Text("UpDate").bold()
                    .foregroundColor(.white)
                    .frame(width: 230, height: 40)
                    .background(.green)
                    .cornerRadius(10)
            }
        }
    }
}

/*
 struct UpDateTaskView_Previews: PreviewProvider {
 static var previews: some View {
 UpDateTaskView()
 }
 }
 */
