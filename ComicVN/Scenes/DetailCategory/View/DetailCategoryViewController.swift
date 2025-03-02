//
//  DetailCategoryViewController.swift
//  ComicVN
//
//  Created by Tuấn on 28/2/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class DetailCategoryViewController: BaseViewController {
    let viewModel = InfoComicViewModel()
    var navigationView: UIView!
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(InfoComicCell.self, forCellReuseIdentifier: InfoComicCell.identifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.isScrollEnabled = true
        tableView.contentInset = UIEdgeInsets(top: 38, left: 0, bottom: 0, right: 0)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupUI() {
        navigationView = NavigationViewFactory.createSecondNavigationView(leftImage: UIImage.arrowLeft, titleButton: "Siêu Anh Hùng", delegate: self)
        view.addSubviews([navigationView, tableView])
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.left.right.equalToSuperview().inset(39)
            make.bottom.equalToSuperview()
        }
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func bindState() {
        viewModel.itemsInfoComic
            .subscribe(onNext: { [weak self] newItems in
                guard let self = self else {return}
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

extension DetailCategoryViewController: NavigationViewDelegate {
    func didTapLeftButton(in view: UIView) {
        let menuVC = MenuViewController()
        menuVC.modalPresentationStyle = .overFullScreen
        self.present(menuVC, animated: false, completion: nil)
    }
}

extension DetailCategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemsInfoComic.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoComicCell.identifier, for: indexPath) as? InfoComicCell else { return UITableViewCell()
        }
        let model = viewModel.itemsInfoComic.value[indexPath.item]
        cell.configData(with: model)
        return cell
    }
}

extension DetailCategoryViewController: UITableViewDelegate {
    
}
