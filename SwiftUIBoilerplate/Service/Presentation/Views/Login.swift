//
//  Login.swift
//  SwiftUIBoilerplate
//
//  Created by 斉藤 祐輔 on 2020/11/19.
//

import SwiftUI

protocol LoginUI: UserInterface {}

struct Login : LoginUI {
    typealias From = RoutingTo.LoginFrom
    
    let from: From
    @EnvironmentObject var shared: SharedPresenter
    @State var isPresent = false

    init(from: From) {
        self.from = from
        log("\(from)")
    }
}

extension Login: View {
    
    var body: some View {
        VStack {
            ZStack {
                Color.yellow.edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    Spacer()
                    
                    Text("Login!")
                        
                    Spacer()
                    
                    Button("→ Login") {
                        self.shared.current = .home(from: .login)
                    }
                    
                    Spacer()
                    
                    HStack {
                        Button("→ Restart") {
                            self.shared.current = .splash(from: .login)
                        }
                        Button("→ Terms of Service") {
                            self.isPresent.toggle()
                        }
                    }
                    
                    Spacer()
                }
            }
        }
        .fullScreenCover(
            isPresented: self.$isPresent
            , onDismiss: {
                
            }
            , content: {
                TermsOfService()
            }
        )
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        RoutingTo.LoginFrom.splash.view
    }
}
