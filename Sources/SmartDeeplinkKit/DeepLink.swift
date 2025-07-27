import Foundation

/// Represents a parsed deep link with path and query parameters
public struct DeepLink: Equatable {
    public let path: String
    public let parameters: [String: String]

    public init(path: String, parameters: [String: String]) {
        self.path = path
        self.parameters = parameters
    }
}
