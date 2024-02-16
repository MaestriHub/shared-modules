//
//  File.swift
//  
//
//  Created by Гаджиев Казим on 16.02.2024.
//

import Foundation

public enum RedirectContent: Parametable, Responsable {
    case fullScreen
    case push
    case size(width: CGFloat, height: CGFloat)
}
