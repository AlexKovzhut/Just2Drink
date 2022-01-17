//
//  DetailViewController.swift
//  Just2Drink
//
//  Created by Alexander Kovzhut on 09.01.2022.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    private let backgroundScrollView = UIScrollView()
    private let activityIndicator = UIActivityIndicatorView()
    
    private let drinkTitleLabel = UILabel()
    private let drinkImageView = UIImageView()
    
    private let alcoholStackView = UIStackView()
    private let alcoholTitleLabel = UILabel()
    private let alcoholTypeLabel = UILabel()
    
    private let glassStackView = UIStackView()
    private let glassTitleLabel = UILabel()
    private let glassTypeLabel = UILabel()
    
    private var recipeTextView = UITextView()
    private let ingredientsTextView = UITextView()
    
    var drink: Drink?
    var headerContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupNavigationBar()
        setupStyle()
        setupLayout()
        fetchDrink()
    }
    
    @objc private func favoriteButtonPressed() {
           print(#function)
       }
       
    @objc private func cancelButtonPressed() {
        print(#function)
        
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: - Private Methods
extension DetailViewController {
   private func setupNavigationBar() {
//       let saveBarButton = UIBarButtonItem(
//        barButtonSystemItem: .save,
//        target: self,
//        action: #selector(cancelButtonPressed)
//       )
//
//       let cancelBarButton = UIBarButtonItem(
//        barButtonSystemItem: .cancel,
//        target: self,
//        action: #selector(favoriteButtonPressed)
//       )
       
       self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
       self.navigationController?.navigationBar.shadowImage = UIImage()
       self.navigationController?.navigationBar.isTranslucent = true
       self.navigationController?.navigationBar.tintColor = .white

//       saveBarButton.tintColor = .white
//       cancelBarButton.tintColor = .white
//
//       navigationItem.leftBarButtonItem = saveBarButton
//       navigationItem.rightBarButtonItem = cancelBarButton
   }
   
   private func setupStyle() {
       view.backgroundColor = .red
       
       backgroundScrollView.translatesAutoresizingMaskIntoConstraints = false
       backgroundScrollView.alwaysBounceVertical = true
       backgroundScrollView.backgroundColor = .white
       backgroundScrollView.delegate = self
       
       activityIndicator.translatesAutoresizingMaskIntoConstraints = false
       activityIndicator.isHidden = true
       activityIndicator.hidesWhenStopped = true
       activityIndicator.color = .black
       
       drinkTitleLabel.translatesAutoresizingMaskIntoConstraints = false
       drinkTitleLabel.textColor = .white
       drinkTitleLabel.shadowColor = .black
       drinkTitleLabel.shadowOffset = CGSize(width: 2, height: 2)
       drinkTitleLabel.font = UIFont(name: "Futura", size: 40)
       
       //Drink image block
       drinkImageView.translatesAutoresizingMaskIntoConstraints = false
       drinkImageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 300)
       drinkImageView.contentMode = .scaleAspectFill
       
       //Alcohol stackView block
       alcoholStackView.translatesAutoresizingMaskIntoConstraints = false
       alcoholStackView.spacing = 8
       alcoholStackView.axis = .vertical
       alcoholStackView.alignment = .fill
       alcoholStackView.distribution = .fillProportionally
       
       alcoholTitleLabel.translatesAutoresizingMaskIntoConstraints = false
       alcoholTitleLabel.text = "Alcohol:"
       alcoholTitleLabel.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
       alcoholTitleLabel.textColor = .purple
       alcoholTitleLabel.shadowColor = .black
       
       alcoholTypeLabel.translatesAutoresizingMaskIntoConstraints = false
       alcoholTypeLabel.text = "No"
       alcoholTypeLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
       alcoholTypeLabel.textColor = .black
       alcoholTypeLabel.shadowColor = .black
       
       //Glass stackView block
       glassStackView.translatesAutoresizingMaskIntoConstraints = false
       glassStackView.spacing = 8
       glassStackView.axis = .vertical
       glassStackView.alignment = .fill
       glassStackView.distribution = .fillProportionally
       
       glassTitleLabel.translatesAutoresizingMaskIntoConstraints = false
       glassTitleLabel.text = "Glass Type:"
       glassTitleLabel.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
       glassTitleLabel.textColor = .purple
       glassTitleLabel.shadowColor = .black
       
       glassTypeLabel.translatesAutoresizingMaskIntoConstraints = false
       glassTypeLabel.text = "Bottle"
       glassTypeLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
       glassTypeLabel.textColor = .black
       glassTypeLabel.shadowColor = .black
       
       
       ingredientsTextView.translatesAutoresizingMaskIntoConstraints = false
       
       recipeTextView.translatesAutoresizingMaskIntoConstraints = false
       recipeTextView.textColor = .white
       recipeTextView.backgroundColor = .black
       recipeTextView.font = UIFont.systemFont(ofSize: 20)
       recipeTextView.layer.cornerRadius = 10
       recipeTextView.isEditable = false
       recipeTextView.bounces = true
       recipeTextView.isScrollEnabled = false
       
   }
   
   private func setupLayout() {
       // Header image layout
       view.addSubview(drinkImageView)
       view.addSubview(activityIndicator)
       drinkImageView.addSubview(drinkTitleLabel)
       
       // ScrollView layot
       view.addSubview(backgroundScrollView)
       backgroundScrollView.addSubview(alcoholStackView)
       backgroundScrollView.addSubview(glassStackView)
       backgroundScrollView.addSubview(ingredientsTextView)
       backgroundScrollView.addSubview(recipeTextView)
       
       alcoholStackView.addArrangedSubview(alcoholTitleLabel)
       alcoholStackView.addArrangedSubview(alcoholTypeLabel)
       
       glassStackView.addArrangedSubview(glassTitleLabel)
       glassStackView.addArrangedSubview(glassTypeLabel)
       
       
       NSLayoutConstraint.activate([
        activityIndicator.centerXAnchor.constraint(equalTo: drinkImageView.centerXAnchor),
        activityIndicator.centerYAnchor.constraint(equalTo: drinkImageView.centerYAnchor),
        
        drinkImageView.topAnchor.constraint(equalTo: view.topAnchor),
        drinkImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        drinkImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        drinkImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
        
        backgroundScrollView.topAnchor.constraint(equalTo: drinkImageView.bottomAnchor),
        backgroundScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        backgroundScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        backgroundScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        
        drinkTitleLabel.bottomAnchor.constraint(equalTo: drinkImageView.bottomAnchor, constant: -20),
        drinkTitleLabel.leadingAnchor.constraint(equalTo: drinkImageView.leadingAnchor, constant: 20),
        
        alcoholStackView.topAnchor.constraint(equalTo: drinkImageView.bottomAnchor, constant: 30),
        alcoholStackView.leadingAnchor.constraint(equalTo: backgroundScrollView.leadingAnchor, constant: 25),
        
        glassStackView.topAnchor.constraint(equalTo: drinkImageView.bottomAnchor, constant: 30),
        glassStackView.leadingAnchor.constraint(equalTo: alcoholStackView.trailingAnchor, constant: 20),
        
        recipeTextView.topAnchor.constraint(equalTo: alcoholStackView.bottomAnchor, constant: 30),
        //recipeTextView.leadingAnchor.constraint(equalTo: backgroundScrollView.leadingAnchor, constant: 25),
        //recipeTextView.trailingAnchor.constraint(equalTo: backgroundScrollView.trailingAnchor, constant: -25),
        recipeTextView.widthAnchor.constraint(equalTo: backgroundScrollView.widthAnchor, multiplier: 1)
       ])
   }
    
    private func fetchDrink() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        drinkTitleLabel.text = drink?.strDrink
        alcoholTypeLabel.text = "No"
        if drink?.strAlcoholic == "Alcoholic" {
            alcoholTypeLabel.text = "Yes"
        }
        
        glassTypeLabel.text = drink?.strGlass
        recipeTextView.text = drink?.strInstructions
        
        self.drinkImageView.kf.setImage(with: URL(string: drink!.strDrinkThumb)) { _ in
            self.activityIndicator.stopAnimating()
        }
    }
}

extension DetailViewController: UIScrollViewDelegate {
    
    // Horizontal scroll lock
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
                scrollView.contentOffset.x = 0
            }
    }
}
