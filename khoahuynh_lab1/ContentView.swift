//  ContentView.swift
//  khoahuynh_lab1
//  Created by Khoa Huynh Ly Nhut on 2025-02-12.
//  Lab 1 - assignment 1 101418497


import SwiftUI

import SwiftUI

struct ContentView: View {
    @State private var number = Int.random(in: 1...100)  // Random number to check
    @State private var correctAnswers = 0  // Count correct answers
    @State private var wrongAnswers = 0  // Count wrong answers
    @State private var attempts = 0  // Track total attempts
    @State private var showResult = false  // Show summary after 10 attempts
    @State private var isCorrect: Bool? = nil  // Correct or incorrect indicator
    @State private var countdown = 5  // Countdown timer
    @State private var timer: Timer? = nil  // Timer reference
    @State private var feedbackMessage = ""  // Feedback message
    
    var body: some View {
        VStack(spacing: 20) {
            //  Countdown Timer
            Text("Time Left: \(countdown) sec")
                .font(.title)
                .foregroundColor(countdown > 2 ? .blue : .red)
                .bold()

            Text("Is this Prime?")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("\(number)")
                .font(.system(size: 80, weight: .bold))

            // Prime &  Not Prime Buttons
            HStack {
                Button(action: {
                    checkAnswer(isPrime: true)
                }) {
                    Text("Prime")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button(action: {
                    checkAnswer(isPrime: false)
                }) {
                    Text("Not Prime")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal)

            //Feedback Message
            if !feedbackMessage.isEmpty {
                Text(feedbackMessage)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(isCorrect == true ? .green : .red)
                    .padding()
            }

            // Correct/Incorrect Indicator
            if let result = isCorrect {
                Image(systemName: result ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(result ? .green : .red)
            }
        }
        .padding()
        .alert("Game Summary", isPresented: $showResult) {
            Button("OK", action: resetGame)
        } message: {
            Text("Correct: \(correctAnswers)\nWrong: \(wrongAnswers)")
        }
        .onAppear(perform: startTimer)
    }
    
    //  Prime Number Check
    func isPrime(_ num: Int) -> Bool {
        guard num > 1 else { return false }
        for i in 2..<num where num % i == 0 {
            return false
        }
        return true
    }
    
    // Check User's Answer
    func checkAnswer(isPrime userChoice: Bool) {
        timer?.invalidate()  // Stop the timer
        
        let correctAnswer = isPrime(number)  // Check if the number is actually prime
        
        if userChoice == correctAnswer {
            correctAnswers += 1
            isCorrect = true
            feedbackMessage = " Congrats! You're correct. Correct Answers: \(correctAnswers)"
        } else {
            wrongAnswers += 1
            isCorrect = false
            feedbackMessage = "Oops! Incorrect. Incorrect Answers: \(wrongAnswers)"
        }
        
        attempts += 1
        if attempts % 10 == 0 {
            showResult = true
        } else {
            nextRound()
        }
    }
    
    //  Start a New Round
    func nextRound() {
        number = Int.random(in: 1...100)
        isCorrect = nil
        feedbackMessage = ""  // Clear feedback message for next round
        startTimer()
    }
    //  Reset the Game
    func resetGame() {
        correctAnswers = 0
        wrongAnswers = 0
        attempts = 0
        nextRound()
    }
    
    // ⏳ Start Timer with Countdown
    func startTimer() {
        countdown = 5  // Reset countdown
        timer?.invalidate()  // Stop any previous timer
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if countdown > 0 {
                countdown -= 1  // Update timer every second
            } else {
                timer?.invalidate()
                wrongAnswers += 1
                attempts += 1
                isCorrect = false
                feedbackMessage = " Time's up! Incorrect Answers: \(wrongAnswers)"
                
                if attempts % 10 == 0 {
                    showResult = true
                } else {
                    nextRound()
                }
            }
        }
    }
}

//Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


