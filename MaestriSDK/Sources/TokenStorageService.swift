import Foundation
import SwiftUI
import Combine
import KeychainAccess
import Dependencies

//MARK: - Protocol

public protocol ITokenStorageService {

    var publisher: PassthroughSubject<String?, Never> { get }
    var token: String? { get }

    func update(token: String?)
}

//MARK: - DependencyValues

public extension DependencyValues {

    var tokenStorageService: ITokenStorageService {
        get { self[TokenStorageServiceKey.self] }
        set { self[TokenStorageServiceKey.self] = newValue }
    }

    enum TokenStorageServiceKey: DependencyKey {
        public static let liveValue: ITokenStorageService = TokenStorageService()
    }
}

public final class TokenStorageService: ITokenStorageService {
    
    static let store = Keychain(server: "https://maestri.app", protocolType: .https, accessGroup: "B2Y384F77B.group.maestri")

    public var publisher = PassthroughSubject<String?, Never>()
    public var token: String? {
        return TokenStorageService.store["token"]
    }
    
    public func update(token: String?) {
        TokenStorageService.store["token"] = token
        publisher.send(token)
    }
}
