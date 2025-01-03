import Foundation
import Alamofire
import Dependencies
import DTOs

public protocol IDeviceService {
    
    /// POST /device
    @discardableResult
    func check(parameters: Device.Parameters.System) async throws -> Device.Responses.Full
}

// MARK: - DependencyValues

public extension DependencyValues {
    
    var deviceService: any IDeviceService {
        get { self[DeviceServiceKey.self] }
        set { self[DeviceServiceKey.self] = newValue }
    }
    
    enum DeviceServiceKey: DependencyKey {
        public static let liveValue: IDeviceService = DeviceService()
    }
}

// MARK: - Live

struct DeviceService: IDeviceService {
    
    // MARK: - Dependencies
    
    @Dependency(\.requestsService) var requestsService
    @Dependency(\.coderService) var coderService
    
    // MARK: - Methods
    
    @discardableResult
    func check(parameters: Device.Parameters.System) async throws -> Device.Responses.Full {
        try await requestsService
            .request(
                path: "v1/devices",
                method: .post,
                parameters: parameters,
                requestType: .other
            )
            .serializingDecodable(Device.Responses.Full.self, decoder: coderService.decoder)
            .value
    }
}
