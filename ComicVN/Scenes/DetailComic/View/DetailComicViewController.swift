//
//  DetailComicViewController.swift
//  ComicVN
//
//  Created by Tuấn on 5/3/25.
//

import UIKit
import SnapKit

class DetailComicViewController: BaseViewController {
    var data: [DescribeModel] = [
        DescribeModel(title: "Lượt xem", value: "3.123.412"),
        DescribeModel(title: "Số chương", value: "25"),
        DescribeModel(title: "Tác giả", value: "Warren Ellis"),
        DescribeModel(title: "Thể loại", value: "Khoa hoc"),
        DescribeModel(title: "Trạng thái", value: "Đang cập nhật"),
        DescribeModel(title: "Tóm tắt", value: "")
    ]
    var viewModel = DetailComicViewModel()
    let userId = UserDefaults.standard.value(forKey: "userId")
    var name: String?
    var isSelected: Bool = false
    lazy var backBtn = ButtonFactory.createButton(image: .arrowLeft,
                                                  bgColor: .clear)
    lazy var followBtn = {
        let btn = ButtonFactory.createButton(image: .follow,
                                             font: .medium14,
                                             textColor: .white,
                                             bgColor: .clear)
        return btn
    }()
    
    lazy var image = {
        let image = ImageViewFactory.createImageView(image: .test,
                                                     contentMode: .scaleToFill)
        image.layer.cornerRadius = 15
        image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        image.layer.masksToBounds = true
        return image
    }()
    
    lazy var titleLabel = LabelFactory.createLabel(text: "Iron Man: Extremis",
                                                   font: .medium24,
                                                   textColor: .white)
    lazy var ratingCosmos = CosmosViewFactory.createCosmosView()
    lazy var readBtn = ButtonFactory.createButton("Đọc truyện",
                                                  font: .semiBold17,
                                                  textColor: .black,
                                                  bgColor: .white,
                                                  rounded: true)
    
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
    lazy var sortIV = ImageViewFactory.createImageView(image: .desc)
    
    lazy var ivStackView = [menuChapterIV, lineVerticalIV, sortIV].hStack(8)

    lazy var descripTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.isScrollEnabled = true
        tableView.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        tableView.register(DescribeCell.self, forCellReuseIdentifier: DescribeCell.identifier)
//        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    lazy var chapterTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.isScrollEnabled = true
        tableView.contentInset = UIEdgeInsets(top: 24, left: 11, bottom: 0, right: 11)
        tableView.register(ChapterCell.self, forCellReuseIdentifier: ChapterCell.identifier)
//        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
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
        chapterBottomLine.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom)
            make.left.equalTo(descriptionBottomLine.snp.right)
            make.height.equalTo(1)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        setupUIChapter()
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
        ivStackView.snp.makeConstraints { make in
            make.top.equalTo(descriptionBottomLine.snp.bottom).offset(8)
            make.right.equalToSuperview().inset(24)
        }
        chapterTableView.snp.makeConstraints { make in
            make.top.equalTo(updateLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    override func setupEvent() {
        backBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else {return}
            navigationController?.popViewController(animated: true)
        })
        .disposed(by: disposeBag)
    }
}

extension DetailComicViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 6
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DescribeCell.identifier, for: indexPath) as? DescribeCell else {
            return UITableViewCell()
        }
        if indexPath.section == 0 {
            cell.setupUISection1()
            let model = data[indexPath.row]
            cell.configData(model: model)
            if indexPath.row == 3 {
                cell.valueLabel.layer.cornerRadius = 17
                cell.valueLabel.textColor = UIColor(hex: "#6604A1", alpha: 0.5)
                cell.valueLabel.layer.borderColor = UIColor(hex: "#6604A1", alpha: 0.5).cgColor
                cell.valueLabel.layer.borderWidth = 1
                let labelWidth = cell.valueLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: cell.valueLabel.frame.height)).width
                cell.valueLabel.snp.makeConstraints { make in
                    make.width.equalTo(labelWidth + 20)
                }
            }
        } else {
            cell.setupUISection2()
            cell.valueLabel.text = "Phần ngoại truyện Extremis được chuyển thể trong một mini-series truyện tranh chuyển động bao gồm 6 tập có tên. Loạt phim nhỏ được tạo ra bởi Marvel Knights Animation và phát hành trên iTunes vào ngày 16 tháng 4 năm 2010."
            cell.valueLabel.textAlignment = .left
            cell.valueLabel.numberOfLines = 0
        }
        
        return cell
    }
    
    
}
