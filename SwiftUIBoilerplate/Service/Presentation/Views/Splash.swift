//
//  Splash.swift
//  SwiftUIBoilerplate
//
//  Created by 斉藤 祐輔 on 2020/11/19.
//

import SwiftUI

protocol SplashUI: UserInterface {}

struct Splash : SplashUI {
    typealias From = RoutingTo.SplashFrom
    
    let from: From
    @EnvironmentObject var shared: SharedPresenter

    init(from: From) {
        self.from = from
        log("\(from)")
    }
}

extension Splash: View {
    
    var body: some View {
        VStack {
            ZStack {
                Color.purple.edgesIgnoringSafeArea(.all)
                
                Text("Swift UI Demo!")
            }
        }
        .onAppear {
            self.shared.boot()
        }
    }
}

struct Splash_Previews: PreviewProvider {
    static var previews: some View {
        RoutingTo.SplashFrom.system.view
    }
}
