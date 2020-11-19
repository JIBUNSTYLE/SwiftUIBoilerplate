//
//  Settings.swift
//  SwiftUIBoilerplate
//
//  Created by 斉藤 祐輔 on 2020/11/19.
//

import SwiftUI

struct Settings: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color.red.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                Text("Settings!")
                
                Spacer()
                
                Button("→ back") {
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
