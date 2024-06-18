//
//  ContentView.swift
//  Connectify
//
//  Created by Tristan Chay on 18/6/24.
//

import SwiftUI

struct ContentView: View {
        
    @AppStorage("showingOnboarding", store: .standard) private var showingOnboarding = true
    
    @State private var email = ""
    @State private var password = ""
    
    @AppStorage("loggedIn", store: .standard) private var loggedIn = false
    @AppStorage("isStudentAccount", store: .standard) private var isStudentAccount = false
    
    var body: some View {
        if !loggedIn {
            VStack {
                Text("Connectify")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title)
                    .fontWeight(.heavy)
                TextField("Email", text: $email)
                    .textFieldStyle(.roundedBorder)
                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)
                Button("Login") {
                    withAnimation {
                        loggedIn = true
                        if email.split(separator: "@")[1].contains(".edu") {
                            isStudentAccount = true
                        } else {
                            isStudentAccount = false
                        }
                        
                        email = ""
                        password = ""
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(email.isEmpty || !email.contains("@") || password.isEmpty)
            }
            .padding(.horizontal)
            .sheet(isPresented: $showingOnboarding) {
                OnboardingView()
            }
        } else {
            MainView()
        }
    }
}

#Preview {
    ContentView()
}
