//
//  UIApplication.swift
//  CodingInterviewSample
//
//  Created by Koushik on 28/12/18.
//  Copyright © 2018 Wolken Software Pvt Ltd. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    
    class func topViewController(rootViewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        guard let rootViewController = rootViewController else {
            return nil
        }
        
        guard let presented = rootViewController.presentedViewController else {
            return rootViewController
        }
        
        switch presented {
        case let navigationController as UINavigationController:
            return topViewController(rootViewController: navigationController.viewControllers.last)
            
        case let tabBarController as UITabBarController:
            return topViewController(rootViewController: tabBarController.selectedViewController)
            
        default:
            return topViewController(rootViewController: presented)
        }
    }
}
