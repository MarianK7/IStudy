//
//  homeView.swift
//  IStudy
//
//  Created by Marián Keszi on 25/05/2023.
//

import SwiftUI
import FirebaseAuth

struct homeView: View {
    @Binding var showProfile: Bool
    @State var isShowingLogoutConfirmation: Bool = false
    @State private var userId: String = ""
    @State private var currentQuoteIndex = 0
    let studyQuotes = [
        "Success is the sum of small efforts, repeated day in and day out.",
        "The expert in anything was once a beginner.",
        "Education is the passport to the future, for tomorrow belongs to those who prepare for it today.",
        "The secret of getting ahead is getting started.",
        "Don't watch the clock; do what it does. Keep going.",
        "The future belongs to those who believe in the beauty of their dreams.",
        "Learning never exhausts the mind; it only ignites it.",
        "It does not matter how slowly you go, as long as you do not stop.",
        "The only way to do great work is to love what you do.",
        "Opportunities don't happen. You create them."
    ]
    
    init(showProfile: Binding<Bool>) {
        self._showProfile = showProfile

        let userEmail = Auth.auth().currentUser?.email
        _userId = State(initialValue: userEmail ?? "Unknown")
    }
    
    
    var body: some View {
        
        ZStack{
            Image("TaskView")
                .resizable()
                .aspectRatio( contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width)
                .ignoresSafeArea()
            VStack{
                VStack{
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: 90, height: 90)
                        .foregroundColor(.black)
                    
                    
                    Text("Hello \(userId)")
                        .foregroundColor(.black)
                        .font(.title)
                        .padding()
                    
                    
                    ZStack {
                        Color.gray
                            .opacity(0.5)
                            .edgesIgnoringSafeArea(.all)
                        
                        VStack {
                            Text("Quote of the day")
                                .font(.largeTitle)
                                .padding()
                                .foregroundColor(.black)
                            
                            Text(studyQuotes[currentQuoteIndex])
                                .font(.title3)
                                .padding()
                                .foregroundColor(.white)
                                .frame(maxWidth: 370)
                        }
                        .padding(.horizontal)
                        .onAppear {
                            updateQuote()
                        }
                    }
                    .frame(maxWidth: 350, maxHeight: 400)
                    .cornerRadius(20)

                    
                    
                }
                
                Spacer()
                
                Button(action: {
                    isShowingLogoutConfirmation.toggle()
                }) {
                    HStack {
                            Image(systemName: "person.fill.badge.minus")
                                .font(.title)
                                .foregroundColor(.white)
                            
                            Text("Logout")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(10)
                        }
                }.alert("Logout", isPresented: $isShowingLogoutConfirmation) {
                    Button("Cancel", role: .cancel) {
                        // nothing needed here
                    }
                    Button("Yes", role: .destructive) {
                        do { try Auth.auth().signOut() }
                        catch { print("Already logged out") }
                        showProfile.toggle()
                    }
                } message: {
                    Text("Are you sure?")
                }
                .frame(maxWidth: 210)
                .frame(height: 50)
                .background(Color.black)
                .cornerRadius(10)
                
                Spacer().frame(height: 20)
                
            }
        }
    }
    
    private func updateQuote() {
        currentQuoteIndex = Int.random(in: 0..<studyQuotes.count)
    }
    
}

struct homeView_Previews: PreviewProvider {
    static var previews: some View {
        homeView(showProfile: .constant(true))
    }
}
