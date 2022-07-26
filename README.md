<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

# Colombia's holidays Check Package.

## Features

[x] Get the holidays of a year.  
[x] Check if a date is a holiday.

## Usage

Create an instance of ColombiaHolidays and call the methods you need.


```dart
void main() async {
  ColombiaHolidays holidays = ColombiaHolidays();

// Get all holidays by Year
  final holidaysByYear = await holidays.getHolidays(year: 2020);
  // Result is a List of Holidays
  print(holidaysByYear);

// Check if a date is a holiday
  final isHoliday = await holidays.isHoliday(day: 20, month: 12, year: 2022);
  // Result is a bool
  print(isHoliday);
}
```
