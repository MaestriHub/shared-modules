//
//  NoticesService.swift
//  Created by Vitaliy Shevtsov on 7/17/23.
//  Copyright © 2023 Maestri Hub. All rights reserved.
//

import Foundation
import Alamofire
import Dependencies
import DTOs

//MARK: - Protocol

public protocol INoticesService {
    
    /// Get /notices
    func notices() async throws -> [Notice.Responses.Full]
    
    /// Get /notices/:id/readed
    func readed(id: UUID) async throws
}

//MARK: - DependencyValues

public extension DependencyValues {
    
    var noticesService: any INoticesService {
        get { self[NoticesServiceKey.self] }
        set { self[NoticesServiceKey.self] = newValue }
    }
    
    enum NoticesServiceKey: DependencyKey {
        public static let liveValue: INoticesService = NoticesService()
    }
}

//MARK: - Live

public final class NoticesService: INoticesService {
    
    //MARK: - Dependencies
    
    @Dependency(\.requestsService) var requestsService
    @Dependency(\.decoderService) var decoderService
    
    //MARK: - Methods
    
    public func notices() async throws -> [Notice.Responses.Full] {
        try await requestsService
            .request(path: "/v1/notifications", method: .get)
            .serializingDecodable([Notice.Responses.Full].self)
            .value
    }
    
    public func readed(id: UUID) async throws {
        let _ = try await requestsService
            .request(
                path: "/v1/notifications/\(id)/readed",
                method: .put
            )
            .serializingDecodable(Empty.self, emptyResponseCodes: [200])
            .value
    }
}
