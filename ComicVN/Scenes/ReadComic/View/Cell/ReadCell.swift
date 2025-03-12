//
//  ReadCell.swift
//  ComicVN
//
//  Created by Tuấn on 10/3/25.
//

import UIKit
import SnapKit
import Kingfisher

class ReadCell: UICollectionViewCell {
    static let identifier = "ReadCell"
    
    let imageView = ImageViewFactory.createImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    func setupUI() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configData(at indexPath: IndexPath, with read: ReadComicModel) {
        let url = URL(string: read.image[indexPath.row])
        imageView.kf.setImage(with: url)
    }
}
