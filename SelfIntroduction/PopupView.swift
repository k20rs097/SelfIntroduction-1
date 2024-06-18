//
//  PopupView.swift
//  SelfIntroduction
//
//  Created by KSU Engineearts on 2024/05/28.
//

import SwiftUI

struct PopupView: View {
    enum Constants {
        static let bounds = UIScreen.main.bounds
        static let width = CGFloat(bounds.width)
        static let height = CGFloat(bounds.height)
    }
    @Binding var isPresent: Bool
    
    var body: some View {
        ZStack{
            Color.gray.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    // ポップアップ以外の背景をタップしたらポップアップを閉じる
                    withAnimation {
                        isPresent = false
                    }
                }
            VStack(spacing: 12) {
                HStack{
                    Spacer()
                    Button(action: {
                        withAnimation {
                            isPresent = false
                        }
                    }, label: {
                        Image(systemName: "xmark.circle")
                            .font(.largeTitle)
                            .foregroundColor(.red)
                    })
                }
                
                Text("Difficulty")
                    .font(.largeTitle)
                NavigationLink(destination: Game2View(size: 1024)) {
                    NavigationButton("easy", Color.green)
                }
                NavigationLink(destination: Game2View(size: 256)) {
                    NavigationButton("normal", Color.yellow)
                }
                NavigationLink(destination: Game2View(size: 64)) {
                    NavigationButton("hard", Color.red)
                }
            }
            .frame(width: Constants.width * 0.8, alignment: .center)
            .padding()
            .background(Color.white)
            .cornerRadius(12)
        }
    }
    
    private func NavigationButton(_ difficulty: String, _ color: Color) -> some View {
        Text(difficulty)
            .frame(width: Constants.width * 0.65)
            .font(.largeTitle)
            .foregroundStyle(.gray)
            .padding()
            .background(color, in: RoundedRectangle(cornerRadius: 8))//背景の形と色を決めている
            .font(.largeTitle)//文字のサイズ
    }
}


struct PopupView_Previews: PreviewProvider {
    static var previews: some View {
        PopupView(isPresent: .constant(true))
    }
}
