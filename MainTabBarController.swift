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
        UITabBar.appearance().barTintColor = UIColor.black
        
        let firstVC = ViewController1()
        let secondVC = ViewController2()
        let thirdVC = ViewController()
        
        viewControllers = [
            createNavigationController(
                rootViewController: firstVC,
                title: "HOME",
                image: UIImage(systemName: "house.circle")!,
                selectedImage: UIImage(systemName: "house.circle.fill")!
            ),
            createNavigationController(
                rootViewController: secondVC,
                title: "FAVORITE",
                image: UIImage(systemName: "heart.circle")!,
                selectedImage: UIImage(systemName: "heart.circle.fill")!
            ),
            createNavigationController(
                rootViewController: thirdVC,
                title: "SEARCH",
                image: UIImage(systemName: "magnifyingglass.circle")!,
                selectedImage: UIImage(systemName: "magnifyingglass.circle.fill")!
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
