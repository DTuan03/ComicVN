//
//  ChapterCell.swift
//  ComicVN
//
//  Created by Tuấn on 10/3/25.
//

import UIKit
import SnapKit

class ChapterCell: UITableViewCell {
    static let identifier = "ChapterCell"
    
    lazy var titleLabel = LabelFactory.createLabel(font: .semiBold16, textColor: .black)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
        }
    }
    
    func configData(for model: ChapterModel) {
        titleLabel.text = "\(model.title). Chapter \(model.title)"
    }
}
