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
    let contentView = UIView()
    
    let trendingLabel = LabelFactory.createLabel(text: "trending",
                                                 font: .bold16,
                                                 textColor: UIColor(hex: "#434040"))
    let newComicLabel = LabelFactory.createLabel(text: "newComics",
                                                 font: .bold16,
                                                 textColor: UIColor(hex: "#434040"))
    let categoryLabel = LabelFactory.createLabel(text: "category",
                                                 font: .bold18,
                                                 textColor: UIColor(hex: "#434040"))
    
    let moreOptionsImage = ImageViewFactory.createImageView(image: UIImage(named: "moreOption"))
    let moreOptionsnNewImage = ImageViewFactory.createImageView(image: UIImage(named: "moreOption"))
    
    let detailCollectionView = CollectionViewFactory.createCollectionView(left: 16,
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
        view.addSubview(navigationView)
        navigationView.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        }
        
        view.addSubview(scrollView)
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
        
        contentView.addSubview(trendingLabel)
        trendingLabel.snp.makeConstraints { make in
            make.top.equalTo(detailCollectionView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(18)
        }
        
        contentView.addSubview(moreOptionsImage)
        moreOptionsImage.snp.makeConstraints { make in
            make.top.equalTo(detailCollectionView.snp.bottom).offset(30.5)
            make.right.equalToSuperview().offset(-15)
        }
        setupTrendingCollectionView()
        
        contentView.addSubview(newComicLabel)
        newComicLabel.snp.makeConstraints { make in
            make.top.equalTo(trendingCollectionView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(18)
        }
        contentView.addSubview(moreOptionsnNewImage)
        moreOptionsnNewImage.snp.makeConstraints { make in
            make.top.equalTo(trendingCollectionView.snp.bottom).offset(30.5)
            make.right.equalToSuperview().offset(-15)
        }
        
        setupNewComicCollectionView()
        
        contentView.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(newComicCollectionView.snp.bottom).offset(34)
            make.left.equalToSuperview().offset(16)
            //            make.bottom.equalToSuperview()
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
        
        detailCollectionView.register(DetailCollectionViewCell.self, forCellWithReuseIdentifier: DetailCollectionViewCell.identifier)
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
    }
    
    override func bindState() {
        
        viewModel.itemsDetail
            .subscribe(onNext: { [weak self] newItems in
                guard let self = self else {return}
                self.detailCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel.itemsTrending
            .subscribe(onNext: { [weak self] newItems in
                guard let self = self else {return}
                self.trendingCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
        
        
        viewModel.itemsNewComic
            .subscribe(onNext: { [weak self] newItems in
                guard let self = self else {return}
                self.newComicCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel.itemsCategory
            .subscribe(onNext: { [weak self] newItems in
                guard let self = self else {return}
                self.categoryCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    override func setupEvent() {}
    
    func didTapLeftButton(in view: UIView) {
        let menuVC = MenuViewController()
        menuVC.modalPresentationStyle = .overFullScreen
        self.present(menuVC, animated: false, completion: nil)
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
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCollectionViewCell.identifier, for: indexPath) as? DetailCollectionViewCell else {
                return UICollectionViewCell()
            }
            let model =  viewModel.itemsDetail.value[indexPath.item]
            cell.configData(with: model)
            return cell
        case trendingCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingCell.identifier, for: indexPath) as? TrendingCell else {
                return UICollectionViewCell()
            }
            let model = viewModel.itemsTrending.value[indexPath.item]
            cell.configData(with: model)
            return cell
        case newComicCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingCell.identifier, for: indexPath) as? TrendingCell else {
                return UICollectionViewCell()
            }
            let model =  viewModel.itemsNewComic.value[indexPath.item]
            cell.configData(with: model)
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCell.identifier, for: indexPath) as? ListCell else {
                return UICollectionViewCell()
            }
            let model =  viewModel.itemsCategory.value[indexPath.item]
            cell.configData(with: model)
            return cell
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {
}
