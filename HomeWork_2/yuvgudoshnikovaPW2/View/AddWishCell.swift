import UIKit

final class AddWishCell: UITableViewCell, UITextViewDelegate {
    static let reuseId: String = "AddWishCell"
    
    private enum Constants {
        static let wrapColor: UIColor = .white
        static let wrapRadius: CGFloat = 16
        static let wrapOffsetV: CGFloat = 16
        static let wrapOffsetH: CGFloat = 30
        
        static let wishTextHeight:CGFloat = 200
        static let wishTextWidth:CGFloat = 400
        static let wishTextFont:CGFloat = 16
        static let wishTextPlaceholder: String = "Type something"
        static let wishTextPlaceholderColor:UIColor = UIColor.lightGray
        static let wishTextBackgroundColor:UIColor = .systemGray5
        static let wishTextColor:UIColor = .black
        
        static let addButtonHeight: CGFloat = 40
        static let addButtonWidth:CGFloat = 400
        static let addButtonCornerRadius:CGFloat = 20
        static let addButtomBackgroundColor:UIColor = .systemIndigo
        
        static let stackSpacing:CGFloat = 20
        static let stackMargins:CGFloat = 16
        static let stackBackgroundColor:UIColor = .systemGray5
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
        configureWishTextView()
        configureAddButton()
        configureStackView()
    }
    
    private func configureWishTextView() {
        wishTextView.delegate = self
        wishTextView.font = .systemFont(ofSize: Constants.wishTextFont, weight: .regular)
        wishTextView.backgroundColor = Constants.wishTextBackgroundColor
        wishTextView.setHeight(Constants.wishTextHeight)
        wishTextView.setWidth(Constants.wishTextWidth)
        wishTextView.text = Constants.wishTextPlaceholder
        wishTextView.textColor = Constants.wishTextPlaceholderColor
        wishTextView.becomeFirstResponder()
        wishTextView.selectedTextRange = wishTextView.textRange(from:wishTextView.beginningOfDocument, to:wishTextView.beginningOfDocument)
    }
    
    private func configureAddButton() {
        addButton.setTitle("Add new wish", for: .normal)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        addButton.setHeight(Constants.addButtonHeight)
        addButton.setWidth(Constants.addButtonWidth)
        addButton.backgroundColor = Constants.addButtomBackgroundColor
        addButton.layer.cornerRadius = Constants.addButtonCornerRadius
    }
    
    private func configureStackView() {
        let stackView = UIStackView(arrangedSubviews: [wishTextView, addButton])
        stackView.axis = .vertical
        stackView.spacing = Constants.stackSpacing
        stackView.distribution = .fill
        stackView.alignment = .center
        
        contentView.addSubview(stackView)
        stackView.pinLeft(to: contentView, Constants.stackMargins)
        stackView.pinRight(to: contentView, Constants.stackMargins)
        stackView.pinTop(to: contentView, Constants.stackMargins)
        stackView.pinBottom(to: contentView, Constants.stackMargins)
        stackView.clipsToBounds = true
        stackView.backgroundColor = Constants.stackBackgroundColor
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: Constants.stackMargins, left: Constants.stackMargins, bottom: Constants.stackMargins, right: Constants.stackMargins)
    }
    
    @objc private func addButtonTapped() {
        guard let text = wishTextView.text, !text.isEmpty else { return }
        addWish?(text)
        wishTextView.text = Constants.wishTextPlaceholder
        wishTextView.textColor = Constants.wishTextPlaceholderColor
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.textColor == Constants.wishTextPlaceholderColor {
                textView.text = nil
                textView.textColor = Constants.wishTextColor
            }
        }
    
}
