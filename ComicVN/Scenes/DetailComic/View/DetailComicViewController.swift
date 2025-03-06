//
//  DetailComicViewController.swift
//  ComicVN
//
//  Created by Tuấn on 5/3/25.
//

import UIKit
import SnapKit

class DetailComicViewController: BaseViewController {
    var viewModel = DetailComicViewModel()
    var name: String?
    lazy var backBtn = ButtonFactory.createButton(image: .arrowLeft, bgColor: .clear)
    lazy var followBtn = {
        let btn = ButtonFactory.createButton("Theo dõi", image: .follow, font: .medium14, textColor: .white, bgColor: .clear)
        btn.titleEdgeInsets = UIEdgeInsets(top: 25, left: -30, bottom: 0, right: 0)
        btn.imageEdgeInsets = UIEdgeInsets(top: -25, left: 25, bottom: 0, right: 0)
        return btn
    }()
    
    lazy var image = {
        let image = ImageViewFactory.createImageView(image: .test, contentMode: .scaleToFill)
        image.layer.cornerRadius = 15
        image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        image.layer.masksToBounds = true
        return image
    }()
    
    lazy var titleLabel = LabelFactory.createLabel(text: "Iron Man: Extremis", font: .medium24, textColor: .white)
    lazy var ratingCosmos = CosmosViewFactory.createCosmosView()
    lazy var readBtn = ButtonFactory.createButton("Đọc truyện", font: .semiBold17, textColor: .black, bgColor: .white, rounded: true)
    
    lazy var stackView = [[titleLabel, ratingCosmos].vStack(3), readBtn].vStack(60, alignment: .center)
    
    lazy var containerView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var segmentedControl: UISegmentedControl = {
        let items = ["Mô tả", "Chapter"]
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 0
        let clearImage = UIImage()
        control.setBackgroundImage(clearImage, for: .normal, barMetrics: .default)
        control.setDividerImage(clearImage, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        return control
    }()
    
    lazy var attributeSelected: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor(hex: "#FF7B00"),
        .font: UIFont.semiBold18
    ]
    
    lazy var attributeNormal: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor.black,
        .font: UIFont.medium18
    ]
    
    lazy var descriptionBottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#FF7B00")
        return view
    }()
    
    lazy var chapterBottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.itemDetailComics.accept(viewModel.mapAddModelToDetailComicModel(addModel: viewModel.getData(name: name ?? "")))
        image.image = viewModel.itemDetailComics.value.image
        titleLabel.text = viewModel.itemDetailComics.value.name
        ratingCosmos.rating = viewModel.itemDetailComics.value.rating ?? 0
    }
    
    override func setupUI() {
        view.backgroundColor = UIColor(hex: "#EAA2A2")
        view.addSubviews([backBtn, followBtn, image, stackView, containerView])
        backBtn.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.left.equalToSuperview().offset(26)
        }
        
        followBtn.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.right.equalToSuperview().inset(15)
            make.height.equalTo(50)
        }
        
        image.snp.makeConstraints { make in
            make.top.equalTo(backBtn.snp.bottom).offset(32)
            make.left.equalToSuperview().offset(32)
            make.height.equalTo(152)
            make.width.equalTo(100)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(backBtn.snp.bottom).offset(40)
            make.left.equalTo(image.snp.right).offset(24)
            make.right.equalToSuperview().inset(10)
        }
        
        titleLabel.snp.makeConstraints {make in
            make.width.equalTo(stackView.snp.width)
        }

        readBtn.layer.cornerRadius = 15
        readBtn.snp.makeConstraints { make in
            make.width.equalTo(164)
            make.height.equalTo(40)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(32)
            make.right.left.bottom.equalToSuperview()
        }
        
        containerView.addSubviews([segmentedControl, descriptionBottomLine, chapterBottomLine])
        segmentedControl.setTitleTextAttributes(attributeSelected, for: .selected)
        segmentedControl.setTitleTextAttributes(attributeNormal, for: .normal)
        segmentedControl.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(47)
        }
        descriptionBottomLine.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom)
            make.left.equalToSuperview()
            make.height.equalTo(1)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        descriptionBottomLine.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom)
            make.left.equalTo(descriptionBottomLine.snp.right)
            make.height.equalTo(1)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
    }
    
    override func setupEvent() {
        backBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else {return}
            navigationController?.popViewController(animated: true)
        })
        .disposed(by: disposeBag)
        
        followBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else {return}
           
        })
        .disposed(by: disposeBag)
    }
}
