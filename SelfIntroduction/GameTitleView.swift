//
//  GameTitleView.swift
//  SelfIntroduction
//
//  Created by KSU Engineearts on 2024/05/08.
//

import SwiftUI

struct GameTitleView: View {
    @State var showingPopUp = false
    var body: some View {
        NavigationView {
            ZStack{
                VStack {
                    Text("GameTitle")
                        .font(.largeTitle)
                    NavigationLink(destination: TextDataView()) {
                        Text("TextData")
                            .font(.largeTitle)
                            .foregroundStyle(Color.gray)
                            .padding()
                            .background(Color.white, in: RoundedRectangle(cornerRadius: 8))//背景の形と色を決めている
                            .font(.largeTitle)//文字のサイズ
                        
                    }
                    NavigationLink(destination: DataView()) {
                        Text("Data")
                            .font(.largeTitle)
                            .foregroundStyle(Color.gray)
                            .padding()
                            .background(Color.blue, in: RoundedRectangle(cornerRadius: 8))//背景の形と色を決めている
                            .font(.largeTitle)//文字のサイズ
                        
                    }
                    
                    Button(action: {
                        withAnimation {
                            showingPopUp = true
                        }
                    }, label: {
                        Text("Let's Play")
                            .font(.largeTitle)
                            .foregroundStyle(Color.white)
                            .padding()
                            .background(Color.gray, in: RoundedRectangle(cornerRadius:8))//背景の形と色を決定
                        
                    })
                }
                if showingPopUp {
                    PopupView(isPresent: $showingPopUp)
                        
                }
            }
            
        }
    }
}


struct GameTitleView_Previews: PreviewProvider {
    static var previews: some View {
        GameTitleView()
    }
}
//#Preview {
//    GameTitleView()
//}
