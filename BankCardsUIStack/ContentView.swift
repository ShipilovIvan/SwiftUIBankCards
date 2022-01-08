//
//  ContentView.swift
//  BankCardsUIStack
//
//  Created by Ion on 25.04.2021.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State var show = false
    @State var blurBackgroundState = false
    @State var viewState = CGSize.zero
    @State var showCard = false
    @State var showFull = false
    @State var bottomState = CGSize.zero

    
    var body: some View {
        
        ZStack {
            
            TitleForCertificatesView()
               .blur(radius: show ? 20 : 0)
               .blur(radius: blurBackgroundState ? 20 : 0)
               .opacity(showCard ? 0.4 : 1)
               .offset(y: showCard ? -200 : 0)
                .animation(
                    Animation
                        .default
                        .delay(0.2)
                    )
            
        
            LastBackCardView()
                .shadow(color: .black, radius: 36, x: 2, y: 4)
                .background(Color.blue)
                .cornerRadius(16)
                .offset(x: 0, y: show ? -360 : -48)
                .offset(x: viewState.width, y:viewState.height) /// DragModifire
                .scaleEffect(showCard ? 0.8 : 0.9)
                .rotationEffect(Angle(degrees: show ? 0 : 8))
                .rotation3DEffect(
                    Angle(degrees: 4),
                    axis: (x: 10, y: 0, z: 0.0),
                    anchor: .bottom,
                    anchorZ: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/,
                    perspective: 1.0
                )
                .rotation3DEffect(
                    .degrees(showCard ? 2 : 0),
                    axis: (x: 1, y: 0, z: 0.0),
                    anchor: .bottom,
                    anchorZ: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/,
                    perspective: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/
                )
                .animation(.easeInOut(duration: 0.6))
            
            
            BackCardView()
                .shadow(color: .black, radius: 36, x: 2, y: 4)
                .background(Color.black)
                .cornerRadius(20)
                .offset(x: 0, y: show ? -200 : -24)
                .offset(x: viewState.width, y:viewState.height)
                .scaleEffect(0.95)
                .rotationEffect(Angle.degrees(show ? 0 : 4))
                .rotation3DEffect(
                    Angle(degrees: 2),
                    axis: (x: 5, y: 0, z: 0.0),
                    anchor: .bottom,
                    anchorZ: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/,
                    perspective: 1.0
                )
                .rotation3DEffect(
                    .degrees(showCard ? 4 : 0),
                    axis: (x: 1, y: 0, z: 0.0),
                    anchor: .bottom,
                    anchorZ: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/,
                    perspective: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/
                )
                .animation(.easeInOut(duration: 0.3))
            
            
        
            CardView()
                .frame(width: showCard ? 375.0 : 340.0, height: 220.0)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: showCard ? 24 : 16, style: .continuous))
                .shadow(color: .accentColor, radius: 80, x: 24, y: 24)
                .offset(x: viewState.width, y:viewState.height)
                .offset(y: showCard ? -40 : 0)
                .blendMode(.normal)
                .rotation3DEffect(
                    .degrees(showCard ? 6 : 0),
                    axis: (x: 1, y: 0, z: 0.0),
                    anchor: .bottom,
                    anchorZ: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/,
                    perspective: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/
                )
                .animation(.spring())
                .onTapGesture {
                    self.showCard.toggle()
                    self.show.toggle()
                }
                .gesture(
                    DragGesture().onChanged { value in
                         self.viewState = value.translation
                         self.blurBackgroundState = true
                    }
                    .onEnded { value in
                        self.blurBackgroundState = false
                        self.viewState = .zero
                    }
                )
            

            
           // Text("\(bottomState.height)")  /// This is a way to show value from a drag component.
             //  .offset(y: -300)
            

            BottomInfoCardView(showCircle: $showCard)
                .offset(x: 0, y: showCard ? -72 : 320)
                    .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
                .offset(y: bottomState.height)
                .gesture(
                    DragGesture().onChanged { value in
                        self.bottomState = value.translation
                    }
                    .onEnded { value in
                        if self.bottomState.height > 50 {
                            self.showCard = false
                            self.show = false
                            self.bottomState.height = .zero
                        }
                    }
                )
                    
        }
        .background(Color.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View {
    
    var cardBackground:String = "R&M2"
    var cardBalance:String = "$5,820"
    var cardNumber:String = "**** **** **23 2323"
    var cardHolderName:String = "Sipilov Ivan"
    var cardExpirationDate:String = "12 / 25"
    var cardCompanyProvider:String = "Visa"
    
    var body: some View {
        ZStack {
            Image(cardBackground)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width:344, height: 220, alignment: .top)
                .scaleEffect(1.1)
            
            
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Text(cardBalance)
                                .modifier(MoneyBalanceFontModifier())
                                .padding(.top, 8)
                            
                            Spacer()
                            
                            Image("contactLessIconWhite")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 16, height: 0, alignment: .leading)
                                .padding(.top, 8)
                                .padding(.trailing, 8)
                        }
                        Spacer()

                        
                        Text(cardNumber)
                            .modifier(CardNumberFontModifier(size: 22))
                        
                        HStack {
                            Text(cardHolderName)
                                .modifier(CardInfoFontModifier(size: 12))
                            
                            HStack {
                                Text(cardExpirationDate)
                                    .modifier(CardInfoFontModifier(size: 12))
                                    
                                
                                Spacer()
                                
                                Image(cardCompanyProvider)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 64, height: 0, alignment: .trailing)
                            }
                        }
                    }
                    Spacer()
                }
                .padding()
                Spacer()
            }
        }
        .background(Color.white)
    }
}



struct BackCardView: View {
    var body: some View {
        VStack {
            CardView(cardBackground: "Card1", cardBalance: "$4,800", cardNumber: "**** **** **84 4562", cardHolderName: "Shipilova Asia", cardExpirationDate: "03 / 28", cardCompanyProvider: "Visa")
        }
        .frame(width:344, height: 220, alignment: .top)
    }
}



struct LastBackCardView: View {
    var body: some View {
        VStack {
            CardView(cardBackground: "Pilpy", cardBalance: "$13,700", cardNumber: "**** **** **84 4562", cardHolderName: "Shipilova Asia", cardExpirationDate: "03 / 28", cardCompanyProvider: "Visa")
        }
        .frame(width:344, height: 220, alignment: .top)
    }
}


struct TitleForCertificatesView: View {
    var body: some View {
        VStack {
            
            VStack {
                Text("Bank")
                    .modifier(PageTitleFontModifier(size: 56))
                Text("Cards")
                    .modifier(PageTitleFontModifier(size: 56))
                Spacer()
            }
            .padding()

            Image("mainIllustrationForBackground9")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 360, height: 360, alignment: .top)
                .blendMode(.multiply)
                .offset(y: -100)


            Spacer()
        }
    }
}


struct BottomInfoCardView: View {
    
    @Binding var showCircle: Bool
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 58, height: 5, alignment: .center)
                .cornerRadius(3)
                .opacity(0.1)
                .padding(.top, 13)
            
            Text("Revolut Bank")
                .multilineTextAlignment(.center)
                .padding()
                .lineSpacing(4)
            
            HStack {
                RingView(color1: #colorLiteral(red: 1, green: 0.4598931644, blue: 0.3749880197, alpha: 1), color2: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), widthOfTheCircle: 88, heightOfTheCircle: 88, percentOfTheCircle: 78, showCircle: $showCircle)
                    .padding()
                
                VStack(alignment: .leading, spacing: 8.0) {
                    Text("Budget Control").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text("$2,496 of $3,200 spent so far.")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .lineSpacing(4)
                }
                
                .padding(16)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.1), radius: 24, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 12)
            }
                
                  
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .cornerRadius(32)
        .shadow(radius: 24)
        .offset(x:0, y:498)
    }
}


