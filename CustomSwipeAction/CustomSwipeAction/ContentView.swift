//
//  ContentView.swift
//  CustomSwipeAction
//
//  Created by Hanlin Chen on 10/13/20.
//

import SwiftUI
import Combine

class MealItems:ObservableObject{
    @Published var items = [
        MealItem(mealName: "20 Peice Chicken Bucket", mealPrice: 20.99, image: "chicken_bucket"),
        MealItem(mealName: "Chicken & Fries Meal", mealPrice: 15.56, image: "chicken_fries"),
        MealItem(mealName: "Chicken Sandwidch", mealPrice: 7.99, image: "chicken_sandwich"),
        
        MealItem(mealName: "Mashed Potato", mealPrice: 3.79, image: "mash_potato"),
        MealItem(mealName: "Pepsi", mealPrice: 1.75, image: "pepsi")
    ]
}

struct ContentView: View {
    @StateObject var mealItems = MealItems()
    var totalFormater: NumberFormatter = {
            let totalformatter = NumberFormatter()
        totalformatter.numberStyle = .currency
        return totalformatter
    }()
    func getIndex(_ item: MealItem)->Int{
        return mealItems.items.firstIndex(where: {meal in meal.id == item.id}) ?? 0
    }
    var body: some View {
            VStack(alignment:.center){
                HStack{
                    Text("Menu").font(.title).fontWeight(.bold).foregroundColor(.white).padding(.top, 50).padding(.horizontal)
                Spacer()
                }
                ScrollView{
                    VStack(alignment:.leading){
                        ForEach(mealItems.items){
                            item in
                            MealItemView(mealItem: $mealItems.items[getIndex(item)], mealItems: $mealItems.items)
                        }
                    }
                }.background(Color.red)
                HStack{
                    Spacer()
                    Text("Your Total: \(totalFormater.string(from: self.getTotal() as NSNumber)!) ").font(.headline).fontWeight(.bold).foregroundColor(.white)
                }.padding()
                Button(action: {}, label: {
                    RoundedRectangle(cornerRadius: 10).frame(width: 300, height: 50).foregroundColor(.white).overlay(
                        Text("Check Out").font(.title).fontWeight(.bold).foregroundColor(.red))
                }).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/).padding(.bottom, 40)
            }.background(Color.red).ignoresSafeArea(.all)
    }
    func getTotal()->Double{
        var total: Double = 0
        for mealitem in mealItems.items {
            total += Double(mealitem.quantity) * mealitem.mealPrice
        }
        return total
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
