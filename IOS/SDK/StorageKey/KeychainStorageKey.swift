//
//  KeychainStorageKey.swift
//  Created by Vitalii Shevtsov on 08.02.2025.
//

import Foundation
import Sharing
@preconcurrency import KeychainAccess

/// `SharedKey` для хранения данных в Keychain (без NotificationCenter)
public struct KeychainStorageKey<Value: Codable>: SharedKey {
    private let key: String
    private let keychain: Keychain
    private let store = KeychainStorage() // 🔥 Потокобезопасное локальное хранилище

    public var id: KeychainKeyID {
        KeychainKeyID(key: key, store: store)
    }

    /// Создание `SharedKey` для Keychain
    public init(_ key: String, keychain: Keychain) {
        self.key = key
        self.keychain = keychain
    }

    /// Загрузка значения из Keychain (или из локального кэша)
    public func load(context: LoadContext<Value>, continuation: LoadContinuation<Value>) {
        // 1️⃣ Если значение есть в кэше — сразу возвращаем его (без обращения в Keychain)
        if let cachedValue = store.values[key] as? Value {
            continuation.resume(returning: cachedValue)
            return
        }

        // 2️⃣ Если кэша нет — загружаем из Keychain
        do {
            if let data = try keychain.getData(key) {
                let value = try JSONDecoder().decode(Value.self, from: data)
                store.values[key] = value  // 🔥 Кэшируем значение
                continuation.resume(returning: value)
            } else {
                continuation.resumeReturningInitialValue()
            }
        } catch {
            continuation.resumeReturningInitialValue()
        }
    }

    /// Подписка не требуется, так как `@Shared` сам управляет значением
    public func subscribe(context _: LoadContext<Value>, subscriber _: SharedSubscriber<Value>) -> SharedSubscription {
        SharedSubscription {}  // ❌ Ничего не делаем
    }

    /// Сохранение значения в Keychain и обновление кэша
    public func save(_ value: Value, context _: SaveContext, continuation: SaveContinuation) {
        do {
            let data = try JSONEncoder().encode(value)
            try keychain.set(data, key: key)
            store.values[key] = value  // 🔥 Обновляем локальный кэш
            continuation.resume()
        } catch {
            continuation.resume(with: .failure(error))
        }
    }
}

public struct KeychainStorage: Hashable, Sendable {
    private let id = UUID()
    fileprivate let values = Values()  // 🔥 Потокобезопасный кэш значений

    public init() {}

    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    fileprivate final class Values: Sendable {
        let storage = Mutex<[String: any Sendable]>([:])  // 🔒 Потокобезопасное хранилище

        subscript(key: String) -> (any Sendable)? {
            get { storage.withLock { $0[key] } }
            set { storage.withLock { $0[key] = newValue } }
        }

        subscript<Value: Sendable>(key: String, default defaultValue: Value) -> Value {
            storage.withLock { storage in
                let value =
                    (storage[key] as? Value)
                    ?? {
                        storage[key] = defaultValue
                        return defaultValue
                    }()
                return value
            }
        }
    }
}

public struct KeychainKeyID: Hashable {
    let key: String
    let store: KeychainStorage
}

private struct Mutex<Value: ~Copyable>: ~Copyable {
    private let _lock = NSLock()
    private let _box: Box
    
    /// Initializes a value of this mutex with the given initial state.
    ///
    /// - Parameter initialValue: The initial value to give to the mutex.
    package init(_ initialValue: consuming sending Value) {
        _box = Box(initialValue)
    }
    
    private final class Box {
        var value: Value
        init(_ initialValue: consuming sending Value) {
            value = initialValue
        }
    }
}

extension Mutex: @unchecked Sendable where Value: ~Copyable {}

extension Mutex where Value: ~Copyable {
    /// Calls the given closure after acquiring the lock and then releases ownership.
    borrowing fileprivate func withLock<Result: ~Copyable, E: Error>(
        _ body: (inout sending Value) throws(E) -> sending Result
    ) throws(E) -> sending Result {
        _lock.lock()
        defer { _lock.unlock() }
        return try body(&_box.value)
    }
    
    /// Attempts to acquire the lock and then calls the given closure if successful.
    borrowing fileprivate func withLockIfAvailable<Result: ~Copyable, E: Error>(
        _ body: (inout sending Value) throws(E) -> sending Result
    ) throws(E) -> sending Result? {
        guard _lock.try() else { return nil }
        defer { _lock.unlock() }
        return try body(&_box.value)
    }
}
