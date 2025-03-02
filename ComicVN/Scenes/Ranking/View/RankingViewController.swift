//
//  RankingViewController.swift
//  ComicVN
//
//  Created by Tuấn on 1/3/25.
//
import UIKit
import RxSwift
import RxCocoa

class RankingViewController: BaseViewController {
    var viewModel = RankingViewModel()
    var navigationView = UIView()
    let titleLabel = LabelFactory.createLabel(text: "Truyện được đọc nhiều nhất trong \n tháng", font: UIFont.medium18, textColor: UIColor(hex: "#FF7B00"), textAlignment: .left)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(InfoComicCell.self, forCellReuseIdentifier: InfoComicCell.identifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.isScrollEnabled = true
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupUI() {
        navigationView = NavigationViewFactory.createMainNavigationView(leftImage: UIImage(named: "menu"), title: "Xếp hạng", right1Image: UIImage(named: "add"), right2Image: UIImage(named: "search"), delegate: self)
        view.addSubviews([navigationView, titleLabel, tableView])
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(17)
            make.left.equalToSuperview().offset(18)
            make.right.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(1)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(26)
            make.bottom.equalToSuperview()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func bindState() {
        viewModel.itemsRanking
            .subscribe(onNext: { [weak self] newItems in
                guard let self = self else {return}
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

extension RankingViewController: NavigationViewDelegate {
    func didTapLeftButton(in view: UIView) {
        let menuVC = MenuViewController()
        menuVC.modalPresentationStyle = .overFullScreen
        self.present(menuVC, animated: false, completion: nil)
    }
}

extension RankingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemsRanking.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoComicCell.identifier, for: indexPath) as? InfoComicCell else {
            return UITableViewCell()
        }
        
        let model = viewModel.itemsRanking.value[indexPath.row]
        cell.containerView.backgroundColor = UIColor(hex: "#FF7B00", alpha: 0.11)
        cell.configData(with: model)
        return cell
    }
}

extension RankingViewController: UITableViewDelegate {
    
}
