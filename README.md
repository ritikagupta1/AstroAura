# Horoscope App

The Horoscope App is an iOS application that provides users with daily, weekly, monthly, and yearly horoscope readings for all zodiac signs, along with detailed zodiac sign traits. It features a user-friendly interface with a custom tab bar controller and scrollable content views.The app also includes a convenient date picker for users who may not know their zodiac sign.

## Key Features

- Horoscope readings for all zodiac signs
- Multiple time periods: daily, weekly, monthly, and yearly
- Date picker to determine zodiac sign based on date of birth
- Detailed zodiac sign traits including lucky numbers, colors, compatible signs, personality traits, and elements
- Custom tab bar controller with scrollable content
- Collapsible header view for improved user experience
- Efficient caching mechanism for API responses

## Technical Highlights

- Implemented in Swift using UIKit programmatic UI
- Custom URLCache for handling API response caching
- File-based caching for storing and retrieving API responses locally
- Utilizes URLSession for network requests
- Implements scroll view delegates for smooth header animations
- Modular architecture with reusable view controllers

## API Integration

The app integrates with custom horoscope and zodiac trait APIs, fetching data for different zodiac signs, time periods, and detailed characteristics. It implements efficient caching to minimize network requests and improve app performance.

- Traits API: baseURL/traits?sign=aries
- Horoscope Reading API: baseURL/horoscope?sign=aries&timePeriod=weekly

## UI/UX Design

The app features a modern, intuitive design with a custom tab bar and scrollable content views. The collapsible header provides a seamless user experience when navigating through different sections of the app, including horoscope readings and zodiac trait information.

## Future Enhancements I plan to integrate

- Implement push notifications for daily horoscope updates
- Integrate social sharing features for horoscope readings and zodiac traits

This Horoscope App showcases advanced iOS development techniques, including custom UI implementations, efficient network handling, and optimized performance through both URL and file-based caching mechanisms. The addition of comprehensive zodiac sign traits provides users with a rich, informative experience beyond basic horoscope readings.

![simulator_screenshot_7464FD18-C098-4257-8BBD-B25AC18948FC](https://github.com/user-attachments/assets/0d3a31ab-cdfc-4328-9167-edf9d16f5407)
![simulator_screenshot_F4A2CCD5-C8B1-4556-B0F5-3114915ABAE7](https://github.com/user-attachments/assets/4ab1871a-f418-4b44-b58d-91b5fae71111)
![simulator_screenshot_586D0265-14F3-49CD-8E86-6FE423ABFFF9](https://github.com/user-attachments/assets/179ab277-7a65-4616-a8cb-84ca7c7420d3)
![simulator_screenshot_16B9FF0A-3076-45E4-A126-C6C259FC6C2E](https://github.com/user-attachments/assets/8e98f51a-79cf-4f62-968b-9eba75ce6ca2)


