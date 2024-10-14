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


<img width="1030" alt="Screenshot 2024-10-14 at 4 17 28 PM" src="https://github.com/user-attachments/assets/829e5069-4f95-4bb4-9563-b75bb4bf02df">


