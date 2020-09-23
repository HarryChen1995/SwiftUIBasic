//
//  ContentView.swift
//  Stacking
//
//  Created by Hanlin Chen on 9/23/20.
//  Copyright © 2020 Hanlin Chen. All rights reserved.
//

import SwiftUI


enum CalculatorButton:String{
    case zero, one, two, three, four, five, six, seven, eight, nine
    case equals, plus, minus, multiply, divide
    case decimal
    case ac, plusMinus, percent
    case null
    var title:String{
        switch self {
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .equals: return "="
        case .multiply: return "X"
        case .divide: return "/"
        case .percent: return "%"
        case .plusMinus: return "+/-"
        case .minus: return "-"
        case .plus: return "+"
        case .decimal: return "."
        default:
            return "AC"
        }
    }
    var background: Color{
        switch self {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
            return Color(.darkGray)
        case .ac, .plus, .percent:
            return Color(.lightGray)
        default:
            return .orange
        }
    }
}

class GlobalEnviroment: ObservableObject {
    @Published var display = ""
   
    func receiveInput(calculatorButton:CalculatorButton){
        display = calculatorButton.title
    }
}

struct ContentView: View {
    
    @EnvironmentObject var env: GlobalEnviroment
    
    let buttons:[[CalculatorButton]] = [
        [.ac, .plusMinus, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equals]
    ]
    var body: some View {
        ZStack(alignment: .bottom){
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing:12){
                HStack{
                    Spacer()
                    Text(env.display).foregroundColor(.white).font(.system(size: 64))
                }.padding()
                ForEach(buttons, id:\.self){ row in
                    HStack(spacing:12){
                        ForEach(row, id: \.self){ button in
                            CalculatorButtonView(button: button)
                        }
                    }
                }
            }.padding()
        }
    }
    
    
    
}


struct CalculatorButtonView: View {
    var button: CalculatorButton
    @EnvironmentObject var env: GlobalEnviroment
    var body: some View{
        
        Button(action: {
            self.env.receiveInput(calculatorButton: self.button)
        }){
            
            Text(button.title).font(.system(size: 32)).frame(width:self.buttonWidth(button), height:self.buttonHeight())
                .foregroundColor(.white)
                .background(button.background)
                .cornerRadius(self.buttonWidth(button)/2)
        }
        
    }
    
    private   func buttonHeight()->CGFloat{
        return (UIScreen.main.bounds.width - 5 * 12)/4
    }
    private  func buttonWidth(_ button: CalculatorButton)->CGFloat{
        if button == .zero {
            return (UIScreen.main.bounds.width - 4 * 12)/4 * 2
        }
        return (UIScreen.main.bounds.width - 5 * 12)/4
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GlobalEnviroment())
    }
}
