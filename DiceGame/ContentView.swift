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
    @State var playerBalance = 100
    @State var texField = "Put in number"
    @State var userInput: String = "0"
    @State var pot = 0
    @State private var selectedDiceType = "fill"
        let diceTypes = ["black", "white"]


    
    var body: some View {
      
        ZStack{
            Color(red: 38/256, green:108/256, blue: 59/256)
                .ignoresSafeArea()
            VStack {
                Text("\(playerBalance)")
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                
                Text("\(userInput)")
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                Text("\(botSum)")
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                TextField(texField, text: $userInput)
                    .foregroundColor(.black)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Spacer()
                
                
                HStack{
                   // DiceView(n: playerDice)
                    DiceView(diceType: selectedDiceType, n: botDice)
                    
                }.onAppear(){
                   // newDiceValues()
                }
                Picker("Välj tärningstyp", selection: $selectedDiceType) {
                               ForEach(diceTypes, id: \.self) { type in
                                   Text(type).tag(type)
                               }
                           }
                           .pickerStyle(SegmentedPickerStyle())
                       
                
                
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
                
                
                Button(action:  {
                    bet()
                }, label: {
                    Text("Bet")
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
            botSum = 0
        userInput = ""} , content: {
           WinSheet(playerSum: playerSum, botSum: botSum)
         
       
    })
    

    }
                
    
    
    func roll(){
       // newDiceValues()
        playerSum += playerDice

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // Lägg märke till "+ 2", det är din fördröjning i sekunder!
           
            botDiceValue()
            botSum += botDice
            win()
        }
    }
    func bet() {
        playerBalance -= 10
        pot += 10 * 2
    }
    
    func win() {
        if let userInputAsInt = Int(userInput) { // Försöker konvertera strängen till en Int
            if userInputAsInt != 0 && botSum != 0 { // Jämför det konverterade värdet med botSum
                showingWinSheet = true
                playerSum = userInputAsInt
                if(userInputAsInt == botSum){
                    playerBalance += pot
                }else{
                    pot = 0
                }
                
        
            }
        } else {
            // Hantera fallet där konverteringen misslyckas, kanske visa ett felmeddelande?
        }
    }
    //func newDiceValues() {
      // playerDice = Int.random(in: 1...6)
  
    //}
    func botDiceValue() {
        botDice = Int.random(in: 1...6)
        
    }
}


struct DiceView: View {
    var diceType: String
    var n: Int

    var body: some View {
        if diceType == "black" {
            Image(systemName: "die.face.\(n).fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
        } else {
            Image(systemName: "die.face.\(n)")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
        }
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
                    Text("Winer bot to high")
                        .foregroundColor(.white)
                        .font(.title)
                } else if(playerSum == botSum) {
                    Text("Winer player")
                        .foregroundColor(.white)
                        .font(.title)
                }else {
                    Text("Winer bot to low")
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
