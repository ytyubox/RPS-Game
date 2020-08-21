//
//  Boxed.swift
//  RPS-Game
//
//  Created by 游宗諭 on 2020/8/21.
//  Copyright © 2020 Jeremy Xue. All rights reserved.
//


@propertyWrapper
public
struct Boxed<Value> {
    public
    init(wrappedValue: Value) {
        value = wrappedValue
    }
    
    private var value:Value
    
    private lazy var box:Box<Value> = Box(value)
    
    public var projectedValue: Box<Value> {
        mutating get {
            return box
        }
    }
    /// This method is call when access by Object.value
    /// see  https://forums.swift.org/t/property-wrappers-access-to-both-enclosing-self-and-wrapper-instance/32526
    public static subscript<EnclosingSelf: AnyObject>(
        _enclosingInstance object: EnclosingSelf,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<EnclosingSelf, Value>,
        storage storageKeyPath: ReferenceWritableKeyPath<EnclosingSelf, Boxed<Value>>
    ) -> Value {
        get {
            return object[keyPath: storageKeyPath].value
        }
        set {
            object[keyPath: storageKeyPath].box.value = newValue
            object[keyPath: storageKeyPath].value = newValue
        }
    }
    
    @available(*, unavailable, message: """
    @Boxed is only available on properties of classes
    """)
    /// This will never be call because the Boxed in struct always cause compile error
    public
    var wrappedValue: Value {
        get{
            fatalError("@Boxed is only available on properties of classes")
        }
        set{
            fatalError("@Boxed is only available on properties of classes")
        }
    }
}

