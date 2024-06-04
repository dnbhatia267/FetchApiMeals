//
//  MealDetailViewController.swift
//  FetchApi
//
//  Created by Damman Bhatia on 6/3/24.
//

import UIKit

class MealDetailViewController: UITableViewController {

    // Mark: - Properties
    
    var meal: DetailedMealModel?
    let reuseIdentifier = "DetailCell"
    var mealImage: UIImage?

    // Mark: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        //loadImageAsync()
    }

    // Mark: - Helpers
    
    func configureTableView() {
        tableView.backgroundColor = .lightGray
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        navigationItem.title = meal?.strMeal
    }
    
   

    // Mark: - UITableViewDataSource Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        guard let meal = meal else { return cell }

        
        cell.textLabel?.textColor = .black
        cell.textLabel?.numberOfLines = 0
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = meal.strMeal
            
            if let url = URL(string: meal.strMealThumb) {
                       URLSession.shared.dataTask(with: url) { data, response, error in
                           if let data = data, let image = UIImage(data: data) {
                               DispatchQueue.main.async {
                                   cell.imageView?.image = image
                                   cell.setNeedsLayout() 
                               }
                           }
                       }.resume()
                   } else {
                       cell.imageView?.image = nil
                   }
        case 1:
            cell.textLabel?.text = "Category: \(meal.strCategory)"
        case 2:
            cell.textLabel?.text = "Area: \(meal.strArea)"
        case 3:
            if let youtube = meal.strYoutube, !youtube.isEmpty {
                cell.textLabel?.text = "YouTube: \(youtube)"
                cell.textLabel?.textColor = .blue
                cell.textLabel?.isUserInteractionEnabled = true
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleYoutubeTap))
                cell.textLabel?.addGestureRecognizer(tapGesture)
            } else {
                cell.textLabel?.text = "YouTube: N/A"
            }
        case 4:
            cell.textLabel?.text = "Drink Alternate: \(meal.strDrinkAlternate ?? "N/A")"
        case 5:
            cell.textLabel?.text = "Instructions: \(meal.strInstructions)"
            cell.textLabel?.numberOfLines = 0
        case 6:
            cell.textLabel?.text = "Tags: \(meal.strTags ?? "N/A")"
        case 7:
            var ingredients = ""
            let ingredientsAndMeasures = [
                (meal.strIngredient1, meal.strMeasure1),
                (meal.strIngredient2, meal.strMeasure2),
                (meal.strIngredient3, meal.strMeasure3),
                (meal.strIngredient4, meal.strMeasure4),
                (meal.strIngredient5, meal.strMeasure5),
                (meal.strIngredient6, meal.strMeasure6),
                (meal.strIngredient7, meal.strMeasure7),
                (meal.strIngredient8, meal.strMeasure8),
                (meal.strIngredient9, meal.strMeasure9),
                (meal.strIngredient10, meal.strMeasure10),
                (meal.strIngredient11, meal.strMeasure11),
                (meal.strIngredient12, meal.strMeasure12),
                (meal.strIngredient13, meal.strMeasure13),
                (meal.strIngredient14, meal.strMeasure14),
                (meal.strIngredient15, meal.strMeasure15),
                (meal.strIngredient16, meal.strMeasure16),
                (meal.strIngredient17, meal.strMeasure17),
                (meal.strIngredient18, meal.strMeasure18),
                (meal.strIngredient19, meal.strMeasure19),
                (meal.strIngredient20, meal.strMeasure20)
            ]
            
            for (ingredient, measure) in ingredientsAndMeasures {
                if let ingredient = ingredient, !ingredient.isEmpty,
                   let measure = measure, !measure.isEmpty {
                    ingredients += "\(ingredient) - \(measure)\n"
                }
            }
            cell.textLabel?.text = "Ingredients:\n\(ingredients)"
            cell.textLabel?.numberOfLines = 0
        case 8:
            if let youtube = meal.strSource, !youtube.isEmpty {
            cell.textLabel?.text = "Source: \(meal.strSource ?? "N/A")"
            cell.textLabel?.textColor = .blue
            cell.textLabel?.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSourceTap))
            cell.textLabel?.addGestureRecognizer(tapGesture)
        } else {
            cell.textLabel?.text = "YouTube: N/A"
        }
        default:
            break
        }
        return cell
    }

    @objc func handleYoutubeTap(sender: UITapGestureRecognizer) {
        guard let youtube = meal?.strYoutube, let url = URL(string: youtube) else { return }
        UIApplication.shared.open(url)
    }
   
    @objc func handleSourceTap(sender: UITapGestureRecognizer) {
        guard let youtube = meal?.strSource, let url = URL(string: youtube) else { return }
        UIApplication.shared.open(url)
    }

    


}
