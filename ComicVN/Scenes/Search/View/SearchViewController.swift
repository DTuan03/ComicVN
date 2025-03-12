//
//  SearchViewController.swift
//  ComicVN
//
//  Created by Tuấn on 12/3/25.
//

import UIKit

class SearchViewController: BaseViewController, NavigationViewDelegate {
    func didTapRightSearchButton(in view: UIView) {
        print("df")
    }
    
    func didTapLeftButton(in view: UIView) {
        navigationController?.popViewController(animated: true)
    }
    
    func didTapRightAddButton(in view: UIView) {
        print("s")
    }
    let viewModel = SearchViewModel()
    lazy var navigationView = NavigationViewFactory.createSecondNavigationView(leftImage: .arrowLeft, titleButton: "Tìm kiếm truyện", delegate: self)
    
    lazy var searchTextField = {
        let tf = TextFieldFactory.createTextField(placeholder: "Tìm kiếm", font: .medium16, bgColor: .white, rounded: true)
        tf.imageLeftView(image: "search")
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor(hex: "#979797").cgColor
        return tf
    }()
    
    lazy var segmentedControl = {
        let segment = UISegmentedControl(items: ["Thể loại", "Tất cả ▾"])
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.medium18
        ]
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.medium18
        ]
        segment.selectedSegmentIndex = 0
        segment.setTitleTextAttributes(normalAttributes, for: .normal)
        segment.setTitleTextAttributes(selectedAttributes, for: .selected)
        segment.selectedSegmentTintColor = UIColor(hex: "#FF7B00")
        segment.isUserInteractionEnabled = true
        return segment
    }()
    
    lazy var resultLabel = LabelFactory.createLabel(text: "Kết quả tìm kiếm", font: .medium18, textColor: .black)
    
    lazy var resultTableView = {
        let tableView = UITableView()
        tableView.register(ResultCell.self, forCellReuseIdentifier: ResultCell.identifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.isScrollEnabled = true
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        tableView.dataSource = self        
        return tableView
    }()
    
    override func setupUI() {
        view.addSubviews([navigationView, searchTextField, segmentedControl, resultLabel, resultTableView])
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        }
        
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(18)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(18)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(175)
            make.height.equalTo(32)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(20)
        }
        
        resultTableView.snp.makeConstraints { make in
            make.top.equalTo(resultLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().offset(20)
        }
        
    }
    
    override func setupEvent() {
        segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        
        searchTextField.rx.text
            .orEmpty
            .subscribe(onNext: { text in
                self.viewModel.fetchItems(for: text)
            })
            .disposed(by: disposeBag)
    }
    
    @objc func segmentChanged(_ sender: UISegmentedControl) {
        sender.selectedSegmentIndex = 0
        print("Selected Segment Index: \(sender.selectedSegmentIndex)")
    }
    
    override func bindState() {
        viewModel.itemsSearch
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else {return}
                self.resultTableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemsSearch.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ResultCell.identifier, for: indexPath) as? ResultCell else {
            return UITableViewCell()
        }
        let model = viewModel.itemsSearch.value[indexPath.row]
        cell.configData(with: model)
        cell.indexPath = indexPath
        cell.delegate = self
        return cell
    }
}

extension SearchViewController: ResultDelegateCell {
    func didResultTapCell(indexPath: IndexPath) {
        let detailComicVC = DetailComicViewController()
        detailComicVC.slug = viewModel.itemsSearch.value[indexPath.item].slug
        navigationController?.pushViewController(detailComicVC, animated: true)
    }
}
