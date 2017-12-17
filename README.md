# ReminderAlertView
`ReminderAlertView` is a alert view that can remind regularly.
`ReminderAlertView` is inspired by [Appirater](https://github.com/arashpayan/appirater).
`Appirater` is only for app review. `ReminderAlertView` has high versatility.
You can use `ReminderAlertView` according to your application. For app review, push notification, and etc.

## Usage
ex)
- You want to display a alert for push notification when a user sees product page 5 times. And if a user hits ok button once, you don't want to display the alert.
- You want to display a alert for app review when a user hits the like button 10 times. And if the alert is displayed once, you don't want to display it.

**Register alerts in AppDelegate**
```swift
ReminderAlertView.registerAlert(id: "push_notification_alert",
  countToRemind: 5,
  alertTitle: "Please turn on push notification!",
  message: "Do you want to get push notification when you receive message?", cancelButtonTitle: "Not now",
  OKButtonTitle: "Turn on")

ReminderAlertView.registerAlert(id: "app_review_alert",
  countToRemind: 10, alertTitle: "Please review our app!",
  message: "If you like our app, could you review our app?",
  cancelButtonTitle: "Not now",
  OKButtonTitle: "OK")
```

**Increment when a user sees product page and hits like button**
```swift
func showProductScreen() {
  if !ReminderAlertView.hasBeenPushedOKButton(id: "push_notification_alert") {
    ReminderAlertView.incrementCount(id: "push_notification_alert") {

        application.registerForRemoteNotifications()
    }
  }
}

func likeProduct() {
  if !ReminderAlertView.hasBeenDisplayed(id: "app_review_alert") {
    ReminderAlertView.incrementCount(id: "app_review_alert") {

      // code to transition to review page on app store
    }
  }
}
```

**If you want to display alert forcibly**
```swift
ReminderAlertView.showAlert(id: "push_notification_alert") {

    // code for when a user hits ok button
}
```

## Installation

### CocoaPods
```sh
gem install cocoapods
```

**Add following to your Podfile**

```rb
platform :ios, '8.0'
use_frameworks!

target 'Your Target Name' do
  pod 'ReminderAlertView'
end
```

**Run**
```sh
pod install
```

### Carthage
```sh
brew install carthage
```

**Add following to your Cartfile**
```rb
github "KEN-chan/ReminderAlertView"
```

**Run**
```sh
carthage update --platform ios
```

## Requirements
- iOS 8.0+
- Swift 4.0+

## License
MIT license
