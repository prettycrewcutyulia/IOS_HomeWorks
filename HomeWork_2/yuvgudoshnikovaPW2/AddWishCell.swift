import UIKit

final class AddWishCell: UITableViewCell, UITextViewDelegate {
    static let reuseId: String = "AddWishCell"
    private enum Constants {
        static let wrapColor: UIColor = .white
        static let wrapRadius: CGFloat = 16
        static let wrapOffsetV: CGFloat = 16
        static let wrapOffsetH: CGFloat = 30
    }
    
    var addWish: ((String) -> ())?
    
    private let wishTextView: UITextView = UITextView()
    private let addButton: UIButton =  UIButton()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
           // Конфигурация текстового поля
        wishTextView.delegate = self
        wishTextView.font = .systemFont(ofSize: 14, weight: .regular)
        wishTextView.textColor = .tertiaryLabel
        wishTextView.backgroundColor = .systemGray5
        wishTextView.setHeight(200)
        wishTextView.setWidth(400)
        wishTextView.text = "Type something"
        wishTextView.textColor = UIColor.lightGray
        wishTextView.becomeFirstResponder()
        wishTextView.selectedTextRange = wishTextView.textRange(from:wishTextView.beginningOfDocument, to: wishTextView.beginningOfDocument)
        wishTextView.font = UIFont.systemFont(ofSize: 16, weight: .regular)

         //Конфигурация кнопки
        addButton.setTitle("Add new wish", for: .normal)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        addButton.setHeight(40)
        addButton.setWidth(400)
        addButton.backgroundColor = .systemIndigo
        addButton.layer.cornerRadius = 20
        
        let stackView = UIStackView(arrangedSubviews: [wishTextView, addButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fill
        stackView.alignment = .center
        
        contentView.addSubview(stackView)
        stackView.pinLeft(to: contentView, 16)
        stackView.pinRight(to: contentView, 16)
        stackView.pinTop(to: contentView, 16)
        stackView.pinBottom(to: contentView, 16)
        stackView.clipsToBounds = true
        stackView.backgroundColor = .systemGray5
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    @objc private func addButtonTapped() {
        guard let text = wishTextView.text, !text.isEmpty else { return }
        addWish?(text)
        wishTextView.text = "" // Очистить поле после добавления желания
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.textColor == UIColor.lightGray {
                textView.text = nil
                textView.textColor = UIColor.black
            }
        }
}
