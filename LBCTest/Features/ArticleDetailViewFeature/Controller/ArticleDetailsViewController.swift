//
//  ArticleDetailsViewController.swift
//  LBCTest
//
//  Created by Jeromin Lebon on 27/02/2023.
//

import UIKit

class ArticleDetailsViewController: UIViewController {
    let scrollView = UIScrollView()
    let contentView = UIView()
    let imageArticleView = UIImageView()
    let titleLabel = UILabel()
    let priceLabel = UILabel()
    let categoryLabel = UILabel()
    let descriptionSectionLabel = UILabel()
    let descriptionLabel = UILabel()
    let dateLabel = UILabel()
    let siretLabel = UILabel()
    let badge = BadgeIconView()

    private let viewModel: ArticleDetailsViewModel
    @Injected(\.imageLoaderRepository) var imageLoaderRepository: ImageLoaderRepositoryProtocol

    init(with viewModel: ArticleDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }

    private func setupUI() {
        setupScrollView()
        setupImageArticleView()
        setupBadgeIconView()
        setupTitleLabel()
        setupCategoryLabel()
        setupPriceLabel()
        setupDateLabel()
        setupSiretLabel()
        setupDescriptionSectionLabel()
        setupDescriptionLabel()
        bindingViewModel()
    }

    private func bindingViewModel() {
        titleLabel.text = viewModel.articleUIModel.title
        categoryLabel.text = viewModel.articleUIModel.categoryName
        priceLabel.text = viewModel.articleUIModel.formattedPrice
        dateLabel.text = viewModel.articleUIModel.formattedCreationDate
        descriptionLabel.text = viewModel.articleUIModel.description
        badge.isHidden = !(viewModel.articleUIModel.isUrgent ?? true)
        siretLabel.text = viewModel.articleUIModel.siret

        viewModel.didFetchImageClosure = { [weak self] imageData in
            if let imageData = imageData {
                self?.imageArticleView.image = UIImage(data: imageData)
            } else {
                self?.imageArticleView.image = UIImage(named: "placeholder")
            }
        }
    }

    @MainActor
    private func setArticleImage(with url: String?) async {
        do {
            let imageData = try await imageLoaderRepository.getImage(with: url)
            if let imageData = imageData {
                imageArticleView.image = UIImage(data: imageData)
            }
        } catch {
            imageArticleView.image = nil
        }
    }
}


// MARK: - Setup UI
private extension ArticleDetailsViewController {
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        let scrollViewConstraints = [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]

        let contentViewConstraints = [
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ]
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(contentViewConstraints)
    }

    func setupImageArticleView() {
        contentView.addSubview(imageArticleView)
        imageArticleView.translatesAutoresizingMaskIntoConstraints = false
        let imageArticleViewConstraints = [
            imageArticleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageArticleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            imageArticleView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imageArticleView.heightAnchor.constraint(equalTo: imageArticleView.widthAnchor, multiplier: 2/3)
        ]
        NSLayoutConstraint.activate(imageArticleViewConstraints)
        imageArticleView.contentMode = .scaleAspectFit
    }

    func setupBadgeIconView() {
        contentView.addSubview(badge)
        badge.translatesAutoresizingMaskIntoConstraints = false
        let badgeConstraints = [
            badge.trailingAnchor.constraint(equalTo: imageArticleView.trailingAnchor, constant: -16),
            badge.topAnchor.constraint(equalTo: imageArticleView.topAnchor, constant: 16)
        ]
        NSLayoutConstraint.activate(badgeConstraints)
        badge.configure(with: "URGENT")
    }

    func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: imageArticleView.bottomAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24)
        ]
        NSLayoutConstraint.activate(titleLabelConstraints)

        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
    }

    func setupCategoryLabel() {
        contentView.addSubview(categoryLabel)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        let categoryLabelConstraints = [
            categoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            categoryLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
        ]
        NSLayoutConstraint.activate(categoryLabelConstraints)

        categoryLabel.font = .systemFont(ofSize: 14, weight: .medium)
        categoryLabel.textColor = .lightGray
    }

    func setupPriceLabel() {
        contentView.addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        let priceLabelConstraints = [
            priceLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
        ]
        NSLayoutConstraint.activate(priceLabelConstraints)

        priceLabel.font = .systemFont(ofSize: 14, weight: .bold)
    }

    func setupDateLabel() {
        contentView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        let dateLabelConstraints = [
            dateLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
        ]
        NSLayoutConstraint.activate(dateLabelConstraints)

        dateLabel.font = .systemFont(ofSize: 14, weight: .medium)
    }

    func setupSiretLabel() {
        contentView.addSubview(siretLabel)
        siretLabel.translatesAutoresizingMaskIntoConstraints = false
        let siretLabelConstraints = [
            siretLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            siretLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            siretLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ]
        NSLayoutConstraint.activate(siretLabelConstraints)
        siretLabel.font = .systemFont(ofSize: 14, weight: .medium)
    }

    func setupDescriptionSectionLabel() {
        contentView.addSubview(descriptionSectionLabel)
        descriptionSectionLabel.translatesAutoresizingMaskIntoConstraints = false
        let descriptionSectionLabelConstraints = [
            descriptionSectionLabel.topAnchor.constraint(equalTo: siretLabel.bottomAnchor, constant: 24),
            descriptionSectionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionSectionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ]
        NSLayoutConstraint.activate(descriptionSectionLabelConstraints)

        descriptionSectionLabel.font = .systemFont(ofSize: 24, weight: .bold)
        descriptionSectionLabel.text = "Description"
    }

    func setupDescriptionLabel() {
        contentView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 0
        let descriptionLabelConstraints = [
            descriptionLabel.topAnchor.constraint(equalTo: descriptionSectionLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(descriptionLabelConstraints)

        descriptionLabel.font = .systemFont(ofSize: 14, weight: .regular)
    }
}
