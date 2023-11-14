//
//  ViewController.swift
//  yuvgudoshnikovaPW2
//
//  Created by Юлия Гудошникова on 02.10.2023.
//

import UIKit

enum Constants {
    static let sliderMin: Double = 0
    static let sliderMax: Double = 1
    
    static let red: String = "Red"
    static let green: String = "Green"
    static let blue: String = "Blue"
    
    static let stackSliderRadius: CGFloat = 20
    static let stackSliderBottom: CGFloat = -40
    static let stackSliderLeading: CGFloat = 20
    
    static let titleFontSize: CGFloat = 32
    static let descriptionFomtSize: CGFloat = 28
    
    static let topForLabels: CGFloat = 20
    
    static let stackButtomTop: CGFloat = 100
    static let stackButtomBotton: CGFloat = -100
    static let stackButtomLeading: CGFloat = 100
    
    static let hexInputHight: CGFloat = 100
    
    static let buttonHeight: CGFloat = 50
    static let buttonBottom: CGFloat = 50
    static let buttonSide: CGFloat = 100
    static let buttonText: String? = "My wishes"
    static let buttonRadius: CGFloat = 20
    
    static let tableCornerRadius:CGFloat = 20
    static let tableOffset: CGFloat = 20
}

var backGroundColours : KeyValuePairs =
        [
            "WHITE" : UIColor.white,
            "GRAY" : UIColor.lightGray,
            "BLUE" : UIColor.blue,
            "YELLOW" : UIColor.yellow,
            "RED" : UIColor.red,
            "GREEN" : UIColor.green
        ]

final class WishMakerViewController: UIViewController {
    private let addWishButton: UIButton = UIButton(type: .system)
    
    private var titleView:UILabel!
    private var descriptionView:UILabel!
    
    private var stackSliders:UIStackView!
    private var hexInputField:UITextField!
    private var stackButtons:UIStackView!
    private var colorPicker:UIPickerView!
    
    var redValue:CGFloat = 0
    var blueValue:CGFloat = 0
    var greenValue:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    private func configureAddWishButton() {
        view.addSubview(addWishButton)
        addWishButton.setHeight(Constants.buttonHeight)
        addWishButton.pinBottom(to: view, Constants.buttonBottom)
        addWishButton.pinHorizontal(to: view, Constants.buttonSide)

        addWishButton.backgroundColor = .white
        addWishButton.setTitleColor(.systemPink, for: .normal)
        addWishButton.setTitle(Constants.buttonText, for: .normal)
    
        addWishButton.layer.cornerRadius = Constants.buttonRadius
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
    }
    
    @objc
    private func addWishButtonPressed() {
        present(WishStoringViewController(), animated: true)
    }
    
    private func configureUI() {
        view.backgroundColor = .systemPink
        configureAddWishButton()
        configureTitle()
        configureDescription()
        configureSlidersColor()
        configureButtons()
        configureHEXInputField()
        configureColorPicker()
    }
    // MARK: Создание заголовка и его позиционирование
    private func configureTitle() {
        titleView = UILabel()
        
        titleView.text = "WishMaker"
        titleView.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
        titleView.textColor = .blue
        
        view.addSubview(titleView)
        
        configureTitleConstraints()
    }
    
    fileprivate func configureTitleConstraints() {
        titleView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate( [
            titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.topForLabels)
        ])
    }
    
    // MARK: Создание описания и его позиционирование
    private func configureDescription() {
        descriptionView = UILabel()
        
        descriptionView.text = "Description"
        descriptionView.font = UIFont.systemFont(ofSize: Constants.descriptionFomtSize)
        descriptionView.textColor = .white
        
        view.addSubview(descriptionView)
        
        configureDescriptionConstraints()
    }
    
    fileprivate func configureDescriptionConstraints() {
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: Constants.topForLabels)
            
        ])
    }
    // MARK: Создание стека слайдеров и его позиционирование
    
    private func configureSlidersColor() {
        stackSliders = UIStackView()
        stackSliders.axis = .vertical
        stackSliders.layer.cornerRadius = Constants.stackSliderRadius
        stackSliders.clipsToBounds = true
        view.addSubview(stackSliders)
        
        addSlidersColor()
        configureSlidersColorConstraints()
    }
    
    
    fileprivate func addSlidersColor() {
        let sliderRed = CustomSlider(title: Constants.red, min: Constants.sliderMin, max: Constants.sliderMax)
        let sliderBlue = CustomSlider(title: Constants.blue, min: Constants.sliderMin, max: Constants.sliderMax)
        let sliderGreen = CustomSlider(title: Constants.green, min: Constants.sliderMin, max: Constants.sliderMax)
        
        for slider in [sliderRed, sliderBlue, sliderGreen] {
            stackSliders.addArrangedSubview(slider)
        }
        
        sliderRed.valueChanged = { [weak self] value in
            self?.redValue = CGFloat(value)
            self?.changeBackgroundColor()
        }
        
        sliderBlue.valueChanged = { [weak self] value in
            self?.blueValue = CGFloat(value)
            self?.changeBackgroundColor()
        }
        
        sliderGreen.valueChanged = { [weak self] value in
            self?.greenValue = CGFloat(value)
            self?.changeBackgroundColor()
        }
    }
    
    fileprivate func configureSlidersColorConstraints() {
        stackSliders.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackSliders.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackSliders.leadingAnchor.constraint (equalTo: view.leadingAnchor, constant: Constants.stackSliderLeading),
            stackSliders.bottomAnchor.constraint(equalTo: addWishButton.topAnchor, constant: Constants.stackSliderBottom)
        ])
    }
    
    // MARK: Создание стека кнопок и его позиционирование
    
    private func configureButtons() {
        stackButtons = UIStackView()
        stackButtons.axis = .vertical
        stackButtons.spacing = 8
        stackButtons.distribution = .fillEqually
        stackButtons.layer.cornerRadius = Constants.stackSliderRadius
        
        view.addSubview(stackButtons)
        
        addButtons()
        configureButtonsStackConstraints()
    }
    
    fileprivate func configureButtonsStackConstraints() {
        stackButtons.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackButtons.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackButtons.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: Constants.stackButtomTop),
            stackButtons.bottomAnchor.constraint(equalTo: stackSliders.topAnchor, constant: Constants.stackButtomBotton),
            stackButtons.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.stackButtomLeading)
        ])
    }
    
    fileprivate func addButtons() {
        let buttonSliders = UIButton()
        configureButtonSliders(buttonSliders)
        view.addSubview(buttonSliders)
        
        let buttonRandomColor = UIButton()
        configureButtonRandomColor(buttonRandomColor)
        view.addSubview(buttonRandomColor)
        
        let buttonHEXColor = UIButton()
        configureButtomHEXColor(buttonHEXColor)
        view.addSubview(buttonHEXColor)
        
        let buttonColorPicker = UIButton()
        configureButtonColorPicker(buttonColorPicker)
        view.addSubview(buttonColorPicker)
        
        for button in [buttonSliders, buttonRandomColor, buttonHEXColor, buttonColorPicker] {
            stackButtons.addArrangedSubview(button)
        }
    }
    
    // MARK: Создание и реализация кнопки для слайдеров
    fileprivate func configureButtonSliders(_ buttonSliders: UIButton) {
        buttonSliders.translatesAutoresizingMaskIntoConstraints = false
        buttonSliders.setTitle("Show Sliders", for: .normal)
        buttonSliders.backgroundColor = .black
        buttonSliders.addTarget(self, action: #selector(hideUnhideSliders), for: .touchUpInside)
        buttonSliders.layer.cornerRadius = Constants.stackSliderRadius
        buttonSliders.clipsToBounds = true
    }
    
    @objc
    private func hideUnhideSliders() {
        if stackSliders.isHidden == false {
            stackSliders.isHidden = true
        } else {
            hideColorChanges()
            stackSliders.isHidden = false
        }
    }
    
    // MARK: Создание и реализация кнопки для рандомного изменения цвета
    fileprivate func configureButtonRandomColor(_ buttonRandomColor: UIButton) {
        buttonRandomColor.translatesAutoresizingMaskIntoConstraints = false
        buttonRandomColor.setTitle("Random Color", for: .normal)
        buttonRandomColor.backgroundColor = .black
        buttonRandomColor.addTarget(self, action: #selector(changeOnRandomColor), for: .touchUpInside)
        buttonRandomColor.layer.cornerRadius = Constants.stackSliderRadius
        buttonRandomColor.clipsToBounds = true
    }
    
    @objc
    private func changeOnRandomColor() {
        hideColorChanges()
        let randomHex = getRandomColor()
        let color = UIColor(hex: randomHex)
        view.backgroundColor = color
    }
    
    func getRandomColor() -> String {
        let letters = "0123456789ABCDEF"
        var color = ""
            
        for _ in 0..<6 {
            let randomIndex = Int.random(in: 0..<16)
            let randomLetter = letters[letters.index(letters.startIndex, offsetBy: randomIndex)]
            color.append(randomLetter)
        }
            
        return color
    }
    
    // MARK: Создание и реализация кнопки для изменения цвета через ввод HEX кода
    fileprivate func configureButtomHEXColor(_ buttonHEXColor: UIButton) {
        buttonHEXColor.translatesAutoresizingMaskIntoConstraints = false
        buttonHEXColor.setTitle("HEX Color", for: .normal)
        buttonHEXColor.backgroundColor = .black
        buttonHEXColor.addTarget(self, action: #selector(hideUnhideHEXInput), for: .touchUpInside)
        buttonHEXColor.layer.cornerRadius = Constants.stackSliderRadius
        buttonHEXColor.clipsToBounds = true
    }
    
    @objc
    private func hideUnhideHEXInput() {
        if hexInputField.isHidden == false {
            hexInputField.isHidden = true
        } else {
            hideColorChanges()
            hexInputField.isHidden = false
        }
    }
    
    // MARK: Создание и реализация кнопки для изменения цвета через color picker
    fileprivate func configureButtonColorPicker(_ buttonColorPicker: UIButton) {
        buttonColorPicker.translatesAutoresizingMaskIntoConstraints = false
        buttonColorPicker.setTitle("Color Picker", for: .normal)
        buttonColorPicker.backgroundColor = .black
        buttonColorPicker.addTarget(self, action: #selector(hideUnhideColorPicker), for: .touchUpInside)
        buttonColorPicker.layer.cornerRadius = Constants.stackSliderRadius
        buttonColorPicker.clipsToBounds = true
    }
    
    @objc
    private func hideUnhideColorPicker() {
        if colorPicker.isHidden == false {
            colorPicker.isHidden = true
        } else {
            hideColorChanges()
            colorPicker.isHidden = false
        }
    }
    
    // MARK: Создание и позиционирование HEXInputField
    
    func configureHEXInputField() {
        hexInputField = UITextField(frame: CGRect(x:10, y:60, width:200, height:30))
        hexInputField.borderStyle = UITextField.BorderStyle.roundedRect
        hexInputField.placeholder = "000000"
        hexInputField.adjustsFontSizeToFitWidth = true
        hexInputField.clearButtonMode = .always
        hexInputField.font = UIFont.systemFont(ofSize: 50)
        hexInputField.isHidden = true
        hexInputField.backgroundColor = .white
        
        view.addSubview(hexInputField)
        
        hexInputField.delegate = self

        configureHEXInputFieldConstraints()
    }
    
    fileprivate func configureHEXInputFieldConstraints() {
        hexInputField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hexInputField.topAnchor.constraint(equalTo: stackSliders.topAnchor),
            hexInputField.heightAnchor.constraint(equalToConstant: Constants.hexInputHight),
            hexInputField.leadingAnchor.constraint(equalTo: stackSliders.leadingAnchor),
            hexInputField.trailingAnchor.constraint(equalTo: stackSliders.trailingAnchor)
        ])
    }
    // MARK: Создание и позиционирование ColorPicker
    
    func configureColorPicker() {
        colorPicker = UIPickerView()
        colorPicker.backgroundColor = .white
        colorPicker.delegate = self
        colorPicker.dataSource = self
        colorPicker.isHidden = true
        colorPicker.layer.cornerRadius = Constants.stackSliderRadius
        colorPicker.clipsToBounds = true
       
        view.addSubview(colorPicker)
        configureColorPickerConstraints()
    }
    
    fileprivate func configureColorPickerConstraints() {
        colorPicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colorPicker.topAnchor.constraint(equalTo: stackSliders.topAnchor),
            colorPicker.leadingAnchor.constraint(equalTo: stackSliders.leadingAnchor),
            colorPicker.trailingAnchor.constraint(equalTo: stackSliders.trailingAnchor)
        ])
    }

    // MARK: Функция для сокрытия всех view с помощью которых пользователь изменяет цвет
    private func hideColorChanges() {
        stackSliders.isHidden = true
        hexInputField.isHidden = true
        colorPicker.isHidden = true
    }
    
    // MARK: Функция изменяющая цвет, согласно переменным redValue,greenValue, blueValue
    
    func changeBackgroundColor() {
        self.view.backgroundColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1)
    }

}

extension UIColor {
    convenience init?(hex: String) {
        var rgb: UInt64 = 0
        
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        let alpha = 1.0
        
        guard Scanner(string: hex).scanHexInt64(&rgb) else { return nil }
        
        red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension WishMakerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        backGroundColours.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedColor = backGroundColours[row]
        view.backgroundColor = selectedColor.value
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        label.text = Array(backGroundColours)[row].key
        label.sizeToFit()
        label.textColor = .black
        return label
    }
}

extension WishMakerViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Ограничиваем ввод только символами из набора "0123456789ABCDEF"
        let allowedCharacterSet = CharacterSet(charactersIn: "0123456789ABCDEF")
        let inputCharacterSet = CharacterSet(charactersIn: string)
        let isInputValid = allowedCharacterSet.isSuperset(of: inputCharacterSet)

        // Ограничиваем длину ввода до 6 символов
        let currentText = textField.text ?? ""
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        let isLengthValid = updatedText.count <= 6

        return isInputValid && isLengthValid
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        changeHEXColor(color: textField.text!)
        textField.resignFirstResponder()
        return true
    }
    
    private func changeHEXColor(color: String) {
        let colorBack = UIColor(hex: color)
        view.backgroundColor = colorBack
    }
}
