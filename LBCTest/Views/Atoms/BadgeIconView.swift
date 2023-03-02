//
//  BadgeIconView.swift
//  LBCTest
//
//  Created by Jeromin Lebon on 02/03/2023.
//

import UIKit

class BadgeIconView: UIView {
    private var titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.backgroundColor = .red
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4)
        ]
        NSLayoutConstraint.activate(titleLabelConstraints)
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 10, weight: .medium)

        self.layer.cornerRadius = 4
        self.clipsToBounds = true
    }

    func configure(with title: String?) {
        self.titleLabel.text = title
    }
}
