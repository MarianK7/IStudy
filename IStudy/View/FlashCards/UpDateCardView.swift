//
//  UpDateCardView.swift
//  IStudy
//
//  Created by Marián Keszi on 26/05/2023.
//

import SwiftUI

struct UpDateCardView: View {
    @State var selectedQuestion: QuestionModel?
    @Binding var newName: String
    @Binding var newQuestion: String
    @Binding var newAnswer: String
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm :Manager
    var body: some View {
        VStack(spacing: 10){
            Spacer()
            VStack(alignment: .leading,spacing: 10){
                HStack{
                    TextField("Name", text: $newName).bold()
                        .font(.title)
                        .foregroundColor(.black)
                    Button {
                        
                       dismiss()
                    } label: {
                        Image(systemName: "xmark").bold()
                            .imageScale(.large)
                            .foregroundColor(.black)
                    }

                    
                }
                Text("Question").bold()
                TextEditor(text: $newQuestion).bold()
                    .frame(width: UIScreen.main.bounds.width - 30)
                    .frame(height: 80)
                    .background(.gray)
                    .opacity(0.7)
                    .cornerRadius(10)
                Text("Anser").bold()
                TextEditor(text: $newAnswer).bold()
                    .frame(width: UIScreen.main.bounds.width - 30)
                    .frame(height: 80)
                    .background(.gray)
                    .opacity(0.7)
                    .cornerRadius(10)
              
              
                   
            }
            .padding(.horizontal)
            Button {
                vm.updateCard(question: selectedQuestion!, newName: newName, newQuestion: newQuestion, newAnswer: newAnswer)
                    dismiss()
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

// struct UpDateCardView_Previews: PreviewProvider {
//     static var previews: some View {
//         UpDateCardView()
//     }
// }
