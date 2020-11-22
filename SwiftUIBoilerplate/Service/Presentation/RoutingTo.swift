//
//  RoutingTo.swift
//  SwiftUIBoilerplate
//
//  Created by 斉藤 祐輔 on 2020/11/20.
//

import Foundation

enum RoutingTo {
    
    enum SplashFrom : RoutingFrom {
        typealias To = Splash
        case system, login
    }
    
    enum TutorialFrom : RoutingFrom {
        typealias To = Tutorial
        case splash
    }
    
    enum LoginFrom : RoutingFrom {
        typealias To = Login
        case splash, tutorial, home
    }
    
    enum HomeFrom : RoutingFrom {
        typealias To = Home
        case login
    }
    
    case splash(from: SplashFrom)
    case tutorial(from: TutorialFrom)
    case login(from: LoginFrom)
    case home(from: HomeFrom)
}
