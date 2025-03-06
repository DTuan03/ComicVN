//
//  CategoryViewController.swift
//  ComicVN
//
//  Created by Tuấn on 28/2/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class CategoryViewController: BaseViewController {
    lazy var navigationView = {
        NavigationViewFactory.createMainNavigationView(leftImage: UIImage(named: "menu"), title: "topic", right1Image: UIImage(named: "add"), right2Image: UIImage(named: "search"), delegate: self)

    }()
    lazy var categoryCV = CollectionViewFactory.create2ColumCollectionView(scrollDirection: .horizontal, minimumInteritemSpacing: 31, padding: 51, left: 10, right: 10, height: 55)
    
    private let viewModel = CategoryViewModel()
    
    override func setupUI() {
        view.addSubviews([navigationView, categoryCV])
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        }
        categoryCV.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(39)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(43)
        }
        categoryCV.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        categoryCV.delegate = self
        categoryCV.dataSource = self
    }
    
    private func bindViewModels() {
        viewModel.itemsCategory
            .subscribe(onNext: { [weak self] newItems in
                guard let self = self else {return}
                self.categoryCV.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

extension CategoryViewController: NavigationViewDelegate {
    func didTapLeftButton(in view: UIView) {
        let menuVC = MenuViewController()
        menuVC.modalPresentationStyle = .overFullScreen
        self.present(menuVC, animated: false, completion: nil)
    }
    
    func didTapRightAddButton(in view: UIView) {
        let addVC = AddViewController()
        navigationController?.pushViewController(addVC, animated: true)
    }
}

extension CategoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.itemsCategory.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else {
            return UICollectionViewCell()
        }
        let model = viewModel.itemsCategory.value[indexPath.item]
        cell.configData(with: model, indexPath: indexPath)
        cell.indexPath = indexPath
        cell.delegate =  self
        return cell
    }
}

extension CategoryViewController: UICollectionViewDelegate {
}

extension CategoryViewController: CategoryDelegateCell {
    func didTapCell(index: IndexPath) {
        let detailCategoryVC = DetailCategoryViewController()
        detailCategoryVC.categoryName = viewModel.getNameCategory(indexPath: index)
        navigationController?.pushViewController(detailCategoryVC, animated: true)
    }
}
