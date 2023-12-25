//
//  MockService.swift
//  Created by Vitaliy Shevtsov on 4/8/23.
//

import Foundation
import Dependencies
import Alamofire
import Mocker

//MARK: - Protocol

protocol IMockService {
    
    func setup(for session: URLSessionConfiguration)
    
    func registerMock(for path: String, method: Alamofire.HTTPMethod, response: Data)
}

//MARK: - DependencyValues

extension DependencyValues {
    
    var mockService: any IMockService {
        get { self[MockServiceKey.self] }
        set { self[MockServiceKey.self] = newValue }
    }
    
    enum MockServiceKey: DependencyKey {
        public static let liveValue: IMockService = MockService()
    }
}

//MARK: - Live

final class MockService: IMockService {
    
    var base: URL {
        return URL(string: "http://127.0.0.1:8080")! //  URL(string: "https://api-app-76rqlbff5q-uc.a.run.app")!
    }
    
    func setup(for session: URLSessionConfiguration) {
        session.protocolClasses = [MockingURLProtocol.self]
    }
    
    func registerMock(for path: String, method: HTTPMethod, response: Data) {
        var url = base
        url.append(path: path)
        guard let method = Mock.HTTPMethod(rawValue: method.rawValue) else { return }
        
        var mock = Mock(url: url, dataType: .json, statusCode: 200, data: [method: response])
        mock.delay = DispatchTimeInterval.milliseconds(300)
        mock.register()
    }
}
