//
//  ViewController.swift
//  yuvgudoshnikovaPW1
//
//  Created by Юлия Гудошникова on 13.09.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var petals: [UIView]!
    @IBOutlet weak var centreFlower: UIView!
    @IBOutlet var leaves: [UIView]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    // MARK: - Get corner radius function
    func getCornerRadius(size:Int) -> Set<CGFloat> {
        var sizeCornerRadius = Set<CGFloat>()
        while (sizeCornerRadius.count < size) {
            sizeCornerRadius.insert(.random(in: 0...50))
        }
        return sizeCornerRadius
    }
    // MARK: - Get unique color function
    func getUniqueColor(size: Int) -> Set<UIColor> {
        var uniqueColors = Set<UIColor>()
        
        while uniqueColors.count < size {
            let randomHex = getRandomColor()
            
            if let color = UIColor(hex: randomHex) {
                uniqueColors.insert(color)
            }
        }
        
        return uniqueColors
    }
    // MARK: - Get random HEX color function
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
    // MARK: - Animate petals function
    func animatePetals(cornerRadius:CGFloat, color: UIColor) {
        for view in petals {
            UIView.animate(
                withDuration: 0.21,
                animations: {
                    view.backgroundColor = color
                    view.layer.cornerRadius = cornerRadius
                },
                completion: { [weak self] _ in
                    self?.button.isEnabled = true
                }
            )
        }
    }
    // MARK: - Animate centre of flower function
    func animateCentreOfFlower(cornerRadius:CGFloat, color: UIColor) {
            UIView.animate(
                withDuration: 0.21,
                animations: { [self] in
                    self.centreFlower.backgroundColor = color
                    centreFlower.layer.cornerRadius = cornerRadius
                },
                completion: { [weak self] _ in
                    self?.button.isEnabled = true
                }
            )
    }
    // MARK: - Animate leaves function
    func animateLeaves(cornerRadius:CGFloat, color: UIColor) {
        for view in leaves {
            UIView.animate(
                withDuration: 0.21,
                animations: {
                    view.backgroundColor = color
                    view.layer.cornerRadius = cornerRadius
                },
                completion: { [weak self] _ in
                    self?.button.isEnabled = true
                }
            )
        }
    }
    
    @IBOutlet weak var button: UIButton!
    // MARK: - Press button function
    @IBAction func buttonWasPressed(_ sender: UIButton) {
        let countViews = 3
        button.isEnabled = false
        var cornerRadius = getCornerRadius(size: countViews)
        var colors = getUniqueColor(size: countViews)
        
        animatePetals(cornerRadius: cornerRadius.popFirst()!, color:colors.popFirst()!)
        animateCentreOfFlower(cornerRadius: cornerRadius.popFirst()!, color:colors.popFirst()!)
        animateLeaves(cornerRadius:cornerRadius.popFirst()!, color:colors.popFirst()!)
    }
    
}
// MARK: - Extension UIColor
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
