//
//  ErrorDisplayService.swift
//  Created by Алексей on 22.03.2024.
//  Copyright © 2024 Maestri Hub LLC. All rights reserved.
//

import Foundation
import Dependencies
import LocalizationKit

enum CustomLocalizedDescription {
    case serverError
}

// MARK: - Protocol

public protocol CreatableError: Error {
    
    var localizedString: LocalizedStringResource { get }
}

public protocol IErrorDisplayService {
    
    func decoding(error: Error) -> String
    
    func defaultError(error: DefaultError) -> String
}

// MARK: - DependencyValues

public extension DependencyValues {
    
    var errorDisplayService: any IErrorDisplayService {
        get { self[ErrorDisplayServiceKey.self] }
        set { self[ErrorDisplayServiceKey.self] = newValue }
    }
    
    enum ErrorDisplayServiceKey: DependencyKey {
        public static var liveValue: IErrorDisplayService = ErrorDisplayService.shared
    }
}

// MARK: - Implementation

final class ErrorDisplayService: IErrorDisplayService {
    
    static let shared = ErrorDisplayService()
    
    func decoding(error: any Error) -> String {
        
        if let error = error as? CreatableError {
            return error.localizedString.string
        }
        
        if let error = error.asAFError {
            guard case .responseValidationFailed(let reason) = error else {
                return L10n.Error.Default.unknownError.string
            }
            
            if case .customValidationFailed(let customError) = reason,
               let customError = customError as? ErrorResponse {
                return LocalizedStringResource(
                    String.LocalizationValue(customError.reason),
                    table: "ErrorLocalizable",
                    bundle: .localizationKit
                ).string
            }
        }
        
        guard let errorCode = error.asAFError?.responseCode else {
            return defaultError(error: .unknownError)
        }
        return HttpStatusCode(rawValue: errorCode)?.localizedString ?? defaultError(error: .unknownError)
    }
    
    func defaultError(error: DefaultError) -> String {
        error.localizedString
    }
}

// MARK: Default Errors

public enum DefaultError {
    case registerAsClient
    case registerAsMaster
    case unknownError
    case failedToLoadImage
    
    public var localizedString: String {
        switch self {
        case .registerAsClient:
            L10n.Error.Default.registerAsClient.string
        case .registerAsMaster:
            L10n.Error.Default.registerAsMaster.string
        case .unknownError:
            L10n.Error.Default.unknownError.string
        case .failedToLoadImage:
            L10n.Error.Default.failedToLoadImage.string
        }
    }
}

// MARK: Http Errors

public enum HttpStatusCode: Int {
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case methodNotAllowed = 405
    case conflict = 409
    case internalServerError = 500
    case badGateway = 502
    case serviceUnavailable = 503
    case gatewayTimeout = 504
    
    public var localizedString: String {
        switch self {
        case .badRequest:
            L10n.Error.Http.badRequest.string
        case .unauthorized:
            L10n.Error.Http.unauthorized.string
        case .forbidden:
            L10n.Error.Http.forbidden.string
        case .notFound:
            L10n.Error.Http.notFound.string
        case .methodNotAllowed:
            L10n.Error.Http.methodNotAllowed.string
        case .conflict:
            L10n.Error.Http.conflict.string
        case .internalServerError:
            L10n.Error.Http.internalServerError.string
        case .badGateway:
            L10n.Error.Http.badGateway.string
        case .serviceUnavailable:
            L10n.Error.Http.serviceUnavailable.string
        case .gatewayTimeout:
            L10n.Error.Http.gatewayTimeout.string
        }
    }
}
