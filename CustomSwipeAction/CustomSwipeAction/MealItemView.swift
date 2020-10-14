//
//  MealItemView.swift
//  CustomSwipeAction
//
//  Created by Hanlin Chen on 10/13/20.
//

import SwiftUI

struct MealItemView: View {
     @Binding var  mealItem:MealItem
    @Binding var mealItems:[MealItem]
    var priceFormatter:NumberFormatter = {
        let priceformatter = NumberFormatter()
        priceformatter.numberStyle = .currency
        return priceformatter
    }()
    
    var body: some View{
        ZStack{
            Color.red
            HStack{
                Spacer()
                Button(action: {
                    self.deleteMealItem()
                }, label: {
                    Image(systemName: "trash").foregroundColor(.white).padding(.horizontal, 50)
                })
        
            }
        HStack(alignment:.bottom){
            VStack(alignment:.leading, spacing:5){
                Image(mealItem.image).resizable().aspectRatio(contentMode: .fit).cornerRadius(20).shadow(radius: 5).padding(.bottom, 10)
                Text(mealItem.mealName).font(.system(size: 20)).fontWeight(.bold)
                
                Text("Price: \(priceFormatter.string(from: mealItem.mealPrice as NSNumber)!)").font(.headline).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            }.frame(width: 200, height: 200)
            Spacer()
            HStack{
                Button(action: {
                    withAnimation(.default){
                        if self.mealItem.quantity > 0  {
                            self.mealItem.quantity -= 1
                        }
                    }
                }, label: {
                    Image(systemName: "minus")
                }).foregroundColor(.black)
                Spacer()
                Text("Quantity: \(mealItem.quantity)").font(.subheadline).fontWeight(.bold)
                Spacer()
                Button(action: {
                    self.mealItem.quantity += 1
                }, label: {
                    Image(systemName: "plus").foregroundColor(.black)
                })
            }
        }.padding().background(Color.white).gesture(
            DragGesture().onChanged(changed(value:)).onEnded(ended(value:))
        ).onTapGesture{
            withAnimation(.easeOut){
                mealItem.offsetX = 0
            }
        }.offset(x:mealItem.offsetX)
        }
    }
    
    
    func changed(value:DragGesture.Value){
        if value.translation.width < 0 {
            if mealItem.isSwipe {
                mealItem.offsetX  = value.translation.width-150
            }
            else{
                mealItem.offsetX  = value.translation.width
            }
        }
    }
    func ended(value:DragGesture.Value){
        withAnimation(.easeOut){
            if value.translation.width < 0 {
                if -value.translation.width  > UIScreen.main.bounds.width / 2 {
                    mealItem.offsetX = -1000
                    deleteMealItem()
                }
                else if -mealItem.offsetX > 50{
                    mealItem.isSwipe = true
                    mealItem.offsetX = -150
                }
            }else{
                mealItem.isSwipe = false
                mealItem.offsetX = 0
            }
        }
    }
    
    func deleteMealItem(){
        mealItems.removeAll(where: {meal in meal.id == mealItem.id})
    }
}
