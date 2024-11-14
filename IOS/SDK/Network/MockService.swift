//
//  MockService.swift
//  Created by Vitaliy Shevtsov on 4/8/23.
//

import Foundation
import Dependencies
import Alamofire
//import Mocker

// MARK: - Protocol

protocol IMockService {
    
    func setup(for session: URLSessionConfiguration)
    
    func registerMock(for path: String, method: Alamofire.HTTPMethod, response: Data)
}

// MARK: - DependencyValues

extension DependencyValues {
    
    var mockService: any IMockService {
        get { self[MockServiceKey.self] }
        set { self[MockServiceKey.self] = newValue }
    }
    
    enum MockServiceKey: DependencyKey {
        public static let liveValue: IMockService = MockService()
    }
}

// MARK: - Live

struct MockService: IMockService, Sendable {
    
    @Dependency(\.toggleService) var toggleService
    
    var base: URL {
        URL(string: toggleService.fetchToggleValue(.baseURL) ?? "")!
    }
    
    func setup(for session: URLSessionConfiguration) {
        //session.protocolClasses = [MockingURLProtocol.self]
    }
    
    func registerMock(for path: String, method: HTTPMethod, response: Data) {
//        var url = base
//        url.append(path: path)
//        guard let method = Mock.HTTPMethod(rawValue: method.rawValue) else { return }
        
//        var mock = Mock(url: url, contentType: .json, statusCode: 200, data: [method: response])
//        mock.delay = DispatchTimeInterval.milliseconds(300)
//        mock.register()
    }
}
