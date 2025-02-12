//
//  ContentView.swift
//  khoahuynh_lab1
//
//  Created by Khoa Huynh Ly Nhut on 2025-02-12.
//
import SwiftUI

struct ContentView: View {
    @State private var number = Int.random(in: 1...100)
    @State private var correctAnswers = 0
    @State private var wrongAnswers = 0
    @State private var attempts = 0
    @State private var showResult = false
    @State private var isCorrect: Bool? = nil
    @State private var countdown = 5  // Countdown timer
    @State private var timer: Timer? = nil
    @State private var feedbackMessage = ""

    
    
    var body: some View {
            VStack(spacing: 20) {
                
                
                // Message feedback
                if !feedbackMessage.isEmpty {
                        Text(feedbackMessage)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(isCorrect == true ? .green : .red)
                            .padding()
                    }
                
                // Countdown Timer at the Top
                Text("Time Left: \(countdown) sec")
                    .font(.title)
                    .foregroundColor(countdown > 2 ? .blue : .red)
                    .bold()
                
                Text("Is this Prime?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("\(number)")
                    .font(.system(size: 80, weight: .bold))
                
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
        
        // Prime Number Check
        func isPrime(_ num: Int) -> Bool {
            guard num > 1 else { return false }
            for i in 2..<num where num % i == 0 {
                return false
            }
            return true
        }
        
        //Check User's Answer
        func checkAnswer(isPrime: Bool) {
            timer?.invalidate()
            
            if isPrime == isPrime {
                correctAnswers += 1
                isCorrect = true
                feedbackMessage = "Congrats! You're correct. Correct Answers: \(correctAnswers)"
            } else {
                wrongAnswers += 1
                isCorrect = false
                feedbackMessage = "You are incorrect. Correct Answers: \(correctAnswers)"
            }
            
            attempts += 1
            if attempts % 10 == 0 {
                showResult = true
            } else {
                nextRound()
            }
        }
        
        // Start a New Round
        func nextRound() {
            number = Int.random(in: 1...100)
            isCorrect = nil
            startTimer()
        }
        
        // Reset the Game
        func resetGame() {
            correctAnswers = 0
            wrongAnswers = 0
            attempts = 0
            nextRound()
        }
        
        //  Start Timer with Countdown
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
                    
                    if attempts % 10 == 0 {
                        showResult = true
                    } else {
                        nextRound()
                    }
                }
            }
        }
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }

