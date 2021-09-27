//
//  Home.swift
//  SwiftUIBoilerplate
//
//  Created by 斉藤 祐輔 on 2020/11/19.
//

import SwiftUI

protocol HomeUI: UserInterface {}

struct Home : HomeUI {
    typealias From = RoutingTo.HomeFrom
    
    let from: From
    let message: String
    
    @EnvironmentObject var shared: SharedPresenter
    @State var isPresent = false
    @State var isPresentWelcome = false

    init(from: From) {
        self.from = from
        self.message = "Welcome!"
        log("\(from)")
    }
    
    init(from: From, message: String) {
        self.from = from
        self.message = message
        log("\(from)")
    }
}

extension Home: View {
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.green.edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    Spacer()
                    
                    Button("→ Logout") {
                        self.shared.routingTo = .login(from: .home)
                    }
                    
                    Spacer()
                    
                    NavigationLink(
                        destination: Settings()
                        , isActive: self.$isPresent) {
                        Button("→ Settings") {
                            self.isPresent.toggle()
                        }
                    }
                    
                    Spacer()
                }
            }
            .navigationBarTitle("Home", displayMode: .large)
            .sheet(isPresented: self.$isPresentWelcome) {
                VStack {
                    Spacer()
                    
                    Text(self.message)
                    
                    Spacer()
                    
                    Button("Close") {
                        self.isPresentWelcome.toggle()
                    }
                    
                    Spacer()
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if case .login = self.from { self.isPresentWelcome = true }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        RoutingTo.HomeFrom.login.view
    }
}
