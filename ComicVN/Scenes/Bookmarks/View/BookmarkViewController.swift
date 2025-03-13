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
        tableView.backgroundColor = .backgroundColor
        tableView.dataSource = self
        
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.itemsBookmark.accept(viewModel.mapAddModelsToBookmarkModels(bookmarkModel: viewModel.getBookmark(userId: UserDefaults.standard.value(forKey: "userId") as? String ?? "")))
    }
    
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
            self.viewModel.deleteAllComic()
            self.viewModel.itemsBookmark.accept([])
        })
        popUpVC.modalPresentationStyle = .overCurrentContext
        self.present(popUpVC, animated: false, completion: nil)
    }
}

extension BookmarkViewController: NavigationViewDelegate {
    func didTapRightAddButton(in view: UIView) {
        let addVC = AddViewController()
        navigationController?.pushViewController(addVC, animated: true)
    }
    
    func didTapLeftButton(in view: UIView) {
        let menuVC = MenuViewController()
        menuVC.modalPresentationStyle = .overFullScreen
        self.present(menuVC, animated: false, completion: nil)
    }
    
    func didTapRightSearchButton(in view: UIView) {
        let searchVC = SearchViewController()
        navigationController?.pushViewController(searchVC, animated: true)
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
        cell.configData(with: model)
        cell.indexPath = indexPath
        cell.delegate = self
        return cell
    }
}

extension BookmarkViewController: BookmarkDelegateCell {
    func didTapBookmarkCell(indexPath: IndexPath) {
        let detailComicVC = DetailComicViewController()
        detailComicVC.slug = viewModel.itemsBookmark.value[indexPath.item].slug
        navigationController?.pushViewController(detailComicVC, animated: true)
    }
}
