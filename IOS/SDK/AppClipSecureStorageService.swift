//
//  AppClipSecureStorageService.swift
//
//
//  Created by Kovalev Alexander on 17.05.2024.
//

import KeychainAccess
import Dependencies
import Combine
import UIKit
import DTOs

private enum AppClipSecureStorageConstants {
    static let accessTokenLabel = "appClipAccessToken"
    static let refreshTokenLabel = "appClipRefreshToken"
}

final class AppClipSecureStorageService: ISecureStorageService {
    
    static let standard = AppClipSecureStorageService()
    
    private var store: Keychain
    @Dependency(\.currentIAmStorageService) private var currentIAmStorageService
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    
    var iAmStatePublisher: PassthroughSubject<RequesterType?, Never> {
        currentIAmStorageService.iAmStatePublisher
    }
    
    private init() {
        store = Keychain(
            server: "https://maestri.me",
            protocolType: .https
        )
        encoder = JSONEncoder()
        decoder = JSONDecoder()
    }
    
    // MARK: - ISecureStorageService
    
    var accessToken: Token? {
        store = store.label( AppClipSecureStorageConstants.accessTokenLabel)
        guard let data = store[data: "access_jwt"] else { return nil }
        return try? decoder.decode(Token.self, from: data)
    }
    
    func setAccess(token: Token?) {
        store = store.label(AppClipSecureStorageConstants.accessTokenLabel)
        let data = try? encoder.encode(token)
        store[data: "access_jwt"] = data
    }
    
    var refreshToken: Token? {
        store = store.label(AppClipSecureStorageConstants.refreshTokenLabel)
        guard let data = store[data: "refresh_jwt"] else { return nil }
        return try? decoder.decode(Token.self, from: data)
    }
    
    func setRefresh(token: Token?) {
        store = store.label(AppClipSecureStorageConstants.refreshTokenLabel)
        let data = try? encoder.encode(token)
        store[data: "refresh_jwt"] = data
        DispatchQueue.main.async {
            guard let token = self.refreshToken, Date.now < token.expiration else {
                self.iAmStatePublisher.send(.none)
                return
            }
        }
    }
    
    var currentIAm: RequesterType? {
        currentIAmStorageService.currentIAm
    }
    
    func setIAm(state: RequesterType?, notify: Bool) {
        currentIAmStorageService.setIAm(state: state, notify: notify)
    }
    
    var deviceId: String? {
        UIDevice.current.identifierForVendor?.uuidString
    }
    
    func setDevice(id: String?) {}
}

extension Bundle {
    var isAppClip: Bool {
        bundleIdentifier == "app.maestri.clip"
    }
}
