//
//  RankingViewController.swift
//  ComicVN
//
//  Created by Tuấn on 1/3/25.
//
import UIKit
import RxSwift
import RxCocoa

class BookmarkViewController: BaseViewController {
    var viewModel = BookmarkViewModel()
    lazy var navigationView = {
        NavigationViewFactory.createMainNavigationView(leftImage: UIImage(named: "menu"),
                                                       title: "bookmark",
                                                       right1Image: UIImage(named: "add"),
                                                       right2Image: UIImage(named: "search"),
                                                       delegate: self)
    }()
    let titleLabel = LabelFactory.createLabel(text: "savedComics",
                                              font: UIFont.medium18,
                                              textColor: UIColor(hex: "#FF7B00"))
    let deleteButton = ButtonFactory.createButton("deleteBookmark",
                                                  font: UIFont.medium14,
                                                  textColor: .black,
                                                  bgColor: UIColor(hex: "#C4C4C4"),
                                                  rounded: false)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(BookmarkCell.self, forCellReuseIdentifier: BookmarkCell.identifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.isScrollEnabled = true
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        return tableView
    }()
    
    override func setupUI() {
        view.addSubviews([navigationView, titleLabel, deleteButton, tableView])
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(32)
            make.left.equalToSuperview().offset(18)
            make.right.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(24)
            make.right.equalToSuperview().inset(17)
            make.width.equalTo(130)
            make.height.equalTo(40)
        }
        deleteButton.layer.cornerRadius = 20
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(deleteButton.snp.bottom).offset(2)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(26)
            make.bottom.equalToSuperview()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func bindState() {
        viewModel.itemsBookmark
            .subscribe(onNext: { [weak self] newItems in
                guard let self = self else {return}
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    override func setupEvent() {
        deleteButton.addTarget(self, action: #selector(deleteBtnAction), for: .touchUpInside)
    }
    
    @objc func deleteBtnAction() {
        let popUpVC = CustomPopupViewController()
        popUpVC.configure(onOk: {
            self.viewModel.itemsBookmark.accept([])
            print(self.viewModel.itemsBookmark.value.count)
        })
        popUpVC.modalPresentationStyle = .overCurrentContext
        self.present(popUpVC, animated: false, completion: nil)
    }
}

extension BookmarkViewController: NavigationViewDelegate {
    func didTapLeftButton(in view: UIView) {
        let menuVC = MenuViewController()
        menuVC.modalPresentationStyle = .overFullScreen
        self.present(menuVC, animated: false, completion: nil)
    }
}


extension BookmarkViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemsBookmark.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookmarkCell.identifier, for: indexPath) as? BookmarkCell else {
            return UITableViewCell()
        }
        
        let model = viewModel.itemsBookmark.value[indexPath.row]
        cell.containerView.backgroundColor = UIColor(hex: "#FF7B00", alpha: 0.11)
        cell.configData(with: model)
        return cell
    }
}

extension BookmarkViewController: UITableViewDelegate {
    
}
