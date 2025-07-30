# SmartDeeplinkKit

A powerful, flexible, and production-ready deep linking library for iOS.  
`SmartDeeplinkKit` helps your app handle universal links, push notifications, custom URL schemes, and dynamically parsed paths — with support for runtime navigation registration, logging, analytics hooks, and testability.

---

## 🚀 Features

- ✅ Handles deep links from:
  - Universal links (e.g. `https://example.com/profile/123`)
  - Push notifications (with custom payload)
  - Custom schemes (e.g. `myapp://settings`)
- ✅ Dynamic path-based routing (`/profile/123`, `/settings`)
- ✅ Optional analytics hook and debug logging
- ✅ Supports runtime navigation logic
- ✅ Fully testable with `XCTest`
- ✅ Minimal, lightweight, and Swift Package compatible

---

https://github.com/user-attachments/assets/56eb5467-8cf6-4a44-a7ba-ab3a0b5a7b50



## 📦 Installation

CocoaPods

pod 'SmartDeeplinkKit'

### Swift Package Manager (SPM)

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/SmartDeeplinkKit.git", from: "1.0.0")
]
```

Or use Xcode:

- File → Add Packages →  
  Enter: `https://github.com/yourusername/SmartDeeplinkKit.git`

---

## 🧠 Usage

### 1. Define a `NavigationCoordinator` that conforms to `DeepLinkNavigating`

```swift
import SwiftUI
import SmartDeeplinkKit

class NavigationCoordinator: ObservableObject, DeepLinkNavigating {
    @Published var path = [String]()

    nonisolated func navigate(to deepLink: DeepLink) {
        print("📦 Navigating to:", deepLink.path)

        let components = deepLink.path.components(separatedBy: "/")

        DispatchQueue.main.async {
            switch components.first {
            case "profile":
                if components.count > 1 {
                    let userID = components[1]
                    self.path.append("profile/\(userID)")
                } else {
                    self.path.append("profile")
                }
            case "settings":
                self.path.append("settings")
            default:
                print("❌ Unhandled path:", deepLink.path)
            }
        }
    }
}
```

---

### 2. Initialize and handle deep links

```swift
let manager = DeepLinkManager.shared
manager.setNavigator(yourCoordinatorInstance)
manager.setLogging(enabled: true)
manager.setAnalyticsHandler { deepLink in
    print("📊 Tracked:", deepLink)
}
```

---

### 3. From URL or Notification

```swift
manager.handleURL(URL(string: "https://example.com/profile/123")!)
manager.handleNotificationPayload(["deep_link": "/settings"])
```

---

## 🔍 Example Deep Link

```text
https://example.com/profile/123?ref=ios
```

Will result in:

```swift
DeepLink(
    path: "profile/123",
    parameters: ["ref": "ios"]
)
```

---

## ✅ Requirements

- iOS 13+
- Swift 5.5+

---

## 📂 Folder Structure

```
Sources/
└── SmartDeeplinkKit/
    ├── DeepLink.swift
    ├── DeepLinkManager.swift
    ├── DeepLinkParser.swift
    ├── DeepLinkNavigating.swift
    └── Extensions/
        └── URLExtension.swift
Tests/
└── SmartDeeplinkKitTests/
    └── DeepLinkParserTests.swift
```

---

App Type	Works with SmartDeeplinkKit?	How?
Pure Swift (UIKit or SwiftUI)	✅ Fully Supported	Direct usage
Mixed (Swift + Objective-C)	✅ Use in Swift layer	Swift handles deep link & calls Obj-C
Pure Objective-C	❌ Not directly	Needs custom bridging or wrapper

## 📄 License

SmartDeeplinkKit is available under the MIT license.  
See the [LICENSE](./LICENSE) file for more info.

---

## ✨ Author

Made with ❤️ by Rjiosdev(https://github.com/rjiosdev)
