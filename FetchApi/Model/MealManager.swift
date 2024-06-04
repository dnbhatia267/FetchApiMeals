//
//  MealManager.swift
//  FetchApi
//
//  Created by Damman Bhatia on 6/3/24.
//

import Foundation

struct MealManager {
    func fetchMeal(completion: @escaping ([MealModel]) -> Void) {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert") else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error fetching meals: \(error.localizedDescription)")
                return
            }
            
            guard let jsonData = data else { return }
            
            let decoder = JSONDecoder()
            
            do {
                let decodedData = try decoder.decode(MealsResponse.self, from: jsonData)
                let meals = decodedData.meals
                completion(meals)
            } catch {
                print("Error decoding data: \(error)")
            }
        }
        dataTask.resume()
    }
    
    func fetchDetailedMeal(by id: String, completion: @escaping (DetailedMealModel?) -> Void) {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(id)") else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error fetching detailed meal: \(error.localizedDescription)")
                return
            }
            
            guard let jsonData = data else { return }
            
            let decoder = JSONDecoder()
            
            do {
                let decodedData = try decoder.decode(DetailedMealsResponse.self, from: jsonData)
                let detailedMeal = decodedData.meals.first
                completion(detailedMeal)
            } catch {
                print("Error decoding data: \(error)")
            }
        }
        dataTask.resume()
    }
}
