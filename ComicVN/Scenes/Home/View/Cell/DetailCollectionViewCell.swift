//
//  DetailCollectionViewCell.swift
//  ComicVN
//
//  Created by Tuấn on 26/2/25.
//

import UIKit
import SnapKit
import Cosmos

class DetailCollectionViewCell: UICollectionViewCell {
    static let identifier = "DetailCell"
    
    let avatarImageView = ImageViewFactory.createImageView(contentMode: .scaleToFill)
    let nameLabel = LabelFactory.createLabel(font: UIFont.medium14, textColor: .black, textAlignment: .left)
    let authorLabel = LabelFactory.createLabel(font: UIFont.regular12, textColor: .black, textAlignment: .left)
    let categoryLabel = LabelFactory.createLabel(font: UIFont.regular12, textColor: .black, textAlignment: .left)
    let viewsLabel = LabelFactory.createLabel(font: UIFont.regular12, textColor: .black, textAlignment: .left)
    let cosmosView = CosmosViewFactory.createCosmosView(starSize: 16, starMargin: 4)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = UIColor(hex: "#FF7B00", alpha: 0.11)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        let stackView = [authorLabel, categoryLabel, viewsLabel].vStack(3)
        contentView.addSubviews([avatarImageView, nameLabel, cosmosView, stackView])
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(13)
            make.left.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-13)
            make.width.equalTo(90)
            make.height.equalTo(138)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(19)
            make.left.equalTo(avatarImageView.snp.right).offset(17)
            make.right.equalToSuperview()
            make.height.equalTo(18)
        }
        
        cosmosView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.left.equalTo(avatarImageView.snp.right).offset(17)
            make.right.equalToSuperview()
        }
    
        stackView.snp.makeConstraints { make in
            make.top.equalTo(cosmosView.snp.bottom).offset(8)
            make.left.equalTo(avatarImageView.snp.right).offset(17)
            make.right.equalToSuperview().offset(-60)
        }
    }
    
    func configData(with detail: DetailModel) {
        avatarImageView.image = detail.image
        nameLabel.text = detail.name ?? ""
        cosmosView.rating = detail.rating ?? 4
        authorLabel.text = "Tác giả: \(detail.author ?? "Đang cậo nhật")"
        categoryLabel.text = "Thể loại: \(detail.category ?? "Đang cập nhật")"
        viewsLabel.text = "Lượt xem: \(detail.views ?? "0")"
    }
}
