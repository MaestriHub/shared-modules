import Foundation

public enum ClientAbort: Codable {
    case Foo
}

public extension ClientAbort {
    func localize() -> Languagues {
        return switch self {
        case .Foo: FooLocalize()
        }
    }
}

