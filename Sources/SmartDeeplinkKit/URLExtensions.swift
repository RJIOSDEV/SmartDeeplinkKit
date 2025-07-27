import Foundation

extension URL {
    func queryItemValue(for name: String) -> String? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
              let items = components.queryItems else {
            return nil
        }
        return items.first(where: { $0.name == name })?.value
    }
}
