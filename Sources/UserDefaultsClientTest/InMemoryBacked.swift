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
import Darwin.C
import UserDefaultsClientAPI

public extension UserDefaultsProperty {
    @inlinable
    static func inMemory() -> Self {
        var value: T?
        var lock = os_unfair_lock()
        
        return .init(
            delete: {
                defer { os_unfair_lock_unlock(&lock) }
                os_unfair_lock_lock(&lock)
                
                value = nil
            },
            exists: {
                defer { os_unfair_lock_unlock(&lock) }
                os_unfair_lock_lock(&lock)

                return value != nil
            },
            get: {
                defer { os_unfair_lock_unlock(&lock) }
                os_unfair_lock_lock(&lock)

                return value!
            },
            put: {
                defer { os_unfair_lock_unlock(&lock) }
                os_unfair_lock_lock(&lock)

                value = $0
            }
        )
    }
}
