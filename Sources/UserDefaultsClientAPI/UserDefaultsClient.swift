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
public struct UserDefaultsProperty<T: Codable> {
    @usableFromInline
    let _delete: () -> Void
    
    @inlinable
    public func delete() {
        self._delete()
    }
    
    @usableFromInline
    let _exists: () -> Bool
    
    @inlinable
    public func exists() -> Bool {
        self._exists()
    }
    
    @usableFromInline
    let _get: () -> T?

    @inlinable
    public func get() -> T? {
        self._get()
    }
    
    @usableFromInline
    let _put: (T) -> Void
    
    @inlinable
    public func put(_ value: T) -> Void {
        self._put(value)
    }

    @inlinable
    public init(delete: @escaping () -> Void,
                exists: @escaping () -> Bool,
                get: @escaping () -> T?,
                put: @escaping (T) -> Void) {
        self._delete = delete
        self._exists = exists
        self._get = get
        self._put = put
    }
}
