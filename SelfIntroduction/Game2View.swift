//
//  Game2View.swift
//  SelfIntroduction
//
//  Created by KSU Engineearts on 2024/05/07.
//

import SwiftUI
import AVFoundation

struct Game2View: View {
    @State var size: CGFloat
    @State private var x = CGFloat.zero
    @State private var y = CGFloat.zero
    @State private var score = 0
    @State private var remainingSeconds = 10
    @State private var isTimerRunning = false
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var player: AVAudioPlayer?
    
    enum Constants {
        static let bounds = UIScreen.main.bounds
        static let width = CGFloat(bounds.width)
        static let height = CGFloat(bounds.height)
    }
    
    var body: some View {
        GeometryReader {geometry in
            let faceImageViewWidth = getScreenWidth(geometry)
            let faceImageViewHeight = getScreenHeight(geometry)
            ZStack{
                faceImageView(x: $x, y: $y, score: $score, isTimerRunning: $isTimerRunning, player: $player, size: size)
                    .frame(height: faceImageViewHeight)
                VStack{
                    Text("score:\(score)")
                    Text("\(remainingSeconds)")
                        .font(.largeTitle)
                        .padding()
                    Spacer()
                    Button(action: {
                        if remainingSeconds <= 0 {
                            _init(faceImageViewWidth
                                  , faceImageViewHeight)
                        } else if remainingSeconds == 10 {
                            isTimerRunning.toggle()
                        }
                    }) {
                        Text("Start")
                            .padding()
                    }
                }
                .onReceive(timer) { _ in
                    if isTimerRunning {
                        if remainingSeconds > 0 {
                            remainingSeconds -= 1
                        } else {
                            isTimerRunning = false
                        }
                    }
                }
//                Text("・")
//                    .position(CGPoint(x: Constants.width/2, y: Constants.height/2))
//                    .foregroundStyle(.blue)
//                    .font(.largeTitle)
            }
        }
    }
    
    private func getScreenWidth(_ geometry: GeometryProxy) -> CGFloat {
        return geometry.size.width
    }
    
    private func getScreenHeight(_ geometry: GeometryProxy) -> CGFloat {
        return geometry.size.height * 0.7
    }
    
    private func _init(_ faceImageViewWidth: CGFloat, _ faceImageViewHeight: CGFloat) {
        x = faceImageViewWidth / 2
        y = faceImageViewHeight / 2
        remainingSeconds = 10
        score = 0
    }
    
    struct faceImageView: View {
        @Binding var x: CGFloat
        @Binding var y: CGFloat
        @Binding var score: Int
        @Binding var isTimerRunning: Bool
        @Binding var player: AVAudioPlayer?
        
        var size: CGFloat
        
        var body: some View {
            GeometryReader { geometry2 in
                Image("face")
                    .resizable()
                    .scaledToFit()
                    .frame(width: size)
                    .position(x: x, y: y)
                    .onAppear() {
//                        x = geometry2.frame(in: .global).maxX / 2
//                        y = geometry2.frame(in: .global).maxY / 2
                        x = geometry2.size.width / 2
                        y = geometry2.size.height / 2
                        print("onAppeared")
                        print("x: \(x), y: \(y)")
                        print("geometry2.frame(in: .global): \(geometry2.frame(in: .global).maxY)")
                        print("geometry2.frame(in: .local): \(geometry2.frame(in: .local).maxY)")
                    }
                    .onTapGesture {
                        if isTimerRunning {
                            playSound("voice2")
                            x = CGFloat.random(in: geometry2.frame(in: .local).minX + 100...geometry2.frame(in: .local).maxX - size / 2)
                            y = CGFloat.random(in: geometry2.frame(in: .local).minY + 100...geometry2.frame(in: .local).maxY - size / 2)
                            score += 1
                        } else {
                            playSound("voice1")
                        }
                    }
            }
        }
        private func playSound(_ audioName: String) {
            guard let url = Bundle.main.url(forResource: audioName, withExtension: "mp3") else { return }
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.play()
            } catch {
                print("Error playing sound: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    Game2View(size:256)
}
