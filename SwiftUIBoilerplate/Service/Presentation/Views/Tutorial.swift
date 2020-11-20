//
//  Tutorial.swift
//  SwiftUIBoilerplate
//
//  Created by 斉藤 祐輔 on 2020/11/19.
//

import SwiftUI

protocol TutorialUI: UserInterface {}

struct Tutorial : TutorialUI {
    typealias From = RoutingTo.TutorialFrom
    
    let from: From
    @EnvironmentObject var shared: SharedPresenter
    @State var isPresent = false

    init(from: From) {
        self.from = from
        log("\(from)")
    }
}

extension Tutorial: View {
    var body: some View {
        VStack {
            ZStack {
                Color.pink.edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    Spacer()
                    
                    Text("Tutorial!")
                        
                    Spacer()
                    
                    Button("→ Complete") {
                        self.shared.completeTutorial()
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

struct Tutorial_Previews: PreviewProvider {
    static var previews: some View {
        RoutingTo.TutorialFrom.splash.view
    }
}
