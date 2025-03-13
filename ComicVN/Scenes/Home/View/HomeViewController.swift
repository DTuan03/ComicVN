//
//  HomeViewController.swift
//  ComicVN
//
//  Created by Tuấn on 26/2/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class HomeViewController: BaseViewController, NavigationViewDelegate {
    private var viewModel = DetailViewModel()
    
    lazy var navigationView = {
        NavigationViewFactory.createMainNavigationView(leftImage: UIImage(named: "menu"), title: "home", right1Image: UIImage(named: "add"), right2Image: UIImage(named: "search"), delegate: self)
    }()
    let scrollView = ScrollViewFactory.createScrollView(showsVerticalScrollIndicator: true,
                                                        bounces: false)
    lazy var contentView = {
        let view = UIView()
        view.backgroundColor = .backgroundColor
        return view
    }()
    
    let trendingLabel = LabelFactory.createLabel(text: "trending",
                                                 font: .bold16,
                                                 textColor: .textSecondaryColor)
    let newComicLabel = LabelFactory.createLabel(text: "newComics",
                                                 font: .bold16,
                                                 textColor: .textSecondaryColor)
    let categoryLabel = LabelFactory.createLabel(text: "category",
                                                 font: .bold18,
                                                 textColor: .textSecondaryColor)
    
    let moreOptionsImage = ImageViewFactory.createImageView(image: UIImage(named: "moreOption"))
    let moreOptionsnNewImage = ImageViewFactory.createImageView(image: UIImage(named: "moreOption"))
    
    let detailCollectionView = CollectionViewFactory.createCollectionView(estimated: false,
                                                                          left: 16,
                                                                          right: 16)
    let trendingCollectionView = CollectionViewFactory.createCollectionView(minimumInteritemSpacing: 8,
                                                                            left: 20)
    let newComicCollectionView = CollectionViewFactory.createCollectionView(minimumInteritemSpacing: 8,
                                                                            left: 20)
    let categoryCollectionView = CollectionViewFactory.create2ColumCollectionView(minimumInteritemSpacing: 26,
                                                                                  padding: 74,
                                                                                  left: 24,
                                                                                  right: 24,
                                                                                height: 84)
    override func setupUI() {
        view.addSubviews([navigationView, scrollView])
        navigationView.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        }
        
        scrollView.delegate = self
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(1)
            make.left.right.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
        }
        
        setupDetailCollectionView()
        
        contentView.addSubviews([trendingLabel, moreOptionsImage, newComicLabel, moreOptionsnNewImage, categoryLabel])
        trendingLabel.snp.makeConstraints { make in
            make.top.equalTo(detailCollectionView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(18)
        }
        
        moreOptionsImage.snp.makeConstraints { make in
            make.top.equalTo(detailCollectionView.snp.bottom).offset(30.5)
            make.right.equalToSuperview().offset(-15)
        }
        
        setupTrendingCollectionView()
        
        newComicLabel.snp.makeConstraints { make in
            make.top.equalTo(trendingCollectionView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(18)
        }

        moreOptionsnNewImage.snp.makeConstraints { make in
            make.top.equalTo(trendingCollectionView.snp.bottom).offset(30.5)
            make.right.equalToSuperview().offset(-15)
        }
        
        setupNewComicCollectionView()
    
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(newComicCollectionView.snp.bottom).offset(34)
            make.left.equalToSuperview().offset(16)
        }
        
        setupCategoryCollectionView()
    }
    
    private func setupDetailCollectionView() {
        contentView.addSubview(detailCollectionView)
        detailCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.right.equalToSuperview()
            make.height.greaterThanOrEqualTo(200)
        }
        detailCollectionView.register(DetailCell.self, forCellWithReuseIdentifier: DetailCell.identifier)
        detailCollectionView.dataSource = self
        detailCollectionView.delegate = self
    }
    
    private func setupTrendingCollectionView() {
        contentView.addSubview(trendingCollectionView)
        trendingCollectionView.snp.makeConstraints { make in
            make.top.equalTo(trendingLabel.snp.bottom).offset(5)
            make.left.right.equalToSuperview()
            make.height.equalTo(200)
        }
        
        trendingCollectionView.register(TrendingCell.self, forCellWithReuseIdentifier: TrendingCell.identifier)
        trendingCollectionView.dataSource = self
        trendingCollectionView.delegate = self
    }
    
    private func setupNewComicCollectionView() {
        contentView.addSubview(newComicCollectionView)
        newComicCollectionView.snp.makeConstraints { make in
            make.top.equalTo(newComicLabel.snp.bottom).offset(5)
            make.left.right.equalToSuperview()
            make.height.equalTo(200)
        }
        newComicCollectionView.register(TrendingCell.self, forCellWithReuseIdentifier: TrendingCell.identifier)
        newComicCollectionView.dataSource = self
        newComicCollectionView.delegate = self
    }
    
    private func setupCategoryCollectionView() {
        contentView.addSubview(categoryCollectionView)
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(17)
            make.left.right.equalToSuperview()
            make.height.greaterThanOrEqualTo(185)
            make.bottom.equalToSuperview().offset(-40)
        }
        categoryCollectionView.register(ListCell.self, forCellWithReuseIdentifier: ListCell.identifier)
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.isUserInteractionEnabled = true
    }
    
    override func bindState() {
        viewModel.itemsDetail
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else {return}
                self.detailCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel.itemsTrending
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else {return}
                self.trendingCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
        
        
        viewModel.itemsNewComic
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else {return}
                self.newComicCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel.itemsCategory
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else {return}
                self.categoryCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }
        
    func didTapLeftButton(in view: UIView) {
        let menuVC = MenuViewController()
        menuVC.modalPresentationStyle = .overFullScreen
        self.present(menuVC, animated: false, completion: nil)
    }
    
    func didTapRightAddButton(in view: UIView) {
        let addVC = AddViewController()
        navigationController?.pushViewController(addVC, animated: true)
    }
    
    func didTapRightSearchButton(in view: UIView) {
        let searchVC = SearchViewController()
        navigationController?.pushViewController(searchVC, animated: true)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case detailCollectionView:
            return viewModel.itemsDetail.value.count
        case trendingCollectionView:
            return viewModel.itemsTrending.value.count
        case newComicCollectionView:
            return viewModel.itemsNewComic.value.count
        default:
            return viewModel.itemsCategory.value.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case detailCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCell.identifier, for: indexPath) as? DetailCell else {
                return UICollectionViewCell()
            }
            let model =  viewModel.itemsDetail.value[indexPath.item]
            cell.configData(with: model)
            cell.indexPath = indexPath
            cell.delegate = self
            return cell
        case trendingCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingCell.identifier, for: indexPath) as? TrendingCell else {
                return UICollectionViewCell()
            }
            let model = viewModel.itemsTrending.value[indexPath.item]
            cell.configData(with: model)
            cell.indexPath = indexPath
            cell.collectionView = trendingCollectionView
            cell.delegate = self
            return cell
        case newComicCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingCell.identifier, for: indexPath) as? TrendingCell else {
                return UICollectionViewCell()
            }
            let model =  viewModel.itemsNewComic.value[indexPath.item]
            cell.configData(with: model)
            cell.indexPath = indexPath
            cell.collectionView = newComicCollectionView
            cell.delegate = self
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCell.identifier, for: indexPath) as? ListCell else {
                return UICollectionViewCell()
            }
            let model =  viewModel.itemsCategory.value[indexPath.item]
            cell.configData(with: model)
            cell.indexPath = indexPath
            cell.delegate = self
            return cell
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {
}

extension HomeViewController: DetailDelegateCell, TrendingDelegateCell, ListDelegateCell {
    func didTapTrendingCell(indexPath: IndexPath, collectionView: UICollectionView) {
        if collectionView == trendingCollectionView {
            let detailComicVC = DetailComicViewController()
            detailComicVC.slug = viewModel.itemsTrending.value[indexPath.item].slug
            navigationController?.pushViewController(detailComicVC, animated: true)
        } else {
            let detailComicVC = DetailComicViewController()
            detailComicVC.slug = viewModel.itemsNewComic.value[indexPath.item].slug
            navigationController?.pushViewController(detailComicVC, animated: true)
        }
    }
    
    func didTapDetailCell(indexPath: IndexPath) {
        let detailComicVC = DetailComicViewController()
        detailComicVC.slug = viewModel.itemsDetail.value[indexPath.item].slug
        navigationController?.pushViewController(detailComicVC, animated: true)
    }
    
    func didTapListCell(indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            UserDefaults.standard.set(2, forKey: "selectedRowMenu")
            let topComicVC = TopComicViewController()
            navigationController?.pushViewController(topComicVC, animated: true)
        case 1:
            UserDefaults.standard.set(3, forKey: "selectedRowMenu")
            let rankingVC = RankingViewController()
            navigationController?.pushViewController(rankingVC, animated: true)
        case 2:
            UserDefaults.standard.set(1, forKey: "selectedRowMenu")
            let categoryVC = CategoryViewController()
            navigationController?.pushViewController(categoryVC, animated: true)
        case 3:
            UserDefaults.standard.set(4, forKey: "selectedRowMenu")
            let bookmarkVC = BookmarkViewController()
            navigationController?.pushViewController(bookmarkVC, animated: true)
        default:
            UserDefaults.standard.set(4, forKey: "selectedRowMenu")
            let bookmarkVC = BookmarkViewController()
            navigationController?.pushViewController(bookmarkVC, animated: true)
        }
    }
}
