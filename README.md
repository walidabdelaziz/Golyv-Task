# Repositories Fetching and Details App - iOS

This is a simple iOS application that allows the user to fetch repositories from an API and display them in a table view and navigate to the details of the repo when tapped.

The app is developed using MVVM architecture, RxSwift and async/await and URLSession for network requests and image loading and RxCocoa for binding UI elements.

## Requirements

- iOS 16.0+
- Xcode 14.0+
- Swift 5+

## Installation

Clone the repository.
Open Golyv Task.xcworkspace.
Build and run the project on your simulator or device.

## Features

- [x] Fetches repos from an API using async/await and URLSession.
- [x] Displays repos in a table view using RxSwift.
- [x] Implements pagination when the user reaches the end of the table view.
- [x] Displays repo details when the user taps on a repo.
- [x] Unit tests.
- [x] Pagination.

## MVVM Architecture

The app follows MVVM (Model-View-ViewModel) architecture, which separates the responsibilities of the app into three layers:

- Model: Contains the data and business logic of the app.
- View: Contains the UI elements and user interactions of the app.
- ViewModel: Binds the Model and View together and provides the necessary data and actions for the View to render and interact with.
The ViewModel layer is responsible for the business logic of the app, and uses RxSwift to bind the data from the Model layer to the View layer. This way, the ViewModel layer only communicates with the View layer via the data bindings and the View layer never has direct access to the data.


## Network Layer

The app employs the power of async and await, along with URLSession, for handling network requests to fetch photos from an API. The NetworkManager class orchestrates these asynchronous network requests, returning responses as a Result object, which can either indicate success or failure.

## Image Loading

To provide a seamless user experience, the app uses async/await and URLSession for loading images asynchronously from URLs. This cutting-edge technology combines caching and memory management to ensure smooth scrolling of the table view while efficiently handling image downloads.

## Conclusion

This app serves as a demonstration of advanced programming concepts like async and await, URLSession, and the power of RxSwift within the context of a simple yet effective repository-fetching application.
