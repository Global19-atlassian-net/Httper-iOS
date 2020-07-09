//
//  AppFlow.swift
//  Httper
//
//  Created by Meng Li on 2018/08/27.
//  Copyright © 2018 MuShare Group. All rights reserved.
//

import RxSwift
import RxFlow

enum AppStep: Step {
    case main
}

class AppFlow: Flow {
    
    var root: Presentable {
        return rootWindow
    }
    
    private let rootWindow: UIWindow
    
    private lazy var navigationController: UINavigationController = {
        let controller = BaseNavigationController()
        controller.view.backgroundColor = .background
        return controller
    }()
    
    init(window: UIWindow) {
        rootWindow = window
        rootWindow.backgroundColor = .white
        rootWindow.rootViewController = navigationController
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let appStep = step as? AppStep else {
            return  .none
        }
        switch appStep {
        case .main:
            let mainFlow = MainFlow()
            Flows.use(mainFlow, when: .ready) {
                self.navigationController.viewControllers = [$0]
            }
            return .flow(mainFlow, with: MainStep.start)
        }
    }
    
}
