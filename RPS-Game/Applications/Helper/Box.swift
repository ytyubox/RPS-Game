//
//  Box.swift
//  RPS-Game
//
//  Created by Jeremy Xue on 2020/8/20.
//  Copyright © 2020 Jeremy Xue. All rights reserved.
//

protocol BindingRemoveable: AnyObject{
    func removeBinding()
}
public
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
    func bind(_ action: @escaping ValueChangedAction) -> AnyCancellable {
        valueChangedAction = action
        valueChangedAction?(value)
        return Cancelable(self)
    }
    func bind<Root:AnyObject>(
        to keyPath: ReferenceWritableKeyPath<Root,Value>,
        on object:Root
    ) -> AnyCancellable {
        bind {object[keyPath: keyPath] = $0}
    }
    func bind<Root>(
         to keyPath: ReferenceWritableKeyPath<Root,Value>,
         unowned object:Root
    ) -> AnyCancellable
         where Root: AnyObject
    {
        return bind { [unowned object] in
            object[keyPath: keyPath] = $0
        }
     }
}

extension Box:BindingRemoveable {
    func removeBinding() {
        valueChangedAction = nil
    }
}
