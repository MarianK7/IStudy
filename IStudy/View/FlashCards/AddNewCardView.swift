//
//  AddNewCardView.swift
//  IStudy
//
//  Created by Marián Keszi on 26/05/2023.
//

import SwiftUI

struct AddNewCardView: View {
    @State var name = ""
    @State var question = ""
    @State var answer = ""
    @State var fliping = false
    @Binding var Showaddview:Bool
    @EnvironmentObject var vm : Manager
    var body: some View {
        VStack(spacing: 10){
            Spacer()
            VStack(alignment: .leading, spacing: 10) {
                HStack{
                    TextField("Name", text: $name).bold()
                        .font(.title)
                        .foregroundColor(.black)
                    Button {
                        Showaddview = false
                    } label: {
                        Image(systemName: "xmark").bold()
                            .imageScale(.large)
                            .foregroundColor(.black)
                        
                    }
                    
                }
                Text("Question").bold()
                TextEditor(text: $question).bold()
                    .frame(height: 80)
                    .background(.gray)
                    .opacity(0.7)
                    .cornerRadius(10)
                Text("Answer").bold()
                TextEditor(text: $answer).bold()
                    .frame(height: 80)
                    .background(.gray)
                    .opacity(0.7)
                    .cornerRadius(10)
                
                
                
            }
            Button {
                vm.saveToFirestore(name: name, question: question, answer: answer, fliping: fliping)
                Showaddview = false
            } label: {
                Text("Add")
                    .foregroundColor(.white)
                    .frame(width: 230, height: 40)
                    .background(.green)
                    .cornerRadius(10)
            }
        }
        .padding(.horizontal)
        
        
    }
}

struct AddNewCardView_Previews: PreviewProvider {
    static var previews: some View { AddNewCardView(Showaddview: .constant(false)).environmentObject(Manager()) }
}
