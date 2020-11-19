//
//  Splash.swift
//  SwiftUIBoilerplate
//
//  Created by 斉藤 祐輔 on 2020/11/19.
//

import SwiftUI

struct Splash: View {
    
    @EnvironmentObject var shared: SharedPresenter
    
    var body: some View {
        VStack {
            ZStack {
                Color.purple.edgesIgnoringSafeArea(.all)
                
                Text("Swift UI Demo!")
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                self.shared.current = .login
            }
        }
    }
}

struct Splash_Previews: PreviewProvider {
    static var previews: some View {
        Splash()
    }
}
