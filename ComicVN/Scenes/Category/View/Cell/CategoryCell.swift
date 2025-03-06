//
//  CategoryCell.swift
//  ComicVN
//
//  Created by Tuấn on 28/2/25.
//

import UIKit
import SnapKit

protocol CategoryDelegateCell: AnyObject {
    func didTapCell(index: IndexPath)
}

class CategoryCell: UICollectionViewCell {
    static let identifier = "CategoryCell"
    
    weak var delegate: CategoryDelegateCell?
    var indexPath: IndexPath?

    let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        
        return view
    }()
    
    lazy var nameLabel = LabelFactory.createLabel(font: .medium18, textAlignment: .center)
    lazy var numberLabel = LabelFactory.createLabel(font: .medium12,
                                                    textColor: UIColor(hex: "#434040"),
                                                    textAlignment: .center)
    let view: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 2.5
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 5
        setupUI()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        self.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func cellTapped() {
        if let indexPath = indexPath {
            delegate?.didTapCell(index: indexPath)
        }
    }
    
    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        containerView.addSubviews([nameLabel, numberLabel, view])
        nameLabel.snp.makeConstraints { make in
            make.height.equalTo(22)
            make.top.equalToSuperview().offset(8)
            make.centerX.equalToSuperview()
        }
        numberLabel.snp.makeConstraints { make in
            make.height.equalTo(22)
            make.top.equalTo(nameLabel.snp.bottom)
            make.centerX.equalToSuperview()
        }
        view.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(-2.5)
            make.height.equalTo(30)
            make.width.equalTo(5)
        }
    }
    
    func configData(with model: CategoryModel, indexPath: IndexPath) {
        if (indexPath.item % 2 == 0) {
            nameLabel.textColor = UIColor(hex: "#2EE2A1")
            containerView.backgroundColor = UIColor(hex: "#72B261", alpha: 0.2)
            view.backgroundColor = UIColor(hex: "#2EE2A1")
        } else {
            nameLabel.textColor = UIColor(hex: "#FF7B00")
            containerView.backgroundColor = UIColor(hex: "#FF7B00", alpha: 0.5)
            view.backgroundColor = UIColor(hex: "#FF7B00")
        }
        nameLabel.text = model.name
        numberLabel.text = " \(model.number) truyện"
        
    }
}
