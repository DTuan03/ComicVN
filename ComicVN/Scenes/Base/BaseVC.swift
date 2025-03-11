//
//  BaseVC.swift
//  ComicVN
//
//  Created by Tuấn on 26/2/25.
//

import UIKit
import RxSwift
import SnapKit

class BaseViewController: UIViewController {
    var disposeBag = DisposeBag()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.navigationController?.isNavigationBarHidden = true
        addDismissKeyboard()
        setupUI()
        setupEvent()
        setupData()
        bindState()
    }
    
    func setupUI() {
    }
    
    func setupEvent() {
    }
    
    func setupData() {
    }
    
    func bindState() {
    }
}
