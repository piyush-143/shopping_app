# Shopping App

A Flutter shopping application that fetches product data from an API endpoint and utilizes the Provider package for state management.

## Overview

This mobile application provides users with a complete shopping experience. It displays a list of products fetched from a remote API, allowing users to browse, view details, add items to a cart, and manage their cart contents. The application leverages the Provider architecture for efficient and maintainable state management, ensuring a reactive and user-friendly interface.
## Screenshots

<img src="https://github.com/user-attachments/assets/98c93b25-c32d-4b2f-b8c0-85fb491e5a45" data-canonical-src="https://github.com/user-attachments/assets/98c93b25-c32d-4b2f-b8c0-85fb491e5a45" width="200" height="340" />
<img src="https://github.com/user-attachments/assets/34cb1ba2-c459-45f0-990a-62dbf5a027c8" data-canonical-src="https://github.com/user-attachments/assets/34cb1ba2-c459-45f0-990a-62dbf5a027c8" width="200" height="340" />


## Features

* **Fetch Products from API:** Retrieves product data (name, price, image, description, etc.) from a specified API endpoint.
* **Display Product List:** Presents the fetched products in a visually appealing list view.
* **Add to Cart Functionality:** This feature enables users to add products to a virtual shopping cart from the product list or details screen.
* **Cart Screen:** Provides a dedicated screen to view, modify quantities, and remove items from the shopping cart.
* **Provider State Management:** Implements the Provider package for managing application state, making it easier to handle data changes and UI updates for products and the cart.
* **Clean and Organized Architecture:** It follows a structured approach for better code maintainability and scalability.
* **Error Handling:** Implements basic error handling for API requests and cart operations.
* **Loading State:** Provides visual feedback to the user during API data fetching and cart updates.

## Technologies Used

* **Flutter:** A UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
* **Dart:** The programming language for Flutter.
* **Provider:** A popular Flutter package for simple and scalable state management.
* **http:** A Flutter package for making HTTP requests to interact with the API.
* **cached_network_image:** A Flutter package for displaying and caching images from the internet. (Optional, but recommended for better performance)

## API Used
* The Movie Database (TMDb) API - https://dummyjson.com/products

## State Management with Provider

This application utilizes the Provider package for managing its state, including the product data and the shopping cart. Key components of the state management implementation include:
* **Providers:** Classes that hold the application's state and provide access to it. Examples include ProductListProvider (for fetching and holding products) and CartProvider (for managing the shopping cart items and their quantities).
* **Consumers:** Widgets that listen to changes in specific providers and rebuild themselves accordingly. Consumer, Provider.of, and context.watch() are commonly used to access and react to state changes in both product data and the cart.
* **Notifiers (ChangeNotifier, ValueNotifier):** Classes that extend ChangeNotifier or ValueNotifier and are used within Providers to notify listeners when the state changes, such as when products are fetched or items are added/removed from the cart.

## Contributing
Contributions to this project are welcome. If you find any bugs or have suggestions for improvements, please 1  feel free to open an issue or submit a pull request.
