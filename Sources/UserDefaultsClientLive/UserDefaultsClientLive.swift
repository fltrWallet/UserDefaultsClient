//===----------------------------------------------------------------------===//
//
// This source file is part of the UserDefaultsClient open source project
//
// Copyright (c) 2022 fltrWallet AG and the UserDefaultsClient project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//
import Foundation
import struct UserDefaultsClientAPI.UserDefaultsProperty

extension UserDefaultsProperty {
    @usableFromInline
    static func delete(key: String,
                       userDefaults: UserDefaults) {
        userDefaults.removeObject(forKey: key)
    }
    
    @usableFromInline
    static func exists(key: String,
                       userDefaults: UserDefaults,
                       decoder: JSONDecoder) -> Bool {
        switch self.get(key: key, userDefaults: userDefaults, decoder: decoder) {
        case .none: return false
        case .some: return true
        }
    }
    
    @usableFromInline
    static func get(key: String, userDefaults: UserDefaults, decoder: JSONDecoder) -> T? {
        (userDefaults.object(forKey: key) as? Data)
        .flatMap {
            try? decoder.decode(T.self, from: $0)
        }
    }
    
    @usableFromInline
    static func put(key: String, value: T, userDefaults: UserDefaults, encoder: JSONEncoder) {
        let encoded = try! encoder.encode(value)
        userDefaults.set(encoded, forKey: key)
    }
}

public extension UserDefaultsProperty {
    @inlinable
    static func live(key: String,
                     defaults: UserDefaults,
                     encoder: JSONEncoder = .init(),
                     decoder: JSONDecoder = .init()) -> Self {
        .init(delete: { Self.delete(key: key, userDefaults: defaults) },
              exists: { Self.exists(key: key, userDefaults: defaults, decoder: decoder) },
              get: { Self.get(key: key, userDefaults: defaults, decoder: decoder) },
              put: { Self.put(key: key, value: $0, userDefaults: defaults, encoder: encoder) })
    }

}
