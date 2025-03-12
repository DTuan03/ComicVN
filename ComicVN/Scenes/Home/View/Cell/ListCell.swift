//
//  CategoryCell.swift
//  ComicVN
//
//  Created by Tuấn on 27/2/25.
//
import UIKit
import SnapKit

protocol ListDelegateCell: AnyObject {
    func didTapListCell(indexPath: IndexPath)
}

class ListCell: UICollectionViewCell {
    static let identifier = "ListCell"
    weak var delegate: ListDelegateCell?
    var indexPath: IndexPath?

    var titleLabel = LabelFactory.createLabel(font: .bold18, textColor: .white, textAlignment: .center)
    var hastagLabel = LabelFactory.createLabel(font: .regular14, textColor: .white, textAlignment: .center)
    var backgroundImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 10
        setupUI()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func cellTapped() {
        if let indexPath = indexPath {
            delegate?.didTapListCell(indexPath: indexPath)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(backgroundImage)
        backgroundImage.isUserInteractionEnabled = true
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
            make.centerX.equalToSuperview()
        }
        
        contentView.addSubview(hastagLabel)
        hastagLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }
    
    func configData(with model: ListModel) {
        backgroundImage.image = model.image
        titleLabel.text = model.title
        hastagLabel.text = model.hastag
    }
}
