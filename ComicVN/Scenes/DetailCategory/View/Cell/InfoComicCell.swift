//
//  InfoComicCell.swift
//  ComicVN
//
//  Created by Tuấn on 28/2/25.
//

import UIKit
import SnapKit
import Cosmos

class InfoComicCell: UITableViewCell {
    static let identifier = "InfoComicCell"
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 6
        return view
    }()
    
    lazy var avartaImageView = ImageViewFactory.createImageView(contentMode: .scaleAspectFill)
    lazy var nameLabel = LabelFactory.createLabel(font: .medium14, textColor: .black, textAlignment: .left)
    lazy var cosmos = CosmosViewFactory.createCosmosView()
    lazy var authorLabel = LabelFactory.createLabel(font: .regular12, textColor: .black, textAlignment: .left)
    lazy var categoryLabel = LabelFactory.createLabel(font: .regular12, textColor: .black, textAlignment: .left)
    lazy var viewsLabel = LabelFactory.createLabel(font: .medium11, textColor: .white, textAlignment: .center)
    lazy var paddingView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 44, right: 0))
//        containerView.frame = containerView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 44, right: 0))
    }
    
    private func setupUI() {
        contentView.addSubviews([containerView, paddingView])
        containerView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        containerView.addSubviews([avartaImageView, nameLabel, cosmos, authorLabel, categoryLabel, viewsLabel])
        avartaImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(17)
            make.left.equalToSuperview().offset(13)
            make.width.equalTo(90)
            make.height.equalTo(138)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(avartaImageView.snp.right).offset(20)
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(17)
            make.height.equalTo(18)
        }
        
        cosmos.snp.makeConstraints { make in
            make.left.equalTo(avartaImageView.snp.right).offset(20)
            make.right.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.height.equalTo(18)
        }
        
        authorLabel.snp.makeConstraints { make in
            make.left.equalTo(avartaImageView.snp.right).offset(20)
            make.right.equalToSuperview()
            make.top.equalTo(cosmos.snp.bottom).offset(8)
            make.height.equalTo(18)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.left.equalTo(avartaImageView.snp.right).offset(20)
            make.right.equalToSuperview()
            make.top.equalTo(authorLabel.snp.bottom).offset(8)
            make.height.equalTo(18)
        }
        
        viewsLabel.snp.makeConstraints { make in
            make.left.equalTo(avartaImageView.snp.right).offset(20)
//            make.right.equalToSuperview()
            make.top.equalTo(categoryLabel.snp.bottom).offset(8)
            make.height.equalTo(20)
        }
        viewsLabel.backgroundColor = UIColor(hex: "#A10463", alpha: 0.5)
        viewsLabel.layer.cornerRadius = 10
        viewsLabel.layer.masksToBounds = true
        
        paddingView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(10)
        }
    }
    
    func configData(with model: InfoComicModel) {
        avartaImageView.image = model.avatar
        nameLabel.text = model.name
        cosmos.rating = model.rating ?? 0
        authorLabel.text = "Tác giả: \(model.author ?? "Đang cập nhật")"
        categoryLabel.text = "Thể loại: \(model.category ?? "Đang cập nhật")"
        viewsLabel.text = "  Lượt xem: \(model.views ?? "Đang cập nhật")   "
    }
}
