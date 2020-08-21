//
//  Cancelable.swift
//  RPS-Game
//
//  Created by 游宗諭 on 2020/8/20.
//  Copyright © 2020 Jeremy Xue. All rights reserved.
//


protocol AnyCancellable:AnyObject {
    func cancel()
    func store(_ array: inout Array<AnyCancellable>)
}
extension AnyCancellable {
    func store(_ array: inout Array<AnyCancellable>) {
        array.append(self)
    }
}

class Cancelable:AnyCancellable {
    private var _cancel: (() -> Void)?
    internal init(_ target: BindingRemoveable) {
        self._cancel = target.removeBinding
    }
    
    func cancel() {
        _cancel?()
        _cancel = nil
    }
    
    deinit {
        _cancel?()
        print(self.self,#function)
    }
}
