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
import QuartzCore

class HomeViewController: BaseViewController, NavigationViewDelegate {
    func didTapLeftButton(in view: UIView) {
        let menuVC = MenuViewController()
        menuVC.modalPresentationStyle = .overFullScreen
        self.present(menuVC, animated: false, completion: nil)
    }

    private var viewModel = DetailViewModel()
    
    var navigationView: UIView!
    
    let scrollView = ScrollViewFactory.createScrollView(showsVerticalScrollIndicator: true, bounces: false)
    let contentView = UIView()
    
    
    let trendingLabel = LabelFactory.createLabel(text: "Thịnh hành", font: .bold16, textColor: UIColor(hex: "#434040"))
    let newComicLabel = LabelFactory.createLabel(text: "Truyện mới cập nhật", font: .bold16, textColor: UIColor(hex: "#434040"))
    let categoryLabel = LabelFactory.createLabel(text: "DANH MỤC", font: .bold18, textColor: UIColor(hex: "#434040"))
    
    let moreOptionsImage = ImageViewFactory.createImageView(image: UIImage(named: "moreOption"))
    let moreOptionsnNewImage = ImageViewFactory.createImageView(image: UIImage(named: "moreOption"))

    let detailCollectionView = CollectionViewFactory.createCollectionView(left: 6, right: 16, width: 315, height: 165)
    let trendingCollectionView = CollectionViewFactory.createCollectionView(minimumInteritemSpacing: 8, left: 20, width: 80, height: 177)
    let newComicCollectionView = CollectionViewFactory.createCollectionView(minimumInteritemSpacing: 8, left: 20, width: 80, height: 177)
    let categoryCollectionView = CollectionViewFactory.createCollectionView(estimated: false, left: 24)
   
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModels()
    }
    
    override func setupUI() {
        navigationView = NavigationViewFactory.createNavigationView(leftImage: UIImage(named: "menu"), title: "Trang chủ", right1Image: UIImage(named: "add"), right2Image: UIImage(named: "search"), delegate: self)
        
        view.addSubview(navigationView)
        navigationView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(44)
            make.left.right.equalToSuperview()
        }
        
        view.addSubview(scrollView)
        scrollView.delegate = self
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
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
            make.height.equalTo(250)
//            make.bottom.equalToSuperview()
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
            make.height.equalTo(250)
//            make.bottom.equalToSuperview()
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
            make.height.equalTo(185)
            make.bottom.equalToSuperview().offset(-40)
        }
        categoryCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
    }

    
    private func bindViewModels() {
        
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
    
    override func setupEvent() {
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
            return viewModel.itemsTrending.value.count
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
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else {
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

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoryCollectionView {
            let widthScreen = UIScreen.main.bounds.width
            let width = (widthScreen - 74) / 2
            return CGSize(width: width, height: 84)
        }
        return CGSize(width: 0, height: 0)
    }
}
