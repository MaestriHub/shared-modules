//
//  SharedKey.swift
//  Created by Vitalii Shevtsov on 2/3/24.
//

import Foundation
import Sharing
import KeychainAccess
import DTOs

// MARK: - RequesterType

public enum RequesterType: String, Sendable {
    case customer
    case professional
}

extension SharedKey where Self == AppStorageKey<RequesterType?> {
    
    public static var iAmState: Self {
        appStorage("i_am_state", store: UserDefaults(suiteName: "group.maestri"))
    }
}

// MARK: - Tokens

extension SharedKey where Self == KeychainStorageKey<Token?> {
    
    public static func accessJWT(useAccessGroup: Bool = true) -> Self {
        let keychain = Keychain(
            server: "https://maestri.me",
            protocolType: .https,
            accessGroup: useAccessGroup ? "B2Y384F77B.group.maestri" : nil
        ).label("AccessToken")
        return KeychainStorageKey("access_jwt", keychain: keychain)
    }
    
    public static func refreshJWT(useAccessGroup: Bool = true) -> Self  {
        let keychain = Keychain(
            server: "https://maestri.me",
            protocolType: .https,
            accessGroup: useAccessGroup ? "B2Y384F77B.group.maestri" : nil
        ).label("RefreshToken")
        return KeychainStorageKey("refresh_jwt", keychain: keychain)
    }
}

// MARK: - Device UUID

extension SharedKey where Self == KeychainStorageKey<UUID> {
    
    public static var deviceId: Self {
        let keychain = Keychain(
            server: "https://maestri.me",
            protocolType: .https,
            accessGroup: "B2Y384F77B.group.maestri"
        ).label("DeviceId")
        return KeychainStorageKey("device_id", keychain: keychain)
    }
}


extension Bundle {
    var isAppClip: Bool {
        bundleIdentifier == "app.maestri.clip"
    }
}
