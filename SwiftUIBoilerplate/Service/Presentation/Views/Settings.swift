//
//  Settings.swift
//  SwiftUIBoilerplate
//
//  Created by 斉藤 祐輔 on 2020/11/19.
//

import SwiftUI

struct Settings: View {
    
    @EnvironmentObject var shared: SharedPresenter
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isPresetAlert = false
    @State private var resetResult = false
    
    var body: some View {
        ZStack {
            Color.red.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                Text("Settings!")
                
                Spacer()
                
                Button("→ Reset") {
                    self.shared.reset { isSuccess in
                        self.resetResult = isSuccess
                        self.isPresetAlert = true
                    }
                }
                .alert(isPresented: self.$isPresetAlert) {
                    Alert(title: self.resetResult ? Text("Succeed!") : Text("failed!"))
                }
                
                Spacer()
                
                Button("→ Back") {
                    self.presentationMode.wrappedValue.dismiss()
                }
                
                Spacer()
            }
        }
        .navigationBarTitle("Setting", displayMode: .inline)
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
