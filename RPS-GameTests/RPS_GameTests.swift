//
//  RPS_GameTests.swift
//  RPS-GameTests
//
//  Created by 游宗諭 on 2020/8/20.
//  Copyright © 2020 Jeremy Xue. All rights reserved.
//

import XCTest
@testable import RPS_Game

class RPS_GameTests: XCTestCase {

    func testBoxedBindWithClosure() {
        let deinitTarget = DeinitTarget()
        var target:TestTarget? = TestTarget(deinitTarget)
        target?.bindJob = target?.$i.bind { [unowned self] (value) in
            print(#function, value)
            print(self)
        }
        target?.i = 1
        target = nil
        XCTAssertTrue(deinitTarget.called)
    }
    
    func testBoxedBindWithAssignOwned() {
        let deinitTarget = DeinitTarget()
        var target:TestTarget? = TestTarget(deinitTarget)
        target?.bindJob = target?.$i.bind(to: \.i2, unowned: target!)
        target?.i = 1
        target = nil
        XCTAssertTrue(deinitTarget.called)
    }
    
    func testBoxedBindWithAssignThatRetain() {
           let deinitTarget = DeinitTarget()
           var target:TestTarget? = TestTarget(deinitTarget)
           target?.bindJob = target?.$i.bind(to: \.i2, on: target!)
           target?.i = 1
           target = nil
           XCTAssertFalse(deinitTarget.called)
       }
}


class TestTarget {
    @Boxed var i = 0
    let deinitTarget:DeinitTarget
    var bindJob:AnyCancellable?
    var i2 = 0
    init(_ deinitTarget:DeinitTarget) {
        self.deinitTarget = deinitTarget
}
    deinit {
        deinitTarget.called = true
        print(Self.self, #function)
    }
}

class DeinitTarget {
    var called = false
}
