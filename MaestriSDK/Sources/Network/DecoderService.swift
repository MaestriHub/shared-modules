//
//  DecoderService.swift
//  Created by Vitaliy Shevtsov on 4/12/23.
//  Copyright © 2023 Maestri Hub. All rights reserved.
//

import Foundation
import Alamofire
import Dependencies

//MARK: - Protocol

public protocol IDecoderService {

    var jsonDecoder: JSONDecoder { get }
}

//MARK: - DependencyValues

public extension DependencyValues {
    
    var decoderService: any IDecoderService {
        get { self[DecoderServiceKey.self] }
        set { self[DecoderServiceKey.self] = newValue }
    }
    
    enum DecoderServiceKey: DependencyKey {
        public static let liveValue: IDecoderService = DecoderService()
    }
}

//MARK: - Live

public final class DecoderService: IDecoderService {
    
    //MARK: - Dependencies
    
    //MARK: - IDecoderService
    
    public lazy var jsonDecoder: JSONDecoder = {
        var decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    public init() {}
}

