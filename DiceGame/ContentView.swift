//
//  ContentView.swift
//  DiceGame
//
//  Created by Alvin Johansson on 2024-04-09.
//

import SwiftUI

struct ContentView: View {
    
    @State var playerDice = 3
    @State var botDice = 3
    @State var playerSum = 0
    @State var botSum = 0
    @State var showingWinSheet = false
    
    var body: some View {
        ZStack{
            Color(red: 38/256, green:108/256, blue: 59/256)
                .ignoresSafeArea()
            VStack {
                Text("\(playerSum)")
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                Text("\(botSum)")
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                Spacer()
                
                HStack{
                    DiceView(n: playerDice)
                    DiceView(n: botDice)
                    
                }.onAppear(){
                    newDiceValues()
                }
                
                
                Button(action:  {
                    roll()
                }, label: {
                    Text("roll")
                        .font(.largeTitle)
                        .foregroundColor(Color.white)
                        .padding()
                    
                }
                )
                .background(Color.red)
                .cornerRadius(15.0)
                Spacer()
                
                
            }
        }
        .sheet(isPresented: $showingWinSheet, onDismiss: { playerSum = 0
            botSum = 0} , content: {
           WinSheet(playerSum: playerSum, botSum: botSum)
         
       
    })
    

    }
                
    
    
    func roll(){
        newDiceValues()
        playerSum += playerDice

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // Lägg märke till "+ 2", det är din fördröjning i sekunder!
           
            botDiceValue()
            botSum += botDice
            win()
        }
    }
               func win() {
                   if(playerSum != 0 && botSum != 0) {
                    showingWinSheet = true
                          
                      }
                       
                   }


    func newDiceValues() {
       playerDice = Int.random(in: 1...6)
  
    }
    func botDiceValue() {
        botDice = Int.random(in: 1...6)
        
    }
}

struct DiceView : View {
    var n : Int
    var body: some View {
        Image(systemName: "die.face.\(n)")
            .resizable().aspectRatio(contentMode: .fit).padding()
        
    }
}
struct WinSheet :View {
    let playerSum : Int
    let botSum : Int
    var body: some View {
        ZStack{
            Color(red: 38/256, green:108/256, blue: 59/256)
                .ignoresSafeArea()
            
            VStack {
                if(playerSum > botSum){
                    Text("Winer player")
                        .foregroundColor(.white)
                        .font(.title)
                } else if(playerSum == botSum) {
                    Text("Draw")
                        .foregroundColor(.white)
                        .font(.title)
                }else {
                    Text("Winer bot")
                        .foregroundColor(.white)
                        .font(.title)
                }
                
                Text("\(playerSum)")
                    .foregroundColor(.red)
                    .font(.title)
                Text("\(botSum)")
                    .foregroundColor(.red)
                    .font(.title)
            }
            
        }
    }
}




#Preview {
    ContentView()
}
