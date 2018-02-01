//
//  Settings.swift
//  Swifty
//
//  Created by Vadim Pavlov on 10/20/17.
//  Copyright © 2017 Vadym Pavlov. All rights reserved.
//

import Foundation

public protocol SettingKey {
    init?(rawValue: String)
    var rawValue: String { get }
    
    static var allKeys: [Self] { get }
}

open class Settings<Key: SettingKey> {
    
    fileprivate let defaults: UserDefaults
    public init(defaults: UserDefaults) {
        self.defaults = defaults
    }
    
    public func clearAll() {
        Key.allKeys.forEach {
            self.set(value: nil, forKey: $0)
        }
    }
    
    public subscript<T>(key: Key) -> T? {
        set { self.set(value: newValue, forKey: key) }
        get { return self.get(key: key) as? T }
    }
    
    public subscript<E: RawRepresentable>(key: Key) -> E? {
        set { self.set(value: newValue?.rawValue, forKey: key) }
        get {
            let raw = self.get(key: key) as? E.RawValue
            return raw.flatMap(E.init)
        }
    }
}

private extension Settings {
    func set(value: Any?, forKey settingKey: Key) {
        let key = settingKey.rawValue
        if let newValue = value {
            defaults.set(newValue, forKey: key)
        } else {
            defaults.removeObject(forKey: key)
        }
    }
    
    func get(key settingKey: Key) -> Any? {
        let key = settingKey.rawValue
        return defaults.object(forKey: key)
    }
}
