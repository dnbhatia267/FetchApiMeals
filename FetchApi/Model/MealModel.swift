//
//  MealModel.swift
//  FetchApi
//
//  Created by Damman Bhatia on 6/3/24.
//

import Foundation

struct MealModel: Decodable{
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}
struct MealsResponse: Decodable {
    let meals: [MealModel]
}
