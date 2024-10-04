import Foundation

public protocol Languagues {
    var ru: String { get }
    var en: String { get }
}


public struct FooLocalize: Languagues {
    public var ru: String { "Фуу" }
    public var en: String { "Foo" }
}
