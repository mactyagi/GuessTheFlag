//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Admin on 01/12/23.
//

import SwiftUI

struct ContentView: View {
    let totalRound = 3
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"]
    @State var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var currentRound = 1
    @State private var currentRoundScore = 0
    @State private var showingAlertForGameCompletion = false
    @State var showingAlert = false
    @State private var showingScore = false
    @State private var scoreTitle = ""
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            
            VStack{
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing: 15){
                    VStack{
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0 ..< 3){ number in
                        Button(action: {
                            flagTapped(number)
                        }, label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        })
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                Spacer()
                Spacer()
                
                HStack{
                    Text("Score: \(score)")
                        .foregroundStyle(.white)
                        .font(.title.bold())
                    Spacer()
                    Text("Round: \(currentRound)/\(totalRound)")
                        .foregroundStyle(.white)
                        .font(.title.bold())
                }
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingAlert, actions: {
            Button {
                askQuestion()
            } label: {
                Text("Continue")
            }
        }, message: {
            Text("Your current round score is \(currentRoundScore)")
        })
        
        .alert("Game Complete", isPresented: $showingAlertForGameCompletion) {
            Button {
                currentRound = 1
                score = 0
            } label: {
                Text("Restart")
            }

        }message: {
            Text("you score \(score) out of \(10 * totalRound)")
        }
    }
    
    
    func flagTapped(_ number: Int){
        if currentRound == totalRound{
            showingAlertForGameCompletion = true
            return
        }
        if number == correctAnswer{
            scoreTitle = "Correct"
            currentRoundScore = 10
            score += 10
        } else{
            scoreTitle = "Wrong"
            currentRoundScore = 0
        }
        showingAlert = true
    }
    
    func askQuestion(){
        currentRound += 1
        countries.shuffle()
        correctAnswer = Int.random(in: 0 ... 2)
    }
}

#Preview {
    ContentView()
}
