//
//  BaseRouter.swift
//  YandexMaps
//
//  Created by MIkkyMouse on 22.08.2020.
//  Copyright © 2020 Ivan Sosnovich. All rights reserved.
//

import UIKit

class BaseRouter: NSObject {
    
    private var controller: UIViewController
    
    required init(controller: UIViewController) {
        self.controller = controller
    }
    
    func show(_ controller: UIViewController) {
        controller.navigationItem.title = ""
        self.controller.show(controller, sender: nil)
        removeBackWord()
    }
    
    func present(_ controller: UIViewController) {
        controller.navigationItem.title = ""
        self.controller.present(controller, animated: true)
    }
    
    func presentFromLeft(_ controller: UIViewController, completion: (() -> Void)? = nil) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        controller.modalPresentationStyle = .fullScreen
        self.controller.view.window?.layer.add(transition, forKey: kCATransition)
        self.controller.present(controller, animated: false, completion: completion)
    }
    
    
    private func removeBackWord() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        controller.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    
}
