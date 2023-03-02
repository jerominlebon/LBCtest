//
//  ArticleTableViewCell.swift
//  LBCTest
//
//  Created by Jeromin Lebon on 27/02/2023.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    static let reuseIdentifier = "ArticleTableViewCell"
    let imageArticleView = UIImageView()
    let titleLabel = UILabel()
    let categoryLabel = UILabel()
    let priceLabel = UILabel()
    let badge = BadgeIconView()

    var viewModel: ArticleTableViewCellViewModel? {
        didSet {
            titleLabel.text = viewModel?.articleUIModel.title
            categoryLabel.text = viewModel?.articleUIModel.categoryName
            priceLabel.text = viewModel?.articleUIModel.formattedPrice
            badge.isHidden = !(viewModel?.articleUIModel.isUrgent ?? true)
            bindingViewModel()
            viewModel?.fetchImage()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageArticleView.image = nil
        viewModel = nil
    }

    private func setupUI() {
        selectionStyle = .none
        setupImageArticleView()
        setupBadgeIconView()
        setupTitleLabel()
        setupCategoryLabel()
        setupPriceLabel()
    }

    private func bindingViewModel() {
        viewModel?.didFetchImageClosure = { [weak self] imageData in
            if let imageData = imageData {
                self?.imageArticleView.image = UIImage(data: imageData)
            } else {
                self?.imageArticleView.image = UIImage(named: "placeholder")
            }
        }
    }
}

//MARK: - Setup UI
private extension ArticleTableViewCell {
    func setupImageArticleView() {
        addSubview(imageArticleView)
        imageArticleView.translatesAutoresizingMaskIntoConstraints = false
        let imageArticleViewConstraints = [
            imageArticleView.widthAnchor.constraint(equalToConstant: 100),
            imageArticleView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            imageArticleView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            imageArticleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8)
        ]
        NSLayoutConstraint.activate(imageArticleViewConstraints)

        let heightConstraint = imageArticleView.heightAnchor.constraint(equalTo: imageArticleView.widthAnchor, multiplier: 1)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true

        imageArticleView.contentMode = .scaleAspectFill
        imageArticleView.clipsToBounds = true
        imageArticleView.image = UIImage(named: "placeholder")
    }

    func setupBadgeIconView() {
        addSubview(badge)
        badge.translatesAutoresizingMaskIntoConstraints = false
        let badgeConstraints = [
            badge.centerYAnchor.constraint(equalTo: imageArticleView.topAnchor, constant: 6),
            badge.centerXAnchor.constraint(equalTo: imageArticleView.trailingAnchor, constant: -12)
        ]
        NSLayoutConstraint.activate(badgeConstraints)
        badge.configure(with: "URGENT")
    }

    func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: imageArticleView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageArticleView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(titleLabelConstraints)
        titleLabel.numberOfLines = 2
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
    }

    func setupCategoryLabel() {
        addSubview(categoryLabel)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        let categoryLabelConstraints = [
            categoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            categoryLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
        ]
        NSLayoutConstraint.activate(categoryLabelConstraints)
        categoryLabel.font = .systemFont(ofSize: 14)
        categoryLabel.textColor = .lightGray
    }

    func setupPriceLabel() {
        addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        let priceLabelConstraints = [
            priceLabel.bottomAnchor.constraint(equalTo: imageArticleView.bottomAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
        ]
        NSLayoutConstraint.activate(priceLabelConstraints)
        priceLabel.font = .systemFont(ofSize: 14, weight: .bold)
    }
}
