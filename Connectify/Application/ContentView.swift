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
    
    @State private var alertShowing = false
    
    @AppStorage("loggedIn", store: .standard) private var loggedIn = false
    @AppStorage("email", store: .standard) private var emailPersisted = ""
    @AppStorage("isStudentAccount", store: .standard) private var isStudentAccount = false
    
    var body: some View {
        if !loggedIn {
            ZStack {
                Color(.systemGroupedBackground)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 16) {
                    Text("Connectify")
                        .font(.title)
                        .fontWeight(.heavy)
                        .padding(.bottom, 24)
                    
                    HStack {
                        Image(systemName: "envelope")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.accentColor)
                        TextField("Email", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Image(systemName: "lock")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.accentColor)
                        SecureField("Password", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 24)
                    
                    Button {
                        withAnimation {
                            if email.contains(".edu") {
                                loggedIn = true
                                isStudentAccount = true
                                emailPersisted = email
                                email = ""
                                password = ""
                            } else if email == "realinvestor@gmail.com" {
                                loggedIn = true
                                isStudentAccount = false
                                emailPersisted = email
                                email = ""
                                password = ""
                            } else {
                                alertShowing = true
                            }
                        }
                    } label: {
                        Text("Login")
                            .padding(5)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(email.isEmpty || !email.contains("@") || password.isEmpty)
                }
                .padding()
                .alert(isPresented: $alertShowing) {
                    Alert(title: Text("Invalid Credentials"),
                          message: Text("Ensure that your email and password are valid."),
                          primaryButton: .default(Text("OK"), action: {}),
                          secondaryButton: .destructive(Text("Cancel")))
                }
            }
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
