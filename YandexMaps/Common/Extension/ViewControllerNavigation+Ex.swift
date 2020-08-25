//
//  ViewControllerNavigation+Ex.swift
//  YandexMaps
//
//  Created by MIkkyMouse on 22.08.2020.
//  Copyright © 2020 Ivan Sosnovich. All rights reserved.
//

import UIKit

// Протокол для объектов, имеющих идентификатор в сториборде
protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

enum NavigationBarState {
    case hide
    case onlyBackButton
    case show
}

extension UIViewController {
    
    func configureNavigationBar(state: NavigationBarState) {
        switch state {
        case .hide:
            self.navigationController?.navigationBar.isHidden = true
        
        case .show:
            self.navigationController?.navigationBar.isHidden = false
        
        case .onlyBackButton:
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.navigationBar.topItem?.title = ""
        }
    }
}

extension UINavigationController {
    
    ///Get previous view controller of the navigation stack
    func previousViewController() -> UIViewController? {
        
        let lenght = self.viewControllers.count
        
        let previousViewController: UIViewController? = lenght >= 2 ? self.viewControllers[lenght-2] : nil
        
        return previousViewController
    }
    
    /// Override для использования насктроек статусбара из контроллера, отображаемого на экране
    override open var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
    
}

// Расширение UIViewController,
// которое даёт совместимость с протоколом StoryboardIdentifiable
extension UIViewController: StoryboardIdentifiable { }

// Расширение протокола StoryboardIdentifiable для UIViewController,
// создающее идентификатор в сториборде, равный названию класса контроллера
extension StoryboardIdentifiable where Self: UIViewController {
    
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

extension UIStoryboard {
    
    func instantiateViewController<T: UIViewController>(_: T.Type) -> T {
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("View controller с идентификатором \(T.storyboardIdentifier) не найден")
        }
        
        return viewController
    }
    
    func instantiateViewController<T: UIViewController>() -> T {
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("View controller с идентификатором \(T.storyboardIdentifier) не найден")
        }
        
        return viewController
    }
}
