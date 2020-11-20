//
//  Application.swift
//  SwiftUIBoilerplate
//
//  Created by 斉藤 祐輔 on 2020/11/19.
//

import Foundation

class Application {
    
    var hasCompletedTutorial: Bool {
        get {
            if let value = Implementations.shared.store.get(KeyValue.BoolKey.hasCompletedTutorial) {
                return value
            } else {
                return false
            }
        }
        set {
            Implementations.shared.store.save(
                KeyValue.bool(key: .hasCompletedTutorial, value: newValue)
            )
        }
    }
    
    func reset() -> Bool {
        KeyValue.BoolKey.allCases.forEach {
            Implementations.shared.store.delete($0)
        }
        return true
    }
}
