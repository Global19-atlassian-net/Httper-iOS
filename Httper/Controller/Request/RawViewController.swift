//
//  RowViewController.swift
//  Httper
//
//  Created by Meng Li on 09/12/2016.
//  Copyright © 2016 MuShare Group. All rights reserved.
//

import RxSwift
import MGFormatter

fileprivate struct Const {
    static let margin = 5
}

class RawViewController: BaseViewController<RawViewModel> {
    
    private lazy var rawView = FormatterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(rawView)
        createConstrants()
        viewModel.text.observeOn(MainScheduler.instance).subscribe(onNext: { [unowned self] in
            self.rawView.format(string: $0, style: .noneDark)
        }).disposed(by: disposeBag)
    }
 
    private func createConstrants() {
        rawView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(Const.margin)
            $0.right.equalToSuperview().offset(Const.margin)
            $0.top.bottom.equalToSuperview()
        }
    }
}
