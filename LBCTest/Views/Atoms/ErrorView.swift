//
//  ErrorView.swift
//  LBCTest
//
//  Created by Jeromin Lebon on 02/03/2023.
//

import UIKit

protocol ErrorViewDelegate: AnyObject {
    func didTapRetryButton()
}

class ErrorView: UIView {
    private var retryButton = UIButton()
    weak var delegate: ErrorViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.addSubview(retryButton)
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        let retryButtonConstraints = [
            retryButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            retryButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            retryButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.0/2.0),
            retryButton.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.0/6.0)
        ]
        NSLayoutConstraint.activate(retryButtonConstraints)
        retryButton.setTitle("Réessayer", for: .normal)
        retryButton.layer.borderWidth = 1
        retryButton.layer.borderColor = UIColor(named: "textColor")?.cgColor
        retryButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        retryButton.setTitleColor(UIColor(named: "textColor"), for: .normal)
        retryButton.addTarget(self, action: #selector(didTapRetryButton), for: .touchUpInside)
    }

    @objc private func didTapRetryButton() {
        delegate?.didTapRetryButton()
    }
}
