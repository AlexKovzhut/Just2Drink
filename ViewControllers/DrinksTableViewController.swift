//
//  DrinksTableViewController.swift
//  Just2Drink
//
//  Created by Alexander Kovzhut on 08.01.2022.
//

import UIKit

class DrinksTableViewController: UIViewController {
    // MARK: - Private methods
    private let tableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)

    private var cocktailDB: CocktailDB?
    private var filteredDrink: [Drink] = []
    private var searchBarIsEmpty: Bool {
           guard let text = searchController.searchBar.text else { return false }
           return text.isEmpty
       }
    private var isFiltering: Bool {
           return searchController.isActive && !searchBarIsEmpty
       }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupNavigationBar()
        setupSearchController()
        setupStyle()
        setupLayout()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(#function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(#function)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print(#function)
    }
    
    override func loadView() {
        super.loadView()
        print(#function)
    }
}

// MARK: - Private Methods
extension DrinksTableViewController {
   private func setup() {
       tableView.dataSource = self
       tableView.delegate = self
   }
   
   private func setupNavigationBar() {
       navigationItem.title = "Discover"
       navigationController?.navigationBar.prefersLargeTitles = true
       
       navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshBarButtonTapped))
   }
   
   private func setupSearchController() {
       searchController.searchResultsUpdater = self
       navigationItem.searchController = searchController
       searchController.hidesNavigationBarDuringPresentation = true
       searchController.obscuresBackgroundDuringPresentation = false
       searchController.searchBar.placeholder = "Find a cocktail..."
       searchController.searchBar.backgroundColor = .white
       definesPresentationContext = true
              
       if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
           textField.font = UIFont.boldSystemFont(ofSize: 17)
           textField.textColor = .systemPink
       }
   }
   
   private func setupStyle() {
       tableView.translatesAutoresizingMaskIntoConstraints = false
       tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
       tableView.rowHeight = 80
   }
   
   private func setupLayout() {
       view.addSubview(tableView)
       
       NSLayoutConstraint.activate([
        tableView.topAnchor.constraint(equalTo: view.topAnchor),
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
       ])
   }
    
    private func fetchData() {
        NetworkManager.shared.fetchData() {  cocktails in
            DispatchQueue.main.async {
                self.cocktailDB = cocktails
                self.tableView.reloadData()
            }
        }
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension DrinksTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredDrink.count : cocktailDB?.drinks.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        
        let searchResult = isFiltering ? filteredDrink[indexPath.row] : cocktailDB?.drinks[indexPath.row]
        cell.configure(with: searchResult!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let drink = isFiltering ? filteredDrink[indexPath.row] : cocktailDB?.drinks[indexPath.row]
        
        let destinationController = DetailViewController()
        destinationController.drink = drink
        
        let navigationController = UINavigationController(rootViewController: destinationController)
        
        navigationController.modalTransitionStyle = .flipHorizontal
        
    
    }
}

// MARK: - UISearchResultsUpdating
extension DrinksTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredDrink = cocktailDB?.drinks.filter { chracter in
            chracter.strDrink.lowercased().contains(searchText.lowercased())
        } ?? []
        
        tableView.reloadData()
    }
}

    // MARK: - @objc methods
extension DrinksTableViewController {
    @objc func refreshBarButtonTapped() {
        tableView.reloadData()
    }
}
