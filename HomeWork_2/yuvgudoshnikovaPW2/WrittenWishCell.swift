//
//  WrittenWishCell.swift
//  yuvgudoshnikovaPW2
//
//  Created by Юлия Гудошникова on 15.11.2023.
//

import UIKit

protocol WrittenWishCellDelegate: AnyObject {
    func didTapEdit(cell: WrittenWishCell)
    func didTapDelete(cell: WrittenWishCell)
}

final class WrittenWishCell: UITableViewCell {
    static let reuseId: String = "WrittenWishCell"
    private enum Constants {
        static let wrapColor: UIColor = .systemGray5
        static let wrapRadius: CGFloat = 16
        static let wrapOffsetV: CGFloat = 5
        static let wrapOffsetH: CGFloat = 10
        static let wishLabelOffset: CGFloat = 8
    }
    var deleteWish: (() -> ())?
    
    weak var delegate: WrittenWishCellDelegate?
    let deleteButton = UIButton(type: .system)
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
        wishLabel.setWidth(100)
//        wishLabel.backgroundColor = .red
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
        wishLabel.pinVertical(to: wrap, Constants.wishLabelOffset)
        wishLabel.pinLeft(to: wrap, Constants.wishLabelOffset)
        wishLabel.pin(to: wrap, Constants.wishLabelOffset)

        addDeleteButton()
    }
        
    private func addDeleteButton() {
        //deleteButton.backgroundColor = .green
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        deleteButton.isEnabled = true
        deleteButton.frame = CGRect(x: frame.width - 50, y: 10, width: 40, height: 20)
        wrap.addSubview(deleteButton)
        deleteButton.pinRight(to: wrap, Constants.wishLabelOffset)
        deleteButton.pinVertical(to: wrap, Constants.wishLabelOffset)
        deleteButton.setWidth(50)
        
    }
        
        @objc private func deleteButtonTapped() {
            deleteWish?()
        }
}
