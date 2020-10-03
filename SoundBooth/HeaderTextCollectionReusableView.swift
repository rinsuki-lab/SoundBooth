//
//  HeaderTextCollectionReusableView.swift
//  SoundBooth
//
//  Created by user on 2020/10/03.
//

import UIKit
import SnapKit
import Ikemen

class HeaderTextSupplementaryView: UICollectionReusableView {
    let label = UILabel() ※ {
        $0.font = .boldSystemFont(ofSize: 20)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        addSubview(label)
        label.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalToSuperview().inset(16)
        }
    }
}
