//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Bartosz Wojtkowiak on 05/12/2021.
//

import SwiftUI

struct AnswerButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(minWidth: 100, minHeight: 20)
            .padding()
            .foregroundColor(.pink)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color(red: 0.4627, green: 0.8392, blue: 1.0)))
    }
}

extension View {
    func roundedButtonStyle() -> some View {
        modifier(AnswerButton())
    }
}

struct ContentView: View {
    @State private var options = ["Paper", "Rock", "Scissors"]
    @State private var appMove = Int.random(in: 0...2)
    @State private var playerMove = ""
    @State private var shouldPlayerWin = true
    @State private var score = 0
    @State private var answersCount = 1
    @State private var endGame = false
    @State private var alertTitle = "Game Over"
    
    var winOrLose: String {
        var answer: String
        
        if shouldPlayerWin == true {
            answer = "Win"
        } else {
            answer = "Lose"
        }
        
        return answer
    }
    
    var result: Bool {
        switch shouldPlayerWin {
        case true:
            if playerMove == "Scissors" && appMove == 0 {
                return true
            } else if playerMove == "Paper" && appMove == 1 {
                return true
            } else if playerMove == "Rock" && appMove == 2 {
                return true
            } else {
                return false
            }
        case false:
            if playerMove == "Rock" && appMove == 0 {
                return true
            } else if playerMove == "Scissors" && appMove == 1 {
                return true
            } else if playerMove == "Paper" && appMove == 2 {
                return true
            } else {
                return false
            }
        }
    }
    
    var body: some View {
        ZStack {
            AngularGradient(gradient: Gradient(colors: [.red, .blue, .purple, .red]), center: .center)
            VStack {
                Spacer()
                
                Text("Your score: \(score)")
                    .font(.title)
                
                Spacer()
                
                Text("Now you need to: \(winOrLose)")
                    .font(.subheadline)
                Text("Application move: \(options[appMove])")
                    .font(.subheadline)
                
                Spacer()
                
                Button("\(options[0])", action: paperButton).roundedButtonStyle()
                Button("\(options[1])", action: rockButton).roundedButtonStyle()
                Button("\(options[2])", action: scissorsButton).roundedButtonStyle()
                
                Spacer()
            }
        }
        .alert(alertTitle, isPresented: $endGame) {
            Button("Play again", action: playAgain)
        } message: {
            Text("Your score is \(score)")
        }
    }
    
    func chooseAppMove() {
        appMove = Int.random(in: 0...2)
    }
    
    func chooseIfPlayerShouldWin() {
        shouldPlayerWin = Bool.random()
    }
    
    func checkCount() {
        if answersCount == 10 {
            endGame = true
        }
    }
    
    func playAgain() {
        endGame = false
        answersCount = 0
        score = 0
        chooseAppMove()
        chooseIfPlayerShouldWin()
    }
    
    func paperButton() {
        answersCount += 1
        playerMove = options[0]
        playNextRound()
    }
    
    func rockButton() {
        answersCount += 1
        playerMove = options[1]
        playNextRound()
    }
    
    func scissorsButton() {
        answersCount += 1
        playerMove = options[2]
        playNextRound()
    }
    
    func checkMove() {
        if result == true {
            score += 1
        } else {
            score -= 1
        }
    }
    
    func playNextRound() {
        checkMove()
        checkCount()
        chooseIfPlayerShouldWin()
        chooseAppMove()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
