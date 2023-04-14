//
//  BeerDetailViewController.swift
//  MyBeer
//
//  Created by Ana Luiza on 4/14/23.
//

import Foundation
import UIKit
import Kingfisher

final class BeerDetailViewController: UIViewController {
    
    private lazy var logoImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var mainStackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 12
        return view
    }()
    
    private lazy var showNameLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var showYearLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var showGenreLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var showDescriptionLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    var seasonSelected = 0

    private let viewModel: BeerDetailViewModel


    init(viewModel: BeerDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupUI()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setupUI() {
        
        if let url = URL(string: "\(viewModel.beer.imageURL ?? "")") {
            logoImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholdertext.fill"))
            
        }
        logoImage.contentMode = .scaleAspectFit
        showNameLabel.text = viewModel.beer.name
        showYearLabel.text = viewModel.beer.tagline
        showGenreLabel.text = viewModel.beer.firstBrewed
        showDescriptionLabel.text = viewModel.beer.description
        
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        
        contentView.addSubview(logoImage)
        contentView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(showNameLabel)
        mainStackView.addArrangedSubview(showYearLabel)
        mainStackView.addArrangedSubview(showGenreLabel)
        mainStackView.addArrangedSubview(showDescriptionLabel)
        
        
        NSLayoutConstraint.activate([
            
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            
            logoImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 80),
            logoImage.heightAnchor.constraint(equalToConstant: 300),
            logoImage.widthAnchor.constraint(equalToConstant: 250),
            logoImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            

            mainStackView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 12),
            mainStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 12),
            mainStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -12),
            showNameLabel.heightAnchor.constraint(equalToConstant: 30),
            showYearLabel.heightAnchor.constraint(equalToConstant: 30),
            showGenreLabel.heightAnchor.constraint(equalToConstant: 30),
            
            
        ])
    }
    
    
}
