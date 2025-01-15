//
//  ContentView.swift
//  CVSAssessment
//
//  Created by krunal mistry on 1/14/25.
//
import SwiftUI

// Represent Search View Screen
struct ContentView: View {

    // MARK: Private properties
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

    // MARK: Body
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

    /// Debounces the search query to avoid making API calls on every keystroke.
    /// - Parameter query: The search query string entered by the user.
    /// - Discussion: This method resets the timer on every new keystroke and triggers the `fetchImages(query:)` method
    /// after a 0.5-second delay if no further keystrokes occur. It helps optimize network calls.
    func debounceSearch(query: String) {
        debounceTimer?.invalidate()
        debounceTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            fetchImages(query: query)
        }
    }

    /// Fetches images from the Flickr API based on the provided search query.
    /// - Parameter query: The search query string entered by the user. If empty, a default query is used.
    /// - Discussion: This method cancels any ongoing task, updates the loading state, and asynchronously
    /// fetches images from the Flickr API. The results are assigned to `flickrimages`, and the loading state is updated.
    /// Errors are handled gracefully, and API calls are performed off the main thread.
    /// - Note: Uses async/await for API calls and ensures UI updates are performed on the main thread.
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
