//
//  FilterCell.swift
//  ComicVN
//
//  Created by Tuấn on 13/3/25.
//
import UIKit
import SnapKit

protocol FilterDelegateCell: AnyObject {
    func didFilterTapCell(indexPath: IndexPath)
}

class FilterCell: UITableViewCell {
    static let identifier = "FilterCell"
    weak var delegate: FilterDelegateCell?
    var indexPath: IndexPath?
    
    let label = LabelFactory.createLabel(text: "Comic", font: .medium12, textColor: .textPrimaryColor, numberOfLines: 1)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func cellTapped() {
        if let indexPath = indexPath {
            delegate?.didFilterTapCell(indexPath: indexPath)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(5)
        }
    }
    
    func configData(with model: FilterModel) {
        label.text = model.category
    }
}
