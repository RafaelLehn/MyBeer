//
//  BeerCollectionViewCell.swift
//  MyBeer
//
//  Created by Ana Luiza on 4/12/23.
//

import Foundation
import UIKit
import Kingfisher

protocol BeerCollectionViewCellDelegate {
    func isStarButtonTouched(indexPath: Int)
}

class BeerCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "BeerCollectionViewCell"
    
    lazy var logoImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
        view.textColor = .white
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var starButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        
        return view
    }()
    
    var movieDetail: BeerModel?
    
    var cellDelegate: BeerCollectionViewCellDelegate?
    
    var item: Int? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.contentView.addSubview(logoImage)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(starButton)
        
        starButton.addTarget(self, action: #selector(verifyFavorite), for: .touchDown)
        starButton.contentHorizontalAlignment = .fill
        starButton.contentVerticalAlignment = .fill
        logoImage.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 6),
            nameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -6),
            nameLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0),
            nameLabel.heightAnchor.constraint(equalToConstant: 50),
            
            logoImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12),
            logoImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
            logoImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0),
            logoImage.bottomAnchor.constraint(equalTo: self.nameLabel.topAnchor, constant: 0),
            
            
            starButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            starButton.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            starButton.heightAnchor.constraint(equalToConstant: 24),
            starButton.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func setCell(beer: BeerModel, image: String){
        if let url = URL(string: "\(beer.imageURL ?? "")") {
            logoImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholdertext.fill"))
            
        }
        logoImage.contentMode = .scaleAspectFit

        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)]
        let attributedString = NSMutableAttributedString(string:beer.name ?? "", attributes:attrs)
        nameLabel.attributedText = attributedString
        
        starButton.setImage(UIImage(systemName: "\(image)"), for: .normal)
    }
    
    @objc private func verifyFavorite(){
        cellDelegate?.isStarButtonTouched(indexPath: self.item!)
    }
}
