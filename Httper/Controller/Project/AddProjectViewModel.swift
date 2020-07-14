//
//  AddProjectViewModel.swift
//  Httper
//
//  Created by Meng Li on 2019/01/10.
//  Copyright © 2019 MuShare. All rights reserved.
//

import RxSwift
import RxCocoa
import RxFlow

enum ProjectPrivilege: CaseIterable {
    case `private`
    
    var title: String {
        switch self {
        case .private:
            return R.string.localizable.add_project_privilege_private()
        }
    }
    
    var value: String {
        switch self {
        case .private:
            return "private"
        }
    }
}

class AddProjectViewModel: BaseViewModel {
    
    private let endStep: Step
    
    let projectName = BehaviorRelay<String?>(value: nil)
    let introduction = BehaviorRelay<String?>(value: nil)
    
    init(endStep: Step) {
        self.endStep = endStep
        super.init()
    }
    
    var title: Observable<String> {
        return .just(R.string.localizable.add_project_title())
    }
    
    var validate: Observable<Bool> {
        return projectName.map {
            guard let projectName = $0 else {
                return false
            }
            return !projectName.isEmpty
        }
    }
    
    func saveProject() {
        guard let projectName = self.projectName.value else {
            return
        }
        let introdution = introduction.value ?? ""
        loading.onNext(true)
        DaoManager.shared.projectDao.save(
            pname: projectName,
            privilege: ProjectPrivilege.private.value,
            introduction: introdution
        )
        SyncManager.shared.pushLocalProjects { [weak self] _ in
            guard let `self` = self else { return }
            self.loading.onNext(false)
            self.steps.accept(self.endStep)
        }
    }
    
}
