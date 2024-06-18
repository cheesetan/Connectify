//
//  OnboardingView.swift
//  Connectify
//
//  Created by Tristan Chay on 18/6/24.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        VStack {
            Text("Welcome to Connectify")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            item(icon: "person.badge.key.fill", title: "hello", description: "what")
            item(icon: "person.badge.key.fill", title: "hello", description: "what")
            item(icon: "person.badge.key.fill", title: "hello", description: "what")
            Spacer()
            Button {
                
            } label: {
                Text("Continue")
                    .padding(10)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 30)
            .buttonStyle(.borderedProminent)
        }
    }
    
    func item(icon: String, title: String, description: String) -> some View {
        HStack {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(height: 40)
                .foregroundColor(.accentColor)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(description)
                    .font(.subheadline)
            }
            Spacer()
        }
        .padding(.horizontal, 30)
        .padding(.vertical)
    }
}

#Preview {
    OnboardingView()
}
