//
//  TopComicViewController.swift
//  ComicVN
//
//  Created by Tuấn on 1/3/25.
//
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class TopComicViewController: BaseViewController {
    let viewModel = TopComicViewModel()
    
    var navigationView = UIView()
    
    let attributeSelected: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor(hex: "#FF7B00"),
        .font: UIFont.semiBold18
    ]
    
    let attributeNormal: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor.black,
        .font: UIFont.medium18
    ]
    
    
    let segmentedControl: UISegmentedControl = {
        let items = ["Top tuần", "Top tháng", "Top đánh giá"]
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 0
        //        control.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        let clearImage = UIImage()
        control.setBackgroundImage(clearImage, for: .normal, barMetrics: .default)
        control.setDividerImage(clearImage, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        return control
    }()
    
    let weakBottomLine = UIView()
    let monthBottomLine = UIView()
    let reviewBottomLine = UIView()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(InfoComicCell.self, forCellReuseIdentifier: InfoComicCell.identifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.isScrollEnabled = true
        tableView.contentInset = UIEdgeInsets(top: -2, left: 0, bottom: 0, right: 0)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupUI() {
        navigationView = NavigationViewFactory.createMainNavigationView(leftImage: UIImage(named: "menu"), title: "Top truyện", right1Image: UIImage(named: "add"), right2Image: UIImage(named: "search"), delegate: self)
        view.addSubviews([navigationView, segmentedControl, weakBottomLine, monthBottomLine, reviewBottomLine, tableView])
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        }
        segmentedControl.setTitleTextAttributes(attributeSelected, for: .selected)
        segmentedControl.setTitleTextAttributes(attributeNormal, for: .normal)
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(47)
        }
        weakBottomLine.backgroundColor = UIColor(hex: "#FF7B00")
        weakBottomLine.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom)
            make.left.equalToSuperview()
            make.height.equalTo(1)
            make.width.equalToSuperview().multipliedBy(0.34)
        }
        monthBottomLine.backgroundColor = .black
        monthBottomLine.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom)
            make.left.equalTo(weakBottomLine.snp.right)
            make.height.equalTo(1)
            make.width.equalToSuperview().multipliedBy(0.33)
        }
        reviewBottomLine.backgroundColor = .black
        reviewBottomLine.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom)
            make.left.equalTo(monthBottomLine.snp.right)
            make.height.equalTo(1)
            make.width.equalToSuperview().multipliedBy(0.33)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(reviewBottomLine.snp.bottom)
            make.left.right.equalToSuperview().inset(39)
            make.bottom.equalToSuperview()
        }
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func setupEvent() {
        //        segmentedControl.addTarget(self, action: #selector(segmentChanged(_ :)), for: .valueChanged)
        segmentedControl.rx.selectedSegmentIndex
            .bind(to: viewModel.selectedSegment)
            .disposed(by: disposeBag)
    }
    
    override func bindState() {
        viewModel.items
            .subscribe(onNext: { [weak self] newItems in
                guard let self = self else {return}
                self.updateBottomLineSegment(at: newItems.0)
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    private func updateBottomLineSegment(at index: Int) {
        switch index {
        case 0:
            weakBottomLine.backgroundColor = UIColor(hex: "#FF7B00")
            monthBottomLine.backgroundColor = .black
            reviewBottomLine.backgroundColor = .black
        case 1:
            weakBottomLine.backgroundColor = .black
            monthBottomLine.backgroundColor = UIColor(hex: "#FF7B00")
            reviewBottomLine.backgroundColor = .black
        case 2:
            weakBottomLine.backgroundColor = .black
            monthBottomLine.backgroundColor = .black
            reviewBottomLine.backgroundColor = UIColor(hex: "#FF7B00")
        default:
            break
        }
    }
}

extension TopComicViewController: NavigationViewDelegate {
    func didTapLeftButton(in view: UIView) {
        let menuVC = MenuViewController()
        menuVC.modalPresentationStyle = .overFullScreen
        self.present(menuVC, animated: false, completion: nil)
    }
}

extension TopComicViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.value.1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoComicCell.identifier, for: indexPath) as? InfoComicCell else { return UITableViewCell()
        }
        let model = viewModel.items.value.1[indexPath.item]
        cell.configData(with: model)
        
        return cell
    }
}

extension TopComicViewController: UITableViewDelegate {
    
}
