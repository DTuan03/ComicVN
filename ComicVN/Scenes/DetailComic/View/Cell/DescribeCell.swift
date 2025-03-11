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
    
    lazy var sumaryLabel = LabelFactory.createLabel(font: .regular14, textColor: .black)
    
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
    
    func setupUI(index: IndexPath) {
        contentView.addSubviews([lineView, titleLabel, valueLabel, sumaryLabel])
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
        if index.row == 6 {
            lineView.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(-36)
                make.left.equalToSuperview().offset(24)
                make.height.equalTo(1)
                make.width.equalTo(208)
            }
            sumaryLabel.snp.makeConstraints { make in
                make.top.equalTo(lineView.snp.bottom).offset(5)
                make.left.equalToSuperview().offset(24)
                make.right.equalToSuperview().inset(24)
                make.bottom.equalToSuperview()
            }
        }
        
    }
    
    func configData(index: IndexPath, model: DescribeModel) {
        if (index.row == 6) {
            sumaryLabel.text = model.value
        } else {
            titleLabel.text = model.title
            valueLabel.text = model.value
        }
    }
}
