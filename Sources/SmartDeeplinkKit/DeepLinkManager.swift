import Foundation
import UIKit

/// Handles incoming deep links and passes them to the navigator
public class DeepLinkManager {

    public static let shared = DeepLinkManager()

    private var parser = DeepLinkParser()
    private var navigator: DeepLinkNavigating?
    private var domain: String?
    private var scheme: String?

    private var pendingDeepLink: DeepLink?

    private init() {}

    /// Configures the deep link manager.
    public func configure(domain: String?, scheme: String?, navigator: DeepLinkNavigating) {
        self.domain = domain
        self.scheme = scheme
        self.navigator = navigator

        // If any deep link was pending (like app launched via link), handle it now
        if let deepLink = pendingDeepLink {
            navigator.navigate(to: deepLink)
            pendingDeepLink = nil
        }
    }

    // MARK: - Handle URL
    public func handle(url: URL) -> Bool {
        guard let deepLink = parser.parse(url: url) else { return false }

        if let navigator = navigator {
            navigator.navigate(to: deepLink)
        } else {
            pendingDeepLink = deepLink
        }
        return true
    }

    // MARK: - Handle Universal Link
    public func handle(userActivity: NSUserActivity) -> Bool {
        guard let deepLink = parser.parse(userActivity: userActivity) else { return false }

        if let navigator = navigator {
            navigator.navigate(to: deepLink)
        } else {
            pendingDeepLink = deepLink
        }
        return true
    }

    // MARK: - Handle Push Notification
    public func handlePushLink(from userInfo: [AnyHashable: Any]) {
        guard let deepLink = parser.parsePush(userInfo: userInfo) else { return }

        if let navigator = navigator {
            navigator.navigate(to: deepLink)
        } else {
            pendingDeepLink = deepLink
        }
    }
}
