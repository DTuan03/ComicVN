//
//  DescribeCell.swift
//  ComicVN
//
//  Created by Tuấn on 10/3/25.
//

import UIKit
import SnapKit

class DescribeCell: UITableViewCell {
    static let identifier = "DescribeCell"
    
    lazy var titleLabel = LabelFactory.createLabel(font: .semiBold16, textColor: .black)
    
    lazy var valueLabel = LabelFactory.createLabel(font: .regular14, textColor: .black, textAlignment: .center)
    
    lazy var lineView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#DCDBDB")
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUISection1() {
        contentView.addSubviews([titleLabel, valueLabel])
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(34)
            make.width.equalTo(80)
        }
        valueLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(titleLabel.snp.right).offset(40)
            make.height.equalTo(34)
        }
    }
    
    func setupUISection2() {
        contentView.addSubviews([lineView, valueLabel])
        lineView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(1)
            make.width.equalTo(208)
        }
        valueLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().inset(24)
//            make.height.equalTo(34)
        }
    }
    
    func configData(model: DescribeModel) {
        titleLabel.text = model.title
        valueLabel.text = model.value
    }
}
