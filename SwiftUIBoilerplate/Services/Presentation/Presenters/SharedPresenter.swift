//
//  SharedPresenter.swift
//  SwiftUIBoilerplate
//
//  Created by 斉藤 祐輔 on 2020/11/19.
//

import Foundation

enum ScreenId {
    case splash, login, home
}

class SharedPresenter: ObservableObject {
    
    @Published var current: ScreenId = .splash
    
}
