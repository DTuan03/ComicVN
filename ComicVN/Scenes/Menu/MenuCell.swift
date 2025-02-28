//
//  MenuCell.swift
//  ComicVN
//
//  Created by Tuấn on 27/2/25.
//

import UIKit
import SnapKit

class MenuCell: UITableViewCell {
    static let identifier = "MenuCell"
    
    private let iconImageView = ImageViewFactory.createImageView(tintColor: .black)
    private let titleLabel = LabelFactory.createLabel(font: .medium18, textColor: .black)
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        containerView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
            make.left.equalToSuperview().offset(15)
        }
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(iconImageView.snp.right).offset(40)
            make.centerY.equalToSuperview()
        }
    }
    
    func configData(with menuItem: MenuItem) {
        titleLabel.text = menuItem.title
        iconImageView.image = UIImage(systemName: menuItem.iconName)
        containerView.backgroundColor = menuItem.isSelected ? UIColor(hex: "#72B261", alpha: 0.2) : .clear
        containerView.layer.cornerRadius = 8
    }
}
