//
//  WrittenWishCell.swift
//  yuvgudoshnikovaPW2
//
//  Created by Юлия Гудошникова on 15.11.2023.
//

import UIKit

final class WrittenWishCell: UITableViewCell {
    static let reuseId: String = "WrittenWishCell"
    
    private enum Constants {
        static let wrapColor: UIColor = .systemGray5
        static let wrapRadius: CGFloat = 16
        static let wrapOffsetV: CGFloat = 5
        static let wrapOffsetH: CGFloat = 10
        
        static let wishLabelOffset: CGFloat = 8
        static let wishLabelWidth: CGFloat = 100
        
        static let buttonWidth: CGFloat = 50
        static let buttonTitleColor:UIColor = .systemIndigo
    }
    
    var deleteWish: (() -> ())?
    var editWish: ((String) -> ())?
    
    let deleteButton = UIButton(type: .system)
    let editButton = UIButton(type: .system)
    
    private let wishLabel: UILabel = UILabel()
    let wrap: UIStackView = UIStackView()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with wish: String) {
        wishLabel.text = wish
        wishLabel.numberOfLines = 0 // Разрешаем несколько строк в метке
        wishLabel.sizeToFit()
        wishLabel.setWidth(Constants.wishLabelWidth)
    }
    
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
        addSubview(wrap)
        wrap.backgroundColor = Constants.wrapColor
        wrap.layer.cornerRadius = Constants.wrapRadius
        wrap.axis = .horizontal
        wrap.pinVertical(to: self, Constants.wrapOffsetV)
        wrap.pinHorizontal(to: self, Constants.wrapOffsetH)
        wrap.addSubview(wishLabel)
        addDeleteButton()
        addEditButton()
        configureWishLabel()
    }
    
    private func configureWishLabel() {
        wishLabel.pinVertical(to: wrap, Constants.wishLabelOffset)
        wishLabel.pinLeft(to: wrap, Constants.wishLabelOffset)
        wishLabel.pinRight(to: editButton.leadingAnchor, Constants.wishLabelOffset)
    }
        
    private func addDeleteButton() {
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        deleteButton.isEnabled = true
        wrap.addSubview(deleteButton)
        deleteButton.pinRight(to: wrap, Constants.wishLabelOffset)
        deleteButton.pinVertical(to: wrap, Constants.wishLabelOffset)
        deleteButton.setWidth(Constants.buttonWidth)
        deleteButton.setTitleColor(Constants.buttonTitleColor, for: .normal)
    }
    private func addEditButton() {
        editButton.setTitle("Edit", for: .normal)
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        editButton.isEnabled = true
        wrap.addSubview(editButton)
        editButton.pinRight(to: deleteButton.leadingAnchor, Constants.wishLabelOffset)
        editButton.pinVertical(to: wrap, Constants.wishLabelOffset)
        editButton.setWidth(Constants.buttonWidth)
        editButton.setTitleColor(Constants.buttonTitleColor, for: .normal)
    }
        
    @objc private func deleteButtonTapped() {
        deleteWish?()
    }
    @objc private func editButtonTapped() {
        editWish?(wishLabel.text!)
    }
}
