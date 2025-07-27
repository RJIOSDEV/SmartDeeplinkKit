import Foundation

/// A protocol the host app implements to respond to deep links
public protocol DeepLinkNavigating {
    func navigate(to deepLink: DeepLink)
}
