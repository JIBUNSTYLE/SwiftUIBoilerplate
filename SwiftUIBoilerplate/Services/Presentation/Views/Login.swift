//
//  Login.swift
//  SwiftUIBoilerplate
//
//  Created by 斉藤 祐輔 on 2020/11/19.
//

import SwiftUI

struct Login: View {
    
    @EnvironmentObject var shared: SharedPresenter
    @State var isPresent = false
    
    var body: some View {
        VStack {
            ZStack {
                Color.yellow.edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    Spacer()
                    
                    Text("Login!")
                        
                    Spacer()
                    
                    Button("→ Login") {
                        self.shared.current = .home
                    }
                    
                    Spacer()
                    
                    HStack {
                        Button("→ Restart") {
                            self.shared.current = .splash
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
        Login()
    }
}
