//
//  TrendingCell.swift
//  ComicVN
//
//  Created by Tuấn on 26/2/25.
//
import UIKit
import SnapKit

class TrendingCell: UICollectionViewCell {
    static let identifier = "TrendingCell"
    
    let avatarImageView = ImageViewFactory.createImageView(contentMode: .scaleAspectFill, radius: 10)
    let nameLabel = LabelFactory.createLabel(font: UIFont.medium12, textColor: UIColor(hex: "#FF7B00"), textAlignment: .left)
    let categoryLabel = LabelFactory.createLabel(font: UIFont.light10, textColor: UIColor(hex: "#434040"), textAlignment: .left)
    let viewsLabel = LabelFactory.createLabel(font: UIFont.regular10, textColor: UIColor(hex: "#434040"), textAlignment: .left)
    let cosmosView = CosmosViewFactory.createCosmosView(starSize: 16, starMargin: 2)

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor(hex: "#FFFFFF")
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        let avatarNameStackView = [avatarImageView, nameLabel].vStack(4, alignment: .fill, distribution: .fill)
        contentView.addSubview(avatarNameStackView)
        avatarNameStackView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        let infomationStackView = [categoryLabel, cosmosView, viewsLabel].vStack(5)
        contentView.addSubview(infomationStackView)
        infomationStackView.snp.makeConstraints { make in
            make.top.equalTo(avatarNameStackView.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func configData(with detail: DetailModel) {
        avatarImageView.image = detail.image
        nameLabel.text = detail.name!
        cosmosView.rating = detail.rating ?? 0
        categoryLabel.text = "Thể loại: \(String(describing: detail.category!))"
        viewsLabel.text = "Lượt xem: \(String(describing: detail.views!))"
        print(detail)
    }
}
