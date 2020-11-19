//
//  SwiftUIBoilerplateApp.swift
//  SwiftUIBoilerplate
//
//  Created by 斉藤 祐輔 on 2020/11/19.
//

import SwiftUI

@main
struct SwiftUIBoilerplateApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .animation(.easeOut)
                .environmentObject(SharedPresenter())
        }
    }
}
