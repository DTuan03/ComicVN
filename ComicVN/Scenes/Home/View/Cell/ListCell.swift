//
//  CategoryCell.swift
//  ComicVN
//
//  Created by Tuấn on 27/2/25.
//
import UIKit
import SnapKit

class ListCell: UICollectionViewCell {
    static let identifier = "ListCell"

    var titleLabel = LabelFactory.createLabel(font: .bold18, textColor: .white, textAlignment: .center)
    var hastagLabel = LabelFactory.createLabel(font: .regular14, textColor: .white, textAlignment: .center)
    var backgroundImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 10
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(backgroundImage)
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
