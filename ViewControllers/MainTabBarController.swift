//
//  MainTabBarController.swift
//  Just2Drink
//
//  Created by Alexander Kovzhut on 10.01.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor = .white
        self.tabBar.isTranslucent = false
        self.tabBar.backgroundColor = .purple
        self.tabBar.addTopBorder()
        UITabBar.appearance().barTintColor = .purple
        
        let firstTabBarView = DrinksCollectionViewController()
        let secondTabBarView = DrinksTableViewController()
        
        viewControllers = [
            createNavigationController(
                rootViewController: firstTabBarView,
                title: "Collection",
                image: UIImage(systemName: "c.circle")!,
                selectedImage: UIImage(systemName: "c.circle.fill")!
            ),
            createNavigationController(
                rootViewController: secondTabBarView,
                title: "Table",
                image: UIImage(systemName: "t.circle")!,
                selectedImage: UIImage(systemName: "t.circle.fill")!
            )
        ]
    }
    
    private func createNavigationController(rootViewController: UIViewController, title: String, image: UIImage, selectedImage: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.selectedImage = selectedImage
        
        return navigationVC
    }
}

    // MARK: - Top border of tap bar
extension UITabBar {
    internal func addTopBorder(height: CGFloat = 1.0) {
        let borderView = UIView()
        borderView.backgroundColor = .green
        borderView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(borderView)
        NSLayoutConstraint.activate(
            [
                borderView.leadingAnchor.constraint(equalTo: leadingAnchor),
                borderView.trailingAnchor.constraint(equalTo: trailingAnchor),
                borderView.topAnchor.constraint(equalTo: topAnchor),
                borderView.heightAnchor.constraint(equalToConstant: height)
            ]
        )
    }
}
