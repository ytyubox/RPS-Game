//
//  Box.swift
//  RPS-Game
//
//  Created by Jeremy Xue on 2020/8/20.
//  Copyright © 2020 Jeremy Xue. All rights reserved.
//

protocol BindingRemoveable {
    func removeBinding()
}

class Box<Value> {
    
    typealias ValueChangedAction = (Value) -> Void
    
    // MARK: Properties
    private var valueChangedAction: ValueChangedAction?
    var value: Value
    {
        didSet {
            valueChangedAction?(value)
        }
    }
    
    // MARK: Initializers
    init(_ value: Value) {
        self.value = value
    }
    deinit {
        print(Self.self, #function)
    }
}

// MARK: - Methods
extension Box {
    func bind(_ action: @escaping ValueChangedAction) -> Cancelable {
        valueChangedAction = action
        valueChangedAction?(value)
        return AnyCancelable(self)
    }
}

extension Box:BindingRemoveable {
    func removeBinding() {
        valueChangedAction = nil
    }
}
