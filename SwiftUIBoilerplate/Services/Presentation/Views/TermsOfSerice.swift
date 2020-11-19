//
//  TermsOfSerice.swift
//  SwiftUIBoilerplate
//
//  Created by 斉藤 祐輔 on 2020/11/19.
//

import SwiftUI

struct TermsOfService: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color.orange.edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                
                Text("TermsOfService!")
                
                Spacer()
                
                Button("→ back") {
                    self.presentationMode.wrappedValue.dismiss()
                }
                
                Spacer()
            }
        }
    }
}

struct TermsOfService_Previews: PreviewProvider {
    static var previews: some View {
        TermsOfService()
    }
}
