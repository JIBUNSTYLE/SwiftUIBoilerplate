//
//  Home.swift
//  SwiftUIBoilerplate
//
//  Created by 斉藤 祐輔 on 2020/11/19.
//

import SwiftUI

struct Home: View {
    
    @EnvironmentObject var shared: SharedPresenter
    @State var isPresent = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.green.edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    Spacer()
                    
                    Button("→ Logout") {
                        self.shared.current = .login
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
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
