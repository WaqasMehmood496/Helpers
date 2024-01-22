//
//  RoundedTabbarView.swift
//  kacific-ios
//
//  Created by Mapple.pk on 02/12/2021.
//

import UIKit
import PTCardTabBar

class RoundedTabbarView: PTCardTabBarController {

    let vc1 = UIViewController()
    let vc2 = UIViewController()
    let vc3 = UIViewController()
    let vc4 = UIViewController()
    let vc5 = UIViewController()
    
    override func viewDidLoad() {
        setupTabbarControllers()
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupTopMenuBar()
    }
    
}


//MARK: - HELPING METHOD'S
extension RoundedTabbarView {
    
    func setupTabbarControllers() {
        vc1.title = "Tab1"
        vc2.title = "Tab2"
        vc3.title = "Tab3"
        vc4.title = "Tab4"
        vc5.title = "Tab5"
        
        vc1.view.backgroundColor = .green
        vc2.view.backgroundColor = .brown
        vc3.view.backgroundColor = .yellow
        vc4.view.backgroundColor = .cyan
        vc5.view.backgroundColor = .gray
        
        vc1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), tag: 1)
        vc1.tabBarItem.selectedImage = UIImage(named: "homeHilight")
        vc2.tabBarItem = UITabBarItem(title: "Billing", image: UIImage(named: "Biling"), tag: 2)
        vc2.tabBarItem.selectedImage = UIImage(named: "bilingHilight")
        vc3.tabBarItem = UITabBarItem(title: "Update Plan", image: UIImage(named: "UpdatePlan"), tag: 3)
        vc3.tabBarItem.selectedImage = UIImage(named: "UpdatePlanHilight")
        vc4.tabBarItem = UITabBarItem(title: "FAQ's & Cov", image: UIImage(named: "FAQ"), tag: 4)
        vc4.tabBarItem.selectedImage = UIImage(named: "FAQHilight")
        vc5.tabBarItem = UITabBarItem(title: "Contact Us    ", image: UIImage(named: "contactUs"), tag: 5)
        vc5.tabBarItem.selectedImage = UIImage(named: "contactUsHilight")
        
        self.viewControllers = [vc1, vc2, vc3, vc4, vc5]
    }
    
    func setupTopMenuBar() {
        tabBar.frame.size.height = tabBar.frame.size.height + 100
        let topBar = TopBar()
        topBar.frame = self.navigationController!.navigationBar.frame
        topBar.frame.size.height = self.navigationController!.navigationBar.frame.size.height + 10
        self.view.addSubview(topBar)
    }
}
 
