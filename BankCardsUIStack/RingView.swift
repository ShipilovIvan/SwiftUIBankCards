//
//  RingView.swift
//  BankCardsUIStack
//
//  Created by Ion on 14.06.2021.
//

import SwiftUI

struct RingView: View {
    
    var color1 = #colorLiteral(red: 1, green: 0.4598931644, blue: 0.3749880197, alpha: 1)
    var color2 = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    var widthOfTheCircle: CGFloat = 88
    var heightOfTheCircle: CGFloat = 88
    var percentOfTheCircle: CGFloat = 64
    
    @Binding var showCircle: Bool
    
    
    var body: some View {
        

        
        let multiplier = widthOfTheCircle / 44
        let progress = 1 - (percentOfTheCircle/100)

        return ZStack {
            
            Circle()
                .stroke(Color.black.opacity(0.1), style: StrokeStyle(lineWidth:3 * multiplier))
                .frame(width: widthOfTheCircle, height: heightOfTheCircle)
            
            Circle()
                .trim(from: showCircle ? progress : 1 , to:1)
                .stroke(
                    LinearGradient(gradient: Gradient(colors: [Color(color1), Color(color2)]), startPoint: .topTrailing, endPoint: .bottomLeading),
                    style: StrokeStyle(lineWidth: 5 * multiplier, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [], dashPhase: 0))
                .rotationEffect(Angle(degrees: 90))
                .rotation3DEffect(Angle(degrees: 180), axis: (x: 1.0, y: 0.0, z: 0.0))
                .frame(width: widthOfTheCircle, height: heightOfTheCircle)
                .shadow(color: Color(color1).opacity(0.4), radius: 24 * multiplier, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 4 * multiplier)
                


            Text("\(Int(percentOfTheCircle))%")
                .font(.system(size: 12 * multiplier))
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                .onTapGesture {
                    self.showCircle.toggle()
                }
 
        }
    }
}

/*
struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView(showCircle: constant(.false))
    }
}
 */
