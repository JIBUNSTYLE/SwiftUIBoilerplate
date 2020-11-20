//
//  ContentView.swift
//  SwiftUIBoilerplate
//
//  Created by 斉藤 祐輔 on 2020/11/19.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var shared: SharedPresenter
    
    var body: some View {
        
        switch self.shared.current {
        case .splash(let from):
            from.view
        
        case .tutorial(let from):
            from.view
            
        case .login(let from):
            from.view
            
        case .home(let from):
            from.view
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
