import Foundation

/// Parses URLs, Universal Links, and Push payloads into DeepLink objects.
public class DeepLinkParser {

    public init() {}

    /// Parses a URL into a DeepLink object.
    public func parse(url: URL) -> DeepLink? {
        var fullPath: String = ""
        
        if let host = url.host {
            // Combine host + path to support links like myapp://profile or myapp://product/123
            fullPath = host + url.path
        } else {
            // If host is missing, fallback to just path
            fullPath = url.path
        }

        // Clean up slashes
        let path = fullPath.trimmingCharacters(in: CharacterSet(charactersIn: "/"))

        // Parse query items
        var parameters: [String: String] = [:]
        if let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
           let queryItems = components.queryItems {
            for item in queryItems {
                parameters[item.name] = item.value
            }
        }

        return DeepLink(path: path, parameters: parameters)
    }

    /// Parses a Universal Link into a DeepLink object.
    public func parse(userActivity: NSUserActivity) -> DeepLink? {
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
              let url = userActivity.webpageURL else {
            return nil
        }
        return parse(url: url)
    }

    /// Parses push notification payload into a DeepLink object.
    public func parsePush(userInfo: [AnyHashable: Any]) -> DeepLink? {
        guard let link = userInfo["deep_link"] as? String,
              let url = URL(string: link) else {
            return nil
        }
        return parse(url: url)
    }
}
