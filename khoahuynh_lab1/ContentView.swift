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
    
}
