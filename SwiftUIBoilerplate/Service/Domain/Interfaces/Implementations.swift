//
//  Implementations.swift
//  SwiftUIBoilerplate
//
//  Created by 斉藤 祐輔 on 2020/11/19.
//

import Foundation

struct Implementations {
    static private(set) var shared: Implementations = Implementations()
    
    var store: StoreInterface
   
    init(
        store: StoreInterface = UserDefaultsStore()
    ) {
        self.store = store
    }
    
    func set(mock: Implementations) {
        Implementations.shared = mock
    }
}
