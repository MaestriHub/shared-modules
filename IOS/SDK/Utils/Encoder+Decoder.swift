//
//  Encoder+Decoder.swift
//  Created by Vitalii Shevtsov on 09.02.2025.
//

import Foundation
import Alamofire

extension JSONDecoder {
    
    static var decoder: JSONDecoder = {
        var decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
}

extension JSONParameterEncoder {
    
    static var bodyEncoder: JSONParameterEncoder = {
        var encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return JSONParameterEncoder(encoder: encoder)
    }()
}

extension URLEncodedFormParameterEncoder {
    
    static var queryEncoder: URLEncodedFormParameterEncoder = {
        let encoder = URLEncodedFormEncoder(dateEncoding: .secondsSince1970)
        return URLEncodedFormParameterEncoder(encoder: encoder, destination: .queryString)
    }()
}
