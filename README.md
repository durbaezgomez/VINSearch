# VIN Search iOS App

VIN Search is a SwiftUI-based iOS application that allows users to search for vehicle details using a VIN (Vehicle Identification Number). It also keeps track of recent searches for quick reference.

## Features

- Search vehicle details by entering a VIN number.
- Display vehicle information in a user-friendly format.
- View and manage a list of recent searches.

## Technology Stack

- [x] **SwiftUI**: For building the user interface.
- [x] **MVVM Architecture**: Ensures clean code separation and scalability.
- [x] **URLSession**: Handles network requests to fetch VIN-related data.
- [x] **UserDefaults**: Manages and persists recent search history.

## Potential Features

- VIN barcode scanner for easier input.
- Dark mode support for better usability.
- Integration with a more comprehensive vehicle data API.
- VIN number retrieval using Image-To-Text API

## Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/durbaezgomez/VINSearch.git

2.	Open the project in Xcode.
3.  Create your own Config.plist file to provide API_HOST and API_KEY properties.
4.	Run the app on a simulator or physical device.
