//
//  SongCollectionViewCell.swift
//  SoundBooth
//
//  Created by user on 2020/10/03.
//

import UIKit
import SnapKit
import Ikemen

class SongCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView() ※ {
        $0.backgroundColor = .systemGroupedBackground
        $0.layer.borderWidth = 1.0 / UIScreen.main.scale
        $0.layer.borderColor = UIColor.systemGray.cgColor
        $0.layer.cornerRadius = 4
        $0.layer.cornerCurve = .continuous
    }
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        addSubview(imageView)
        addSubview(label)
        imageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.width.equalTo(imageView.snp.height)
        }
        label.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(8)
        }
    }
}
