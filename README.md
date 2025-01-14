# Project Overview

This project is an iOS application developed as part of a coding challenge. The application allows users to search for images on Flickr using a search bar and view image details upon selection. The app is built using Swift and SwiftUI, following a modular architecture for scalability and reusability.

### Splash Screen:

<img width="565" alt="Screenshot 2025-01-14 at 12 19 35 PM" src="https://github.com/user-attachments/assets/4d921690-98f7-478c-9183-684e98a2adee" />

### Search Screen:

<img width="565" alt="Screenshot 2025-01-14 at 11 51 35 AM" src="https://github.com/user-attachments/assets/1556868a-5995-41db-8f32-31fa95e13155" />

### Detail View Screen:

<img width="565" alt="Screenshot 2025-01-14 at 11 51 46 AM" src="https://github.com/user-attachments/assets/b1e5edae-3c35-444c-b387-3bb298a00478" />

### Challenge Requirements

	•	Search Functionality: A user can enter a search term in the search bar, and relevant images are fetched from the Flickr public API.
	•	Image Grid: A grid layout displays the thumbnails of the search results.
	•	Detail View: On selecting an image, a detail view shows:
	•	The image
	•	Title
	•	Description
	•	Author
	•	Published date
	•	Dimensions (optional)
	•	Dynamic Updates: The search results update dynamically after every keystroke.
	•	Progress Indicator: A progress indicator is shown during API calls without blocking the UI.
	•	Unit Tests: Includes at least one unit test to validate a portion of the code.

## Key Features

	1.	Search Bar and Grid Layout:
	•	Implements a search bar for user input.
	•	Dynamically updates grid results using data from the Flickr API.
	2.	Detail View:
	•	Displays image, metadata, and dimensions (if available).
	•	Includes a share button to share image details.
	3.	Dynamic Text Support:
	•	Ensures compatibility with dynamic type sizes for accessibility.
	4.	Reusable Components:
	•	Modular and reusable SwiftUI components for better code organization.
	5.	Animation:
	•	Smooth transition animations between grid and detail views.

## Technical Highlights

	•	SwiftUI: Used for building declarative UI components.
	•	MVVM Architecture: Clean separation of concerns for scalability and maintainability.
	•	Async/Await: Handles asynchronous API calls efficiently.
	•	Error Handling: Provides descriptive error messages for debugging.
	•	Accessibility: Supports VoiceOver and dynamic text sizes.
	•	Mock Services: Enables testing without real API dependencies.

## How to Run

	1.	Clone the repository to your local machine.
	2.	Open CVSAssessment.xcodeproj in Xcode.
	3.	Build and run the project on an iOS Simulator or a physical device running iOS 15.0 or later.

## Testing

	•	Unit Tests: Located in the CVSAssessmentTests folder, focusing on API calls and data decoding.
	•	UI Tests: Found in the CVSAssessmentUITests folder, ensuring the app’s user interface behaves as expected.

## APIs Used

	•	Flickr Public API: Fetches images based on user input.
	•	API Endpoint Example:

https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=<search_term>

## Acknowledgments

	•	Thanks to the challenge provider for the opportunity to demonstrate iOS development skills.
	•	The application is built adhering to Apple’s Human Interface Guidelines and focuses on safe and clean Swift code.
