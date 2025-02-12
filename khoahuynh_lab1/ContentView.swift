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
    @State private var countdown = 5  // ⏳ Countdown timer
    @State private var timer: Timer? = nil
    
    
    var body: some View {
            VStack(spacing: 20) {
                // 🔥 Countdown Timer at the Top
                Text("Time Left: \(countdown) sec")
                    .font(.title)
                    .foregroundColor(countdown > 2 ? .blue : .red)
                    .bold()
                
                Text("Is this number Prime?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("\(number)")
                    .font(.system(size: 80, weight: .bold))
                
                
                    
                    
                }
                .padding(.horizontal)
                
                if let result = isCorrect {
                    Image(systemName: result ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(result ? .green : .red)
                }
            }
           
        
        
        // Prime Number Check
        func isPrime(_ num: Int) -> Bool {
            guard num > 1 else { return false }
            for i in 2..<num where num % i == 0 {
                return false
            }
            return true
        }
        
       
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
