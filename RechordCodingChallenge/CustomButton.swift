//
//  CustomButton.swift
//  RechordCodingChallenge
//
//  Created by Giresh Dora on 15/04/22.
//

import SwiftUI

struct CustomButton: View {
    
    var title: String
    
    var body: some View {
        
        Text(title)
            .frame(maxWidth: .infinity)
            .frame( height: 50)
            .font(.system(size: 16, weight: .bold, design: .rounded))
            .foregroundColor(Color("Button_Foreground"))
            .background(Color("Button_Background"))
            .cornerRadius(25)
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(title: "Hello")
    }
}
