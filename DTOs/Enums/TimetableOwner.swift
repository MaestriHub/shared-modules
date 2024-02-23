//
//  TimetableOwner.swift
//  Created by Vitalii Shevtsov on 2/20/24.
//

import Foundation

public enum TimetableOwner: Responsable, Equatable {
    case salon(id: UUID)
    case employee(id: UUID)
}
