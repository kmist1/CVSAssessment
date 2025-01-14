//
//  SearchBarView.swift
//  CVSAssessment
//
//  Created by Krunal Mistry on 1/14/25.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    var onSearch: (String) -> Void

    var body: some View {
        TextField("Search Images", text: $searchText)
            .padding(10)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal, 10)
            .onChange(of: searchText, perform: onSearch)
            .overlay(
                HStack {
                    Spacer()
                    if !searchText.isEmpty {
                        Button(action: {
                            searchText = ""
                            onSearch("")
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 20)
                        }
                        .accessibilityLabel("Clear search text")
                        .accessibilityHint("Clears the search text field")
                    }
                }
            )
            .accessibilityLabel("Search Bar")
            .accessibilityHint("Enter a keyword to load Flickr images")
    }
}
