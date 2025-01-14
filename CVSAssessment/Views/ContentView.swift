//
//  ContentView.swift
//  CVSAssessment
//
//  Created by krunal mistry on 1/14/25.
//
import SwiftUI

import SwiftUI

struct ContentView: View {
    @State private var searchText: String = ""
    @State private var flickrimages: [FlickrImage] = []
    @State private var isLoading: Bool = true
    @State private var currentTask: Task<Void, Never>?
    @State private var debounceTimer: Timer?
    @State private var hasFetchedImages: Bool = false
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Namespace private var namespace

    var viewModel: FlickrViewModelProtocol = FlickrViewModel(service: FlickrAPIService.shared)
    var columns: [GridItem] {
        horizontalSizeClass == .compact
        ? Array(repeating: GridItem(.flexible(), spacing: 10), count: 4)
        : Array(repeating: GridItem(.flexible(), spacing: 10), count: 5)
    }

    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                SearchBarView(searchText: $searchText) { query in
                    debounceSearch(query: query)
                }

                // Content
                if isLoading {
                    LoadingView()
                } else {
                    ImageGridView(images: flickrimages, namespace: namespace, columns: columns)
                }
            }
            .onAppear {
                if !hasFetchedImages {
                    debounceSearch(query: "")
                    hasFetchedImages = true
                }
            }
            .navigationTitle("Flickr Images")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    // MARK: - Methods
    func debounceSearch(query: String) {
        debounceTimer?.invalidate()
        debounceTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            fetchImages(query: query)
        }
    }

    func fetchImages(query: String) {
        currentTask?.cancel()
        isLoading = true
        currentTask = Task {
            do {
                let url = query.isEmpty
                    ? FlickrUrl.URLs.flickrURL + FlickrUrl.defaultquery
                    : FlickrUrl.URLs.flickrURL + query

                if let flickrResponse = try await viewModel.getImages(url: url) {
                    await MainActor.run {
                        flickrimages = flickrResponse.items
                        isLoading = false
                    }
                }
            } catch {
                if Task.isCancelled { return }
                print("Error: \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
}

