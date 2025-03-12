//
//  ReadComicVC.swift
//  ComicVN
//
//  Created by Tuấn on 10/3/25.
//

import UIKit
import SnapKit

class ReadComicVC: BaseViewController {
    let viewModel = ReadComicViewModel()
    var chapterUrl: String?
    lazy var topView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#4C4A4A")
        return view
    }()
    lazy var backBtn = ButtonFactory.createButton(image: .back, bgColor: .clear)
    lazy var chapterLabel = LabelFactory.createLabel(font: .medium14, textColor: .white)
    lazy var shareBtn = ButtonFactory.createButton(image: .share, bgColor: .clear)
    lazy var errorBtn = ButtonFactory.createButton(image: .error, bgColor: .clear)
    lazy var menuBtn = ButtonFactory.createButton(image: .menuReadComic, bgColor: .clear)
    lazy var stackView = [shareBtn, errorBtn, menuBtn].hStack(8)
    lazy var bottomView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#4C4A4A")
        return view
    }()
    lazy var redingLabel = LabelFactory.createLabel(font: .medium14, textColor: .white)
    
    lazy var collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(ReadCell.self, forCellWithReuseIdentifier: ReadCell.identifier)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchTopComics(for: chapterUrl ?? "")
    }
    
    override func setupUI() {
        view.backgroundColor = UIColor(hex: "#4C4A4A")
        view.addSubviews(topView, bottomView, collectionView)
        topView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
            make.height.equalTo(45)
        }
        topView.addSubviews(backBtn, chapterLabel, stackView)
        backBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(12)
        }
        chapterLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(backBtn.snp.right).offset(13)
            make.height.equalTo(34)
        }
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(8)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.top)
        }
        
        bottomView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(45)
        }
    }
    
    override func setupEvent() {
        backBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else {return}
            navigationController?.popViewController(animated: true)
        })
        .disposed(by: disposeBag)
    }
    
    override func bindState() {
        viewModel.items
            .subscribe(onNext: { [weak self] newItems in
                guard let self = self else {return}
                self.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

extension ReadComicVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.value.image.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReadCell.identifier, for: indexPath) as? ReadCell else {
            return UICollectionViewCell()
        }
        cell.configData(at: indexPath, with: viewModel.items.value)
        return cell
    }
}

extension ReadComicVC: UICollectionViewDelegate {
}
