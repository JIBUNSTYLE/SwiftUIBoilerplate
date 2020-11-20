//
//  RoutingTo.swift
//  SwiftUIBoilerplate
//
//  Created by 斉藤 祐輔 on 2020/11/20.
//

import Foundation

protocol SplashPageRelation : PageRelation where To: SplashUI { }
protocol TutorialPageRelation : PageRelation where To: TutorialUI { }
protocol LoginPageRelation : PageRelation where To: LoginUI { }
protocol HomePageRelation : PageRelation where To: HomeUI { }

enum RoutingTo {
    
    enum SplashFrom : SplashPageRelation {
        typealias To = Splash
        case system, login
    }
    
    enum TutorialFrom : TutorialPageRelation {
        typealias To = Tutorial
        case splash
    }
    
    enum LoginFrom : LoginPageRelation {
        typealias To = Login
        case splash, tutorial, home
    }
    
    enum HomeFrom : HomePageRelation {
        typealias To = Home
        case login
    }
    
    case splash(from: SplashFrom)
    case tutorial(from: TutorialFrom)
    case login(from: LoginFrom)
    case home(from: HomeFrom)
}
