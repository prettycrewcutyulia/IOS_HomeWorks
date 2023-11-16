//
//  EditWishCellController.swift
//  yuvgudoshnikovaPW2
//
//  Created by Юлия Гудошникова on 16.11.2023.
//

import Foundation
import UIKit

final class EditWishCellController: UIViewController, UITextViewDelegate {
    
    private enum Constants {
        static let wishTextHeight:CGFloat = 200
        static let wishTextWidth:CGFloat = 400
        static let wishTextFont:CGFloat = 20
        static let wishTextBackgroundColor:UIColor = .systemGray5
        static let wishTextColor:UIColor = .black
        
        static let editButtonHeight: CGFloat = 40
        static let editButtonWidth:CGFloat = 400
        static let editButtonCornerRadius:CGFloat = 20
        static let editButtomBackgroundColor:UIColor = .systemIndigo
        
        static let stackSpacing:CGFloat = 20
        static let stackMargins:CGFloat = 16
        static let stackBackgroundColor:UIColor = .systemGray5
    }

    let wishTextView: UITextView = UITextView()
    private let editButton: UIButton =  UIButton()
    var editWish: ((String) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        configureWishText()
        configureEditButton()
        configureStack()
    }
    
    private func configureWishText() {
        wishTextView.delegate = self
        wishTextView.font = .systemFont(ofSize: Constants.wishTextFont, weight: .regular)
        wishTextView.backgroundColor = Constants.wishTextBackgroundColor
        wishTextView.setHeight(Constants.wishTextHeight)
        wishTextView.setWidth(Constants.wishTextWidth)
        wishTextView.textColor = Constants.wishTextColor
    }
    
    private func configureEditButton(){
        //Конфигурация кнопки
       editButton.setTitle("Edit wish", for: .normal)
       editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
       editButton.setHeight(Constants.editButtonHeight)
       editButton.setWidth(Constants.editButtonWidth)
       editButton.backgroundColor = Constants.editButtomBackgroundColor
       editButton.layer.cornerRadius = Constants.editButtonCornerRadius
    }
    
    private func configureStack() {
        let stackView = UIStackView(arrangedSubviews: [wishTextView, editButton])
        stackView.axis = .vertical
        stackView.spacing = Constants.stackSpacing
        stackView.distribution = .fill
        stackView.alignment = .center
        
        view.addSubview(stackView)
        stackView.pinLeft(to: view, Constants.stackMargins)
        stackView.pinRight(to: view, Constants.stackMargins)
        stackView.pinTop(to: view, Constants.stackMargins)
        stackView.pinBottom(to: view, Constants.stackMargins)
        stackView.clipsToBounds = true
        stackView.backgroundColor = Constants.stackBackgroundColor
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: Constants.stackMargins, left: Constants.stackMargins, bottom:Constants.stackMargins, right: Constants.stackMargins)
    }
    
    @objc private func editButtonTapped() {
        guard let text = wishTextView.text, !text.isEmpty else { return }
        editWish?(text)
        self.dismiss(animated: true)
    }
    
}
