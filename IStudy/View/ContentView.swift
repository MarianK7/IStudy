//
//  ContentView.swift
//  IStudy
//
//  Created by Marián Keszi on 11/05/2023.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @State private var text: String = "Sign in"
    @State private var isSquareVisible: Bool = false
    @State private var count = 0
    @State var isSignInOrUp  = true
    @State var textfield = ""
    @State var email  = ""
    @State var password = ""
    @State var showProfile: Bool = false
    @State var resetPass: Bool = true
    @State var showalert: Bool = false
    @State var showAlertView: Bool = false
    @State var alertTitle: String = ""
    @State var alertMassage: String = ""
    let SigninS =  "Sign in"
    let SignUpS =  "Sign Up"
    var body: some View {
        ZStack {
            Image("TaskView")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack {
                VStack(spacing: 15) {
                    signText()
                    EPtextfield(EPtype: $email, icon: "envelope.fill", text: "Email", isPassword: false)
                    Line()
                    EPtextfield(EPtype: $password, icon: "key.fill", text: "Password", isPassword: true)
                    SigninOrUpButton()
                }
                .padding(.horizontal)
                .frame(width: 375, height: 330)
                .background(.white)
                .cornerRadius(30)
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .stroke(.black,lineWidth: 5)
                })
                .padding()
                if resetPass == true {
                    Text("Reset password").bold()
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.horizontal,80)
                        .onTapGesture {
                            sentresetpassword()
                        }
                }
            }
            
        }
        .overlay(alignment: .bottomLeading, content: {
            swichsignbutton()
                .frame(width: 270, height: 50)
                .padding()
        })
        .fullScreenCover(isPresented: $showProfile, content: {
            profileView(showProfile: $showProfile)
        })
        .alert(isPresented: $showAlertView, content: {
            Alert(title: Text(alertTitle), message: Text(alertMassage), dismissButton: .cancel())
        })
        
    }
    func sentresetpassword(){
        Auth.auth().sendPasswordReset(withEmail: email){
            error in
            guard error == nil else{
                alertTitle = "Uh-oh!"
                alertMassage = (error!.localizedDescription)
                showAlertView.toggle()
                return
            }
            alertTitle = "password reset email sent"
            alertMassage = "check your email"
            showAlertView.toggle()
        }
    }
    func signinorup(){
        if isSignInOrUp{
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                guard error == nil else{
                    alertTitle = "Uh-oh!"
                    alertMassage = (error!.localizedDescription)
                    showAlertView.toggle()
                    return
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    password = ""
                }
                showProfile.toggle()
            }
        }else{
            Auth.auth().createUser(withEmail: email, password: password){
                result,error in
                guard error == nil else{
                    alertTitle = "Uh-oh!"
                    alertMassage = (error!.localizedDescription)
                    showAlertView.toggle()
                    return
                }
                alertTitle = "Registration successfull"
                showAlertView.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    text = SigninS
                    isSignInOrUp.toggle()
                }
            }
        }
        
    }
    func keyBAnimation(){
        if count == 5 {
            count = 0
            isSquareVisible = false
            return
        }
        withAnimation(.easeInOut(duration: 0.5)){
            self.isSquareVisible.toggle()
            
        }
        count += 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4){
            self.keyBAnimation()
        }
    }
    func typeText(){
        text = ""
        for character in isSignInOrUp ? SigninS : SignUpS {
            text += "\(character)"
            RunLoop.current.run(until: Date() + 0.15)
        }
    }
    @ViewBuilder
    func  swichsignbutton() -> some View {
        Spacer()
        Button(action: {
            withAnimation{
                email = ""
                text = ""
                password = ""
                keyBAnimation()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    self.typeText()
                }
                resetPass.toggle()
                isSignInOrUp.toggle()
            }
            
        }, label: {
            HStack{
                Image(systemName: isSignInOrUp == false ? "envelope.fill": "envelope")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.black)
                Text(isSignInOrUp ? "Sign UP" : "Sign in").bold()
                    .font(.title2)
                    .foregroundColor(.white)
            }
        })
        Spacer()
    }
    @ViewBuilder
    func  signText() -> some View {
        HStack{
            Text(text).bold()
                .font(.largeTitle)
                .foregroundColor(.black)
            if isSquareVisible{
                Rectangle()
                    .frame(width: 3, height: 30)
                    .foregroundColor(.black)
            }
        }
        .frame(maxWidth: .infinity,alignment: .leading)
        .frame(height: 55)
        
    }
    @ViewBuilder
    func  Line() -> some View {
        Rectangle()
            .frame(maxWidth: .infinity)
            .frame(height: 2)
            .padding(.horizontal,10)
            .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.white,.black]), startPoint: .leading, endPoint: .trailing))
        
    }
    @ViewBuilder
    func  SigninOrUpButton() -> some View {
        Button(action: {
            signinorup()
        }, label: {
            Text(isSignInOrUp ? "Sign in" : "Create account").bold()
                .font(.title2).bold()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(.black)
                .cornerRadius(15)
                .shadow(color: .black.opacity(0.20), radius: 4, x: 3, y: 4)
                .shadow(color: .black.opacity(0.20), radius: 4, x: -3, y: -4)
            
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct EPtextfield: View {
    @Binding var EPtype: String
    @State private var isPasswordVisible = false
    var icon = ""
    var text = ""
    var isPassword: Bool
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .frame(width: 44, height: 44)
                .foregroundColor(Color.gray)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .shadow(color: .black.opacity(0.20), radius: 5, x: 0, y: 5)
                .padding(.horizontal)
            
            if isPassword {
                if isPasswordVisible {
                    TextField(text, text: $EPtype)
                        .colorScheme(.light)
                        .foregroundColor(.black)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                } else {
                    SecureField(text, text: $EPtype)
                        .colorScheme(.light)
                        .foregroundColor(.black)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }
                
                Button(action: {
                    isPasswordVisible.toggle()
                }) {
                    Image(systemName: isPasswordVisible ? "eye.fill" : "eye.slash.fill")
                        .foregroundColor(.gray)
                }
                .padding(.trailing, 8)
            } else {
                TextField(text, text: $EPtype)
                    .colorScheme(.light)
                    .foregroundColor(.black)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
            }
        }
        .frame(height: 50)
    }
}
