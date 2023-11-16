//
//  WishStoringViewController.swift
//  yuvgudoshnikovaPW2
//
//  Created by Юлия Гудошникова on 15.11.2023.
//

import Foundation
import UIKit

final class WishStoringViewController: UIViewController {
    private enum Constants {
        static let tableCornerRadius:CGFloat = 20
        static let tableOffset: CGFloat = 20
        static let numberOfSections: Int = 2
    }
    
    private let table: UITableView = UITableView(frame: .zero)
    private var wishArray: [String] = ["I wish to add cells to the table"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        configureTable()
    }
    
    private func configureTable() {
        view.addSubview(table)
        table.backgroundColor = .white
        table.dataSource = self
        table.separatorStyle = .none
        table.layer.cornerRadius = Constants.tableCornerRadius
        table.pin(to: view, Constants.tableOffset)
    }
}

// MARK: - UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            // Возвращаем 1 ячейку для первой секции
            return 1
        } else if section == 1 {
            // Возвращаем количество элементов в wishArray для второй секции
            return wishArray.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            table.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
            
            let cell = tableView.dequeueReusableCell(withIdentifier: AddWishCell.reuseId, for: indexPath)
            
            guard let addCell = cell as? AddWishCell else {return cell}
            
            return addCell

        } else {
            table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
            
            let cell = tableView.dequeueReusableCell(
                withIdentifier: WrittenWishCell.reuseId,
                for: indexPath
            )
            guard let wishCell = cell as? WrittenWishCell else { return cell }
            
            wishCell.configure(with: wishArray[indexPath.row])
            
            return wishCell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.numberOfSections
    }
}
