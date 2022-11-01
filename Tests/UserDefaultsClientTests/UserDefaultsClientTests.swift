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
import XCTest
import UserDefaultsClientAPI
import UserDefaultsClientLive
import UserDefaultsClientTest

final class UserDefaultsClientTests: XCTestCase {
    var defaults: UserDefaults!
    var testKey: String!
    
    override func setUp() {
        self.defaults = UserDefaults(suiteName: "testingUserDefaultsClient")
        self.testKey = "testKey"
    }
    
    override func tearDown() {
        self.defaults = nil
        self.testKey = nil
    }
    
    enum TestEnum: String, Codable {
        case hello
        case world
    }
    
    func test(backend client: UserDefaultsProperty<TestEnum>) {
        client.delete()
        XCTAssertFalse(client.exists())
        
        client.put(.hello)
        XCTAssertTrue(client.exists())
        XCTAssertEqual(client.get(), .hello)
        
        client.put(.world)
        XCTAssertEqual(client.get(), .world)
        
        client.delete()
    }
    
    func testDictBackend() {
        let client = UserDefaultsProperty<TestEnum>.inMemory()
        self.test(backend: client)
    }
    
    func testLive() {
        let client = UserDefaultsProperty<TestEnum>.live(key: self.testKey,
                                                         defaults: self.defaults)
        self.test(backend: client)
    }
}
