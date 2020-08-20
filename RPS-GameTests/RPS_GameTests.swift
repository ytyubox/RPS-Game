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

    func testBoxed() {
        let deinitTarget = DeinitTarget()
        var target:TestTarget? = TestTarget(deinitTarget)
        target?.i = 1
        target = nil
        XCTAssertTrue(deinitTarget.called)
    }
}


class TestTarget {
    @Boxed var i = 0
    let deinitTarget:DeinitTarget
    var bindJob:Cancelable?
    init(_ deinitTarget:DeinitTarget) {
        self.deinitTarget = deinitTarget
        bindJob = $i.bind { (value) in
            print(#function, value)
        }
    }
    deinit {
        deinitTarget.called = true
        print(Self.self, #function)
    }
}

class DeinitTarget {
    var called = false
}
