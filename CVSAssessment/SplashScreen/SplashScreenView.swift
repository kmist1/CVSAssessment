//
//  SplashScreenView.swift
//  CVSAssessment
//
//  Created by Krunal Mistry on 1/14/25.
//

import SwiftUI

//MARK: SplashScreenView
struct SplashScreenView: View {
    @State private var isActive: Bool = false

    var body: some View {
        ZStack {
            if isActive {
                ContentView() // Navigate to the main content view
            } else {
                // Background
                SplashScreenBackground()

                // Content
                SplashScreenContent()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    isActive = true
                }
            }
        }
    }
}


//MARK: SplashScreenBackground
struct SplashScreenBackground: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color.blue, Color.white]),
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}

//MARK: SplashScreenContent
struct SplashScreenContent: View {
    var body: some View {
        VStack {
            Spacer()

            // App title
            Text("Welcome to Flickr App")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()

            Spacer()

            // Optional footer
            Text("Explore and search for amazing images!")
                .font(.subheadline)
                .foregroundColor(.black.opacity(0.8))
                .padding(.bottom, 50)
        }
    }
}

// Preview
struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
