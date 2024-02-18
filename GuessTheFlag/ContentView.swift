//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Leonard Holter on 16/02/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    
    @State private var userScore: Int = 0
    
    @State private var round: Int = 0
    
    @State private var endStaus = false
    
    var body: some View {
        ZStack {
            
            Color.indigo
            
            .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                Text("Guess the flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                
                VStack(spacing: 30) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .foregroundStyle(.white)
                            .font(.largeTitle.weight(.semibold))
                        
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                            
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius:0)
                            
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(userScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert("Game Over!", isPresented: $endStaus) {
            Button("Restart", action: endOfGame)
        }message: {
            Text("Final Score:  \(userScore) ")}
        
        
        
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(userScore) ")
            
            
        
        
            
            
        }
    }
    
    
    func flagTapped(_ number: Int) {
        
        round += 1
        if round == 8 {
            endStaus = true
        }
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
            
        } else {
            scoreTitle = "Wrong. That's the flag of \(countries[number])"
        }
        
        showingScore = true
        
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    
    func endOfGame () {
        userScore = 0
        round = 0
        
    }
    
    
    }

    
#Preview {
    ContentView()
}
