//
//  BookmarksCell.swift
//  ComicVN
//
//  Created by Tuấn on 2/3/25.
//


import UIKit
import SnapKit
import Cosmos

class BookmarkCell: UITableViewCell {
    static let identifier = "BookmarkCell"
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 6
        return view
    }()
    
    lazy var avartaImageView = ImageViewFactory.createImageView()
    lazy var nameLabel = LabelFactory.createLabel(font: .medium14, textColor: .black, textAlignment: .left)
    lazy var authorLabel = LabelFactory.createLabel(font: .regular12, textColor: .black, textAlignment: .left)
    lazy var categoryLabel = LabelFactory.createLabel(font: .regular12, textColor: .black, textAlignment: .left)
    lazy var totalChapterLabel = LabelFactory.createLabel(font: .medium11, textColor: .black, textAlignment: .center)
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
        
    }
    
    private func setupUI() {
        contentView.addSubviews([containerView, paddingView])
        containerView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        containerView.addSubviews([avartaImageView, nameLabel, authorLabel, categoryLabel, totalChapterLabel])
        avartaImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(17)
            make.left.equalToSuperview().offset(13)
            make.width.equalTo(65)
            make.height.equalTo(100)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(avartaImageView.snp.right).offset(25)
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(21)
            make.height.equalTo(18)
        }
        
        authorLabel.snp.makeConstraints { make in
            make.left.equalTo(avartaImageView.snp.right).offset(25)
            make.right.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.height.equalTo(18)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.left.equalTo(avartaImageView.snp.right).offset(25)
            make.right.equalToSuperview()
            make.top.equalTo(authorLabel.snp.bottom).offset(3)
            make.height.equalTo(18)
        }
        
        totalChapterLabel.snp.makeConstraints { make in
            make.left.equalTo(avartaImageView.snp.right).offset(25)
//            make.right.equalToSuperview()
            make.top.equalTo(categoryLabel.snp.bottom).offset(2)
            make.height.equalTo(18)
        }
        
        paddingView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(16)
        }
    }
    
    func configData(with model: BookmarkModel) {
        avartaImageView.image = model.avatar
        nameLabel.text = model.name
        authorLabel.text = "Tác giả: \(model.author)"
        categoryLabel.text = "Thể loại: \(model.category)"
        totalChapterLabel.text = "Tổng số chương: \(model.totalChapter)"
    }
}
