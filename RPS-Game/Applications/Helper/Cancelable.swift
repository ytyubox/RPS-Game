//
//  Cancelable.swift
//  RPS-Game
//
//  Created by 游宗諭 on 2020/8/20.
//  Copyright © 2020 Jeremy Xue. All rights reserved.
//


protocol Cancelable:AnyObject {
    func cancel()
    func store(_ array: inout Array<Cancelable>)
}
extension Cancelable {
    func store(_ array: inout Array<Cancelable>) {
        array.append(self)
    }
}

class AnyCancelable:Cancelable {
    internal init(_ target: BindingRemoveable) {
        self.target = target
    }
    
    var target: BindingRemoveable
    func cancel() {
        target.removeBinding()
    }
    
    deinit {
        target.removeBinding()
        print(self.self,#function)
    }
}
