import Foundation
import Alamofire
import Dependencies

// MARK: - Protocol

public protocol ICoderService {
    
    var decoder: JSONDecoder { get }
    
    var bodyEncoder: JSONParameterEncoder { get }
    
    var queryEncoder: URLEncodedFormParameterEncoder { get }
}

// MARK: - DependencyValues

public extension DependencyValues {
    
    var coderService: any ICoderService {
        get { self[DecoderServiceKey.self] }
        set { self[DecoderServiceKey.self] = newValue }
    }
    
    enum DecoderServiceKey: DependencyKey {
        public static let liveValue: ICoderService = CoderService()
    }
}

// MARK: - Live

struct CoderService: ICoderService {
    
    // MARK: - ICoderService
    
    var decoder: JSONDecoder = {
        var decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    var bodyEncoder: JSONParameterEncoder = {
        var encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return JSONParameterEncoder(encoder: encoder)
    }()
    
    var queryEncoder: URLEncodedFormParameterEncoder = {
        let encoder = URLEncodedFormEncoder(dateEncoding: .secondsSince1970)
        return URLEncodedFormParameterEncoder(encoder: encoder, destination: .queryString)
    }()
}
