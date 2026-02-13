//
//  MainTabBarController.swift
//  InstagramClone
//
//  Created by ENES TALHA KIR on 31.12.2025.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        tabBar.barTintColor = .systemBackground
        tabBar.tintColor = .black

        
    }
    func setupTabs() {
        // FEED
        let feedVC = FeedViewController()
        let feedNav = UINavigationController(rootViewController: feedVC)
        feedNav.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "house"), tag: 0)
        
        // UPLOAD
        let uploadVC = UploadViewController()
        let uploadNav = UINavigationController(rootViewController: uploadVC)
        uploadNav.tabBarItem = UITabBarItem(title: "Upload", image: UIImage(systemName: "plus.circle"), tag: 1)
        
        // Settings
        
        let SettingsVC = SettingsViewController()
        let settingsNav = UINavigationController(rootViewController: SettingsVC)
        settingsNav.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 2)
        
        viewControllers = [feedNav,uploadNav,settingsNav]
        
        
    }
    
    
    

    

}
