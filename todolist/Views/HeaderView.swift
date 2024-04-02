//
//  HeaderView.swift
//  todolist
//
//  Created by kai on 2024/03/31.
//

import SwiftUI

struct HeaderView: View {
    let title: String
    let subtitle : String
    let angle: Double
    let background: Color
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 0)
                .foregroundColor(background)
                .rotationEffect(Angle(degrees: angle))
            VStack{
                Text(title)
                    .font(.system(size: 50))
                    .foregroundColor(.white)
                    .bold()
                
                Text(subtitle)
                    .font(.system(size: 25))
                    .foregroundColor(.white)
            }
            .padding(.top, 80)
        }
        .frame(width:UIScreen.main.bounds.width * 3,height: 300)
    }
}

#Preview {
    HeaderView(title: "Title", subtitle: "Subtitle", angle: 15, background: .blue)
}
