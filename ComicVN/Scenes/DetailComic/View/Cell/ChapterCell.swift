//
//  ChapterCell.swift
//  ComicVN
//
//  Created by Tuấn on 10/3/25.
//

import UIKit
import SnapKit

protocol ChapterCellDelegate: AnyObject {
    func didTapChapter(indexPath: IndexPath)
}

class ChapterCell: UITableViewCell {
    static let identifier = "ChapterCell"
    
    weak var delegate: ChapterCellDelegate?
    var indexPath: IndexPath?
    
    lazy var titleLabel = LabelFactory.createLabel(font: .semiBold16, textColor: .black)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        self.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func cellTapped() {
        if let indexPath = indexPath {
            delegate?.didTapChapter(indexPath: indexPath)
        }
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
