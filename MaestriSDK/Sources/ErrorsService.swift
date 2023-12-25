//
//  ErrorsService.swift
//
//  Created by Vitaliy Shevtsov on 3/16/23.
//

import Foundation
import Alamofire

public class ErrorsService {
    
    public init() {}
    
    public func handle(error: AFError) {
        print(error.localizedDescription)
    }
}
