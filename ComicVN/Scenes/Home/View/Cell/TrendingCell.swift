//
//  TrendingCell.swift
//  ComicVN
//
//  Created by Tuấn on 26/2/25.
//
import UIKit
import SnapKit

protocol TrendingDelegateCell: AnyObject {
    func didTapTrendingCell(indexPath: IndexPath, collectionView: UICollectionView)
}

class TrendingCell: UICollectionViewCell {
    static let identifier = "TrendingCell"
    
    weak var delegate: TrendingDelegateCell?
    var indexPath: IndexPath?
    var collectionView: UICollectionView?
    
    lazy var avatarImageView = ImageViewFactory.createImageView(contentMode: .scaleAspectFill, radius: 10)
    lazy var nameLabel = LabelFactory.createLabel(font: UIFont.medium8, textColor: UIColor(hex: "#FF7B00"), textAlignment: .left)
    lazy var categoryLabel = LabelFactory.createLabel(font: UIFont.light6, textColor: UIColor(hex: "#434040"), textAlignment: .left)
    lazy var viewsLabel = LabelFactory.createLabel(font: UIFont.regular6, textColor: UIColor(hex: "#434040"), textAlignment: .left)
    lazy var cosmosView = CosmosViewFactory.createCosmosView(starSize: 8.5, starMargin: 4)
    lazy var avatarNameStackView = [avatarImageView, nameLabel].vStack(4, alignment: .fill, distribution: .fill)
    lazy var infomationStackView = [categoryLabel, cosmosView, viewsLabel].vStack(5)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor(hex: "#FFFFFF")
        setupUI()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func cellTapped() {
        if let indexPath = indexPath {
            delegate?.didTapTrendingCell(indexPath: indexPath, collectionView: collectionView ?? UICollectionView())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubviews([avatarNameStackView, infomationStackView])
        avatarNameStackView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.width.equalTo(80)
            make.bottom.equalTo(infomationStackView.snp.top)
            make.height.equalTo(138)
        }
        infomationStackView.snp.makeConstraints { make in
            make.top.equalTo(avatarNameStackView.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func configData(with detail: DetailModel) {
        avatarImageView.kf.setImage(with: detail.image)
        nameLabel.text = detail.name!
        cosmosView.rating = detail.rating ?? 0
        categoryLabel.text = "Thể loại: \(detail.category ?? "Đang cập nhật")"
        viewsLabel.text = "Lượt xem: \(detail.views ?? "Đang cập nhật")"
    }
}
