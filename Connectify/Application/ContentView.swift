//
//  ContentView.swift
//  Connectify
//
//  Created by Tristan Chay on 18/6/24.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("showingOnboarding", store: .standard) private var showingOnboarding = true
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .sheet(isPresented: $showingOnboarding) {
            OnboardingView()
        }
    }
}

#Preview {
    ContentView()
}
