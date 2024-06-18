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
                        LabeledContent("Account Type", value: "Investor")
                    }
                }
                
                Section {
                    Button("Log Out", role: .destructive) {
                        withAnimation {
                            loggedIn = false
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
