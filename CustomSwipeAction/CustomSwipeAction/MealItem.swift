//
//  MealItem.swift
//  CustomSwipeAction
//
//  Created by Hanlin Chen on 10/13/20.
//
import SwiftUI
struct MealItem : Identifiable{
    var id = UUID()
    var mealName:String
    var mealPrice: Double
    var image:String
    var quantity:Int = 0
    var offsetX: CGFloat = 0
    var isSwipe: Bool = false
}
