//
//  TabBarController.swift
//  Pico
//
//  Created by 최하늘 on 2023/09/25.
//

import UIKit
import SnapKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
        addShadowToTabBar()
        UITabBar.appearance().backgroundColor = .systemBackground
        UITabBar.appearance().tintColor = .picoBlue
        NotificationService.shared.registerRemoteNotification()
    }
    
    private func configureTabBar() {
        let homeViewController = UINavigationController(rootViewController: HomeViewController())
        let mailViewController = UINavigationController(rootViewController: MailViewController())
        let likeViewController = UINavigationController(rootViewController: LikeViewController())
        let entViewController = UINavigationController(rootViewController: EntViewController())
        let mypageViewController = UINavigationController(rootViewController: MypageViewController())
        
        homeViewController.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house.fill"), tag: 0)
        mailViewController.tabBarItem = UITabBarItem(title: "메일", image: UIImage(systemName: "envelope.fill"), tag: 1)
        likeViewController.tabBarItem = UITabBarItem(title: "좋아요", image: UIImage(systemName: "heart.fill"), tag: 2)
        entViewController.tabBarItem = UITabBarItem(title: "게임", image: UIImage(systemName: "gamecontroller.fill"), tag: 3)
        mypageViewController.tabBarItem = UITabBarItem(title: "마이", image: UIImage(systemName: "person.fill"), tag: 4)
        
        homeViewController.navigationBar.prefersLargeTitles = false
        mailViewController.navigationBar.prefersLargeTitles = false
        likeViewController.navigationBar.prefersLargeTitles = false
        entViewController.navigationBar.prefersLargeTitles = false
        mypageViewController.navigationBar.prefersLargeTitles = false
        
        self.viewControllers = [homeViewController, mailViewController, likeViewController, entViewController, mypageViewController]
        delegate = self
    }
    
    private func addShadowToTabBar() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowColor = UIColor.clear
        appearance.backgroundColor = .systemBackground
        tabBar.standardAppearance = appearance
        tabBar.tintColor = .picoBlue
        tabBar.layer.masksToBounds = false
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.2
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 6
    }
}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomTransitionAnimator(viewControllers: tabBarController.viewControllers)
    }
}
