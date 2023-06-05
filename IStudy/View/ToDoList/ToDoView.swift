//
//  ToDoView.swift
//  IStudy
//
//  Created by Marián Keszi on 25/05/2023.
//

import SwiftUI

struct ToDoView: View {
    @State var Sheet:Bool = false
    @State var EditSheet:Bool = false
    @EnvironmentObject var vm : Manager
    @State var Edit :Bool = false
    @State var Add :Bool = false
    @State var selectedTask: ToDoDataModel?
    @State var textfeld = ""
    @State var newTitle = ""
    var body: some View {
        ZStack{
            Image("TaskView")
                .resizable()
                .aspectRatio( contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width)
                .ignoresSafeArea()
            VStack(alignment: .leading){
                HStack{
                    Button(action: {
                        Edit.toggle()
                        if EditSheet == true {EditSheet.toggle()}
                    }, label: {
                        Image(systemName: Edit == false ? "pencil.circle": "pencil.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .font(.title)
                            .foregroundColor(.black)
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        Add.toggle()
                        Sheet.toggle()
                    }, label: {
                        Image(systemName: Add == false ? "plus.circle": "plus.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .font(.title)
                            .foregroundColor(.black)
                    })
                    
                }
                ScrollView{
                    ForEach(vm.todoList){ items in
                        VStack(alignment: .leading, spacing: 10){
                            Button(action: {
                                vm.toggleDone(items)
                            }, label: {
                                HStack{
                                    Image(systemName:items.done ? "checkmark.circle":  "circle")
                                        .foregroundColor(items.done ? .green : .white)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .padding(.horizontal,5)
                                    Text(items.title)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                    Spacer()
                                    if Edit{
                                        Button(action: {
                                            self.selectedTask = items
                                            self.newTitle = items.title
                                            EditSheet.toggle()
                                        }, label: {
                                            Image(systemName: EditSheet == false ? "pencil.circle": "pencil.circle.fill")
                                                .foregroundColor(.red)
                                                .font(.title2)
                                                .fontWeight(.bold)
                                        })
                                        .padding(.horizontal,5)
                                        Button(action: {
                                            vm.DeleteTask(toDelete: items)
                                        }, label: {
                                            Image(systemName: "minus.circle.fill")
                                                .foregroundColor(.red)
                                                .font(.title2)
                                                .fontWeight(.bold)
                                        })
                                        .padding(.horizontal,5)
                                        
                                    }
                                }
                                .frame(height: 50)
                                .frame(maxWidth: .infinity)
                                .background(.ultraThinMaterial.opacity(0.9))
                                .cornerRadius(10)
                                
                                
                            })
                            
                        }
                        
                    }
                    .sheet(item: $selectedTask) { items in
                        UpDateTaskView(selectedTask: $selectedTask, newTitle: $newTitle, EditSheet: $EditSheet)
                            .presentationDetents([.fraction(0.3)])
                            .presentationDragIndicator(.visible)
                    }
                }
            }
            .padding(.horizontal,10)
            if Sheet{
                SaveTaskView(Sheet: $Sheet, textfiled: $textfeld, Add: $Add)
            }
        } 
    }
}

struct ToDoView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoView()
            .environmentObject(Manager())
    }
}
