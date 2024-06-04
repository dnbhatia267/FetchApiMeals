//
//  ViewController.swift
//  FetchApi
//
//  Created by Damman Bhatia on 6/3/24.
//

import UIKit

class ViewController: UITableViewController {

    //Mark: - Properties
    
    let reuseIdentifier = "MealCell"
    var meals: [MealModel] = []
    
    
    //Mark: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureTableView()
        
        let mealManager = MealManager()
        
        mealManager.fetchMeal { [weak self] (meals) in
            guard let self = self else { return }
            self.meals = meals
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = "Meals in  Dessert Category"
                    
            }
        }
        
    }
    //mealManager.fetchDetailedMeal(by: "52893") ;
    
    
    //Mark: - Helpers
    
    func configureTableView(){
        tableView.backgroundColor = .lightGray
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)

        
    }

}

// Mark: UITableViewDataSource & UITableViewDelegate Methods

extension ViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        let meal = meals[indexPath.row]
        cell.textLabel?.text = meal.strMeal
        
        if let url = URL(string: meal.strMealThumb) {
                   URLSession.shared.dataTask(with: url) { data, response, error in
                       if let data = data, let image = UIImage(data: data) {
                           DispatchQueue.main.async {
                               cell.imageView?.image = image
                               cell.setNeedsLayout() // Update the cell layout
                           }
                       }
                   }.resume()
               } else {
                   cell.imageView?.image = nil
               }
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMeal = meals[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil) 
        
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "MealDetailViewController") as? MealDetailViewController {
            let mealManager = MealManager()
            mealManager.fetchDetailedMeal(by: selectedMeal.idMeal) { [weak self] detailedMeal in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    if let detailedMeal = detailedMeal {
                        detailVC.meal = detailedMeal
                        self.navigationController?.pushViewController(detailVC, animated: true)
                    }
                }
            }
        }
    }
}

