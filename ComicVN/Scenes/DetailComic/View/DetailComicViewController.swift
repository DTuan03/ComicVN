//
//  DetailComicViewController.swift
//  ComicVN
//
//  Created by Tuấn on 5/3/25.
//

import UIKit
import SnapKit
import Kingfisher

class DetailComicViewController: BaseViewController {
    var viewModel = DetailComicViewModel()
    let userId = UserDefaults.standard.value(forKey: "userId")
    var slug: String?
    var isSelected: Bool = false
    var isSort: Bool = false
    lazy var backBtn = ButtonFactory.createButton(image: .arrowLeft,
                                                  bgColor: .clear)
    lazy var followBtn = {
        let btn = ButtonFactory.createButton(font: .medium14,
                                             textColor: .white,
                                             bgColor: .clear)
        return btn
    }()
    
    lazy var image = {
        let image = ImageViewFactory.createImageView(contentMode: .scaleToFill)
        image.layer.cornerRadius = 15
        image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        image.layer.masksToBounds = true
        return image
    }()
    
    lazy var titleLabel = LabelFactory.createLabel(font: .medium24,
                                                   textColor: .white,
                                                   numberOfLines: 2)
    lazy var ratingCosmos = CosmosViewFactory.createCosmosView()
    lazy var readBtn = ButtonFactory.createButton( "Đọc truyện",
                                                  font: .semiBold17,
                                                  textColor: .black,
                                                  bgColor: .white,
                                                  rounded: true)
    
    lazy var stackView = [[titleLabel, ratingCosmos].vStack(3), readBtn].vStack(50, alignment: .center)
    
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
    
    lazy var updateLabel = {
        let label = LabelFactory.createLabel(text: "Cập nhật đến",
                                             font: .medium16,
                                             textColor: UIColor(hex: "#FF7B00"))
        return label
    }()
    
    lazy var chapterLabel = {
        let label = LabelFactory.createLabel(text: "Chương 54",
                                             font: .medium14,
                                             textColor: .black)
        return label
    }()
    
    lazy var menuChapterIV = ImageViewFactory.createImageView(image: .menuChapter)
    lazy var lineVerticalIV = ImageViewFactory.createImageView(image: .lineVertical)
    lazy var sortIV = ImageViewFactory.createImageView(image: .asc)
    
    lazy var ivStackView = [menuChapterIV, lineVerticalIV, sortIV].hStack(8)

    lazy var descripTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.isScrollEnabled = true
        tableView.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        tableView.register(DescribeCell.self, forCellReuseIdentifier: DescribeCell.identifier)
        tableView.dataSource = self
        return tableView
    }()
    
    lazy var chapterTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = true
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.register(ChapterCell.self, forCellReuseIdentifier: ChapterCell.identifier)
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let slug = slug else {return}
        guard let userId = userId as? String else {return}
        viewModel.fetchDetailComic(for: slug)
        if viewModel.checkedBookmark(userId: userId, slug: slug) {
            followBtn.setImage(.followed, for: .normal)
            isSelected = true
        } else {
            followBtn.setImage(.follow, for: .normal)
            isSelected = false
        }
        setupEvent()
    }
    
    override func setupUI() {
        view.backgroundColor = UIColor(hex: "#EAA2A2")
        view.addSubviews([backBtn, followBtn, image, stackView, containerView])
        backBtn.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.left.equalToSuperview().offset(26)
            make.width.height.equalTo(24)
        }
        
        followBtn.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.right.equalToSuperview().inset(33)
            make.width.height.equalTo(24)
        }
        
        image.snp.makeConstraints { make in
            make.top.equalTo(backBtn.snp.bottom).offset(32)
            make.left.equalToSuperview().offset(32)
            make.height.equalTo(152)
            make.width.equalTo(100)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(backBtn.snp.bottom).offset(32)
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
        chapterBottomLine.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom)
            make.left.equalTo(descriptionBottomLine.snp.right)
            make.height.equalTo(1)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
    }
    
    private func setupUIDescription() {
        containerView.addSubview(descripTableView)
        descripTableView.snp.makeConstraints { make in
            make.top.equalTo(descriptionBottomLine.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupUIChapter() {
        containerView.addSubviews([updateLabel, chapterLabel, ivStackView, chapterTableView])
        containerView.backgroundColor = .white
        updateLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionBottomLine.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(13)
            make.height.equalTo(34)
        }
        chapterLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionBottomLine.snp.bottom).offset(8)
            make.left.equalTo(updateLabel.snp.right).offset(8)
            make.height.equalTo(34)
        }
        ivStackView.backgroundColor = .white
        ivStackView.snp.makeConstraints { make in
            make.top.equalTo(descriptionBottomLine.snp.bottom).offset(8)
            make.right.equalToSuperview().inset(24)
        }
        chapterTableView.snp.makeConstraints { make in
            make.top.equalTo(updateLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(11)
            make.bottom.equalToSuperview()
        }
    }
    
    override func setupEvent() {
        backBtn.rx.tap
            .bind { [weak self] in self?.navigationController?.popViewController(animated: true) }
            .disposed(by: disposeBag)
        
        followBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else {return}
            guard let userId = userId as? String else {
                print("userId không hợp lệ")
                return
            }
            guard let slug = slug else {
                print("slug không hợp lệ")
                return
            }
            let bookmarkModel = BookmarkRealmModel()
            bookmarkModel.userId = userId
            bookmarkModel.image = viewModel.itemDetailComics.value?.image
            bookmarkModel.name = viewModel.itemDetailComics.value?.name ?? "Đang cập nhật"
            bookmarkModel.author = viewModel.itemDetailComics.value?.describe[2].value ?? "Đang cập nhật"
            bookmarkModel.category = viewModel.itemDetailComics.value?.describe[3].value ?? "Đang cập nhật"
            bookmarkModel.totalChapter = viewModel.itemDetailComics.value?.describe[1].value ?? "Đang cập nhật"
            bookmarkModel.slug = slug
            
            if isSelected {
                self.viewModel.deleteBookmarkComic(userId: userId, slug: slug)
                DispatchQueue.main.async {
                    self.followBtn.setImage(.follow, for: .normal)
                }
            } else {
                self.viewModel.saveBookmarkComic(for: bookmarkModel)
                DispatchQueue.main.async {
                    self.followBtn.setImage(.followed, for: .normal)
                }
            }
            isSelected.toggle()
        })
        .disposed(by: disposeBag)
        
        viewModel.itemDetailComics.subscribe(onNext: { [weak self] item in
            guard let self = self else {return}
            DispatchQueue.main.async {
                let url = URL(string: item?.image ?? "")
                self.image.kf.setImage(with: url)
                self.titleLabel.text = item?.name
                self.descripTableView.reloadData()
                self.chapterTableView.reloadData()
            }
        })
        .disposed(by: disposeBag)
        
        segmentedControl.rx.selectedSegmentIndex
            .subscribe(onNext: { [weak self] index in
                guard let self = self else { return }
                switch index {
                case 0:
                    setupUIDescription()
                    updateBottomLineSegment(at: 0)
                    descripTableView.isHidden = false
                case 1:
                    setupUIChapter()
                    updateBottomLineSegment(at: 1)
                    chapterLabel.text = "Chương \(viewModel.itemDetailComics.value?.chapter.count ?? 0)"
                    descripTableView.isHidden = true
                default:
                    return
                }
            })
            .disposed(by: disposeBag)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(sort))
        sortIV.addGestureRecognizer(tapGesture)
    }
    @objc func sort() {
        if isSort {
            isSort = false
            sortIV.image = .asc
            viewModel.sortAscChapter()
            chapterTableView.contentOffset = CGPoint(x: 0, y: 0)
        } else {
            isSort = true
            sortIV.image = .desc
            viewModel.sortDescChapter()
            chapterTableView.contentOffset = CGPoint(x: 0, y: 0)
        }
    }
    
    private func updateBottomLineSegment(at index: Int) {
        switch index {
        case 0:
            descriptionBottomLine.backgroundColor = UIColor(hex: "#FF7B00")
            chapterBottomLine.backgroundColor = .black
        case 1:
            descriptionBottomLine.backgroundColor = .black
            chapterBottomLine.backgroundColor = UIColor(hex: "#FF7B00")
        default:
            break
        }
    }
}

extension DetailComicViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == descripTableView {
            return viewModel.itemDetailComics.value?.describe.count ?? 0
        } else {
            return viewModel.itemDetailComics.value?.chapter.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == descripTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DescribeCell.identifier, for: indexPath) as? DescribeCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.setupUI(index: indexPath)
            guard let model = viewModel.itemDetailComics.value?.describe[indexPath.row] else {
                return UITableViewCell()
            }
            cell.configData(index: indexPath, model: model)
            if cell.titleLabel.text == "Thể loại" {
                cell.valueLabel.layer.cornerRadius = 17
                cell.valueLabel.textColor = UIColor(hex: "#6604A1", alpha: 0.5)
                cell.valueLabel.layer.borderColor = UIColor(hex: "#6604A1", alpha: 0.5).cgColor
                cell.valueLabel.layer.borderWidth = 1
                let labelWidth = cell.valueLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: cell.valueLabel.frame.height)).width
                cell.valueLabel.snp.makeConstraints { make in
                    make.width.equalTo(labelWidth + 20)
                }
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ChapterCell.identifier, for: indexPath) as? ChapterCell else {
                return UITableViewCell()
            }
            guard let model = viewModel.itemDetailComics.value?.chapter[indexPath.row] else {
                return UITableViewCell()
            }
            cell.indexPath = indexPath
            cell.delegate = self
            cell.configData(for: model)
            return cell
        }
    }
}

extension DetailComicViewController: ChapterCellDelegate {
    func didTapChapter(indexPath: IndexPath) {
        let readComicVC = ReadComicVC()
        readComicVC.chapterUrl = viewModel.itemDetailComics.value?.chapter[indexPath.row].url
        navigationController?.pushViewController(readComicVC, animated: true)
    }
}
