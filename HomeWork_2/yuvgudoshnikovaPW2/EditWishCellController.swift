//
//  EditWishCellController.swift
//  yuvgudoshnikovaPW2
//
//  Created by Юлия Гудошникова on 16.11.2023.
//

import Foundation
import UIKit

final class EditWishCellController: UIViewController, UITextViewDelegate {

    let wishTextView: UITextView = UITextView()
    private let addButton: UIButton =  UIButton()
    var editWish: ((String) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        wishTextView.delegate = self
        wishTextView.font = .systemFont(ofSize: 20, weight: .regular)
        wishTextView.textColor = .tertiaryLabel
        wishTextView.backgroundColor = .systemGray5
        wishTextView.setHeight(200)
        wishTextView.setWidth(400)
        wishTextView.textColor = UIColor.black

         //Конфигурация кнопки
        addButton.setTitle("Edit wish", for: .normal)
        addButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        addButton.setHeight(40)
        addButton.setWidth(400)
        addButton.backgroundColor = .systemIndigo
        addButton.layer.cornerRadius = 20
        
        let stackView = UIStackView(arrangedSubviews: [wishTextView, addButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fill
        stackView.alignment = .center
        
        view.addSubview(stackView)
        stackView.pinLeft(to: view, 16)
        stackView.pinRight(to: view, 16)
        stackView.pinTop(to: view, 16)
        stackView.pinBottom(to: view, 16)
        stackView.clipsToBounds = true
        stackView.backgroundColor = .systemGray5
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    @objc private func editButtonTapped() {
        guard let text = wishTextView.text, !text.isEmpty else { return }
        editWish?(text)
        self.dismiss(animated: true)
    }
    
}
