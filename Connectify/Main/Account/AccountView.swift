//
//  AccountView.swift
//  Connectify
//
//  Created by Tristan Chay on 18/6/24.
//

import SwiftUI

struct AccountView: View {
    
    @AppStorage("loggedIn", store: .standard) private var loggedIn = false
    @AppStorage("isStudentAccount", store: .standard) private var isStudentAccount = false
    @AppStorage("showingOnboarding", store: .standard) private var showingOnboarding = true
    
    @AppStorage("accounttype", store: .standard) private var accounttype = "Investor"
    
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 48)
                            .foregroundColor(.blue)
                        VStack(alignment: .leading) {
                            Text("Account Name")
                                .font(.headline)
                                .fontWeight(.bold)
                            Text("Tap to view more information")
                                .font(.footnote)
                                .fontWeight(.bold)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.leading, 5)
                    }
                    .padding(.vertical, 5)
                    
                    if isStudentAccount {
                        LabeledContent("Account Type", value: "Student")
                    } else {
                        LabeledContent("Account Type") {
                            Picker("", selection: $accounttype) {
                                Text("Investor")
                                    .tag("Investor")
                                Text("Reviewer")
                                    .tag("Reviewer")
                            }
                        }
                    }
                }
                
                Section {
                    Button("Log Out", role: .destructive) {
                        withAnimation {
                            loggedIn = false
                        }
                    }
                    Button("Log Out and show Onboarding", role: .destructive) {
                        withAnimation {
                            loggedIn = false
                            showingOnboarding = true
                        }
                    }
                }
            }
            .navigationTitle("Account")
        }
    }
}

#Preview {
    AccountView()
}
