//
//  SplashScreenView.swift
//  CVSAssessment
//
//  Created by Krunal Mistry on 1/14/25.
//

import SwiftUI

struct SplashScreenView: View {
    @State var isActive: Bool = false

    var body: some View {
        ZStack {
            if self.isActive {
                ContentView()
            } else {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue, Color.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                // Splash screen content
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
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

// Preview
struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
