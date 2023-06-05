//
//  flashCardView.swift
//  IStudy
//
//  Created by Marián Keszi on 25/05/2023.
//

import SwiftUI

struct flashCardView: View {
    @EnvironmentObject var vm :Manager
    @State var showAddView = false
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    NavigationLink {
                        CardListView()
                    } label: {
                        Image(systemName: "square.stack")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.black)
                    }
                    Spacer()
                    Button {
                        showAddView.toggle()
                    } label: {
                        Image(systemName: "plus.square")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.black)
                    }
                    
                    
                }
                .padding()
                TabView {
                    ForEach(vm.questionList) { items in
                        CardView(name: items.name, question: items.question, answer: items.answer)
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .onAppear{
                vm.fetchData()
            }
            .sheet(isPresented: $showAddView) {
                AddNewCardView( Showaddview: $showAddView)
                    .presentationDetents([.fraction(0.45)])
                    .presentationDragIndicator(.visible)
                
            }
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .background(
                Image("TaskView")
                      .resizable()
                      .aspectRatio( contentMode: .fill)
                      .frame(width: UIScreen.main.bounds.width)
                      .ignoresSafeArea()
            )
        }
    }
}

struct flashCardView_Previews: PreviewProvider {
    static var previews: some View {
        flashCardView()
            .environmentObject(Manager())
    }
}
