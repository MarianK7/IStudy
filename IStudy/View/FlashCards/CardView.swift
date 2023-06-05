//
//  CardView.swift
//  IStudy
//
//  Created by Marián Keszi on 26/05/2023.
//

import SwiftUI

struct CardView: View {
    @State var fliping = false
    @State var shouldDisapper = false
    var name = ""
    var question = ""
    var answer = ""
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.gray.opacity(0.7))
                .frame(width: 270, height: 390)
                .rotation3DEffect(.degrees(fliping ? 180 : 0), axis: (x:0, y: 1, z: 0))
            VStack(alignment: .leading) {
                if fliping{
                    Text(name)
                        .font(.title).bold()
                        .foregroundColor(.black)
                    Text(answer)
                        .font(.title2).bold()
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .frame(width: 250, height: 250)
                }else{
                    Text(name)
                        .font(.title).bold()
                        .foregroundColor(.black)
                    Text(question)
                        .font(.title2).bold()
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .frame(width: 250, height: 250)
                }
               
                
            }
            .opacity(shouldDisapper ? 0 : 1)
        }
        .onTapGesture {
            shouldDisapper.toggle()
            withAnimation(.easeInOut(duration: 0.5)) {
                fliping.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    shouldDisapper = false
                }
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
