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
    case ac, plusMinus, percent, c
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
        case .c: return "C"
        case .minus: return "-"
        case .plus: return "+"
        case .decimal: return "."
        default:
            return "AC"
        }
    }
    var ops:(Float, Float)->Float{
        switch self {
        case .plus:
            return {$0+$1}
        case .minus:
            return {$0-$1}
        case .multiply:
            return {$0*$1}
        case .divide:
            return {$0/$1}
        case .percent:
            return {
                $0.truncatingRemainder(dividingBy:$1)
            }
        default:
            return {s1, s2 in
                return s1
            }
        }
    }
    var background: Color{
        switch self {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .decimal:
            return Color(.darkGray)
        case .ac, .percent, .c:
            return Color(.lightGray)
        default:
            return .orange
        }
    }
}

class GlobalEnviroment: ObservableObject {
    @Published var display = "0"
    @Published var numStr = ""
    @Published var ops:CalculatorButton = .null
    @Published var tempCalculation:Float = 0
    @Published var calcualtion:Float = 0
    func receiveInput(calculatorButton:CalculatorButton){
        
        if  calculatorButton == .zero || calculatorButton == .one || calculatorButton == .two || calculatorButton == .two || calculatorButton == .three || calculatorButton == .four ||
            calculatorButton == .five || calculatorButton == .six ||
            calculatorButton == .seven || calculatorButton == .eight ||
        calculatorButton == .nine || calculatorButton == .decimal {
            numStr += calculatorButton.title
            display = numStr
            if ops == .null || ops == .equals {
                calcualtion = Float(numStr)!
            }
            tempCalculation = ops.ops(calcualtion, Float(numStr)!)
        }
        else if calculatorButton == .plus || calculatorButton == .minus || calculatorButton == .multiply || calculatorButton == .divide || calculatorButton == .percent {
            ops = calculatorButton
            numStr = ""
            calcualtion = tempCalculation
        }
        else if calculatorButton  == .c{
            numStr = ""
            display = "0"
            tempCalculation = 0
        }
        else if calculatorButton == .ac {
            ops = .null
            numStr = ""
            display = "0"
            tempCalculation = 0
            calcualtion = 0
        }
        else if calculatorButton == .equals {
            ops = calculatorButton
            numStr = ""
            calcualtion = tempCalculation
            if calcualtion.truncatingRemainder(dividingBy: 1) == 0 {
                display = "\(Int(calcualtion))"
            }else {
            display = "\(calcualtion)"
            }
        }
    }
}

struct ContentView: View {
    
    @EnvironmentObject var env: GlobalEnviroment
    
    let buttons:[[CalculatorButton]] = [
        [.ac, .c, .percent, .divide],
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
