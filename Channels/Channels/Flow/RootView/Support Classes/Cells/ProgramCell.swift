//
//  ProgramCell.swift
//  Channels
//
//  Created by kolinko oleksandr on 06.02.2023.
//

import UIKit

final class ProgramCell: UICollectionViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: SectionHeader.self)
    }
    
    // - Private Properties
    private lazy var headlineLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: label.font.fontName, size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: label.font.fontName, size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .cyan
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
        
        self.setUpLabelsAndConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUpLabelsAndConstraints()
    }
    
    func configure(with program: Program) {
        self.headlineLabel.text = program.getDate()
        self.bodyLabel.text = program.name
    }
    
    private func setUpLabelsAndConstraints() {
 
        self.addSubview(bodyLabel)
        self.addSubview(headlineLabel)

        headlineLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        headlineLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        
        bodyLabel.leadingAnchor.constraint(equalTo: headlineLabel.leadingAnchor).isActive = true
        bodyLabel.trailingAnchor.constraint(equalTo: headlineLabel.trailingAnchor).isActive = true

        headlineLabel.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: contentView.layoutMarginsGuide.topAnchor, multiplier: 1).isActive = true
        
        contentView.layoutMarginsGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: bodyLabel.lastBaselineAnchor, multiplier: 1).isActive = true
        
        bodyLabel.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: headlineLabel.lastBaselineAnchor, multiplier: 1).isActive = true
    }
}
