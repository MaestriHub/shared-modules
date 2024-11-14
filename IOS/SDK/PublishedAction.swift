//
//  PublishedAction.swift
//  Created by Алексей on 09.04.2024.
//

import Combine

public struct PublishedAction<Value> {
    private var subject = PassthroughSubject<Value, Never>()
    public var publisher: AnyPublisher<Value, Never> {
        subject.eraseToAnyPublisher()
    }
    
    public func send(_ value: Value) {
        subject.send(value)
    }
    
    public func send(_ value: Value = ()) where Value == Void {
        subject.send(value)
    }
    
    public init() {}
}

public typealias CancelBag = Set<AnyCancellable>
