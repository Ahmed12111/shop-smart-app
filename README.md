# Shop Smart App
Shop Smart App is a Flutter-based shopping application that provides a smooth and organized user experience for browsing products, viewing detailed information, adding items to a shopping cart, managing quantities, and completing the checkout process through a clean and consistent interface.

---

## Project Overview
Shop Smart App is developed using Flutter and Dart with Provider for state management. The project follows a modular and clean architecture that ensures scalability, maintainability, and a professional workflow.

The app delivers a complete shopping experience that includes:
- Product listing and detailed product views
- Cart operations with quantity management
- Checkout screen with credit card representation
- Profile screen and user interactions
- Reusable UI components and widgets

---

## Core Features

### 1. Product Browsing
- View a structured list of available products
- Navigate to a detailed product page
- Display product information such as price, description, and image
- Product state updates managed through ProductProvider

### 2. Cart Management
- Add products to the cart
- Remove products from the cart
- Increase or decrease item quantities
- Real-time total price calculation
- Custom Snackbar notifications for cart actions

### 3. Profile Section
- Dedicated profile screen for the user
- Editable user details depending on the implemented features in your project

### 4. Checkout Flow
- Checkout screen with a credit card widget
- Order summary section
- Clean UI for confirming purchases

### 5. Reusable UI Components
- Custom Snackbar widget
- Custom Text widget
- Subtitle widget
- Product Card widget
- Credit Card widget
- Empty state widgets for better UX

### 6. State Management (Provider)
The application uses the Provider package to manage app-wide state, including:
- ProductProvider
- CartProvider
- ThemeProvider (if enabled in your project)

---

## Tech Stack

| Category          | Technology     |
|-------------------|----------------|
| Framework         | Flutter        |
| Language          | Dart           |
| State Management  | Provider       |
| UI Design System  | Material Design|
| Architecture      | Modular / Widget-based |
| Version Control   | Git & GitHub   |

---

## Project Structure

lib/
├── providers/
│ ├── cart_provider.dart
│ ├── product_provider.dart
│ └── theme_provider.dart
│
├── screens/
│ ├── home/
│ ├── cart/
│ ├── products/
│ ├── profile/
│ └── checkout/
│
├── widgets/
│ ├── credit_card_widget.dart
│ ├── custom_snack_bar_widget.dart
│ ├── custom_text_widget.dart
│ ├── product_card_widget.dart
│ └── custom_empty_widget.dart
│
├── services/
│ ├── my_app_methods.dart
│ └── api/
│
├── consts/
│ ├── my_validators.dart
│ └── colors.dart
│
├── main.dart
└── routes.dart



---

## Installation and Setup

### 1. Clone the repository
```bash
git clone https://github.com/your-username/shop_smart_app.git
```

### 2. Install dependencies
```flutter pub get```

### 3. Run the application
```flutter run```




