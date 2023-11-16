//
//  WishStoringViewController.swift
//  yuvgudoshnikovaPW2
//
//  Created by Юлия Гудошникова on 15.11.2023.
//

import Foundation
import UIKit
import CoreData

final class WishStoringViewController: UIViewController {
    
    private enum Constants {
        static let tableCornerRadius:CGFloat = 20
        static let tableOffset: CGFloat = 20
        static let numberOfSections: Int = 2
        static let wishesKey:String = "wishes"
        
        static let headerTableHeight:CGFloat = 50
    }
    
    private let table: UITableView = UITableView(frame: .zero)
    private var wishArray: [Wish] = []
    static let applicationDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = applicationDelegate.persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWishes()
        configureUI()
    }
    private func fetchWishes() {
            let fetchRequest: NSFetchRequest<Wish> = Wish.fetchRequest()
            do {
                wishArray = try context.fetch(fetchRequest)
                table.reloadData()
            } catch {
                print("Error fetching wishes: \(error.localizedDescription)")
            }
        }
    
    private func configureUI() {
        view.backgroundColor = .white
        configureTable()
    }
    
    private func configureTable() {
        view.addSubview(table)
        let headerView = UILabel(frame: CGRect(x: 0,
                                              y: 0,
                                              width: table.frame.width,
                                               height: Constants.headerTableHeight))
        headerView.text = "Wishes"
        headerView.textAlignment = .center
        table.tableHeaderView = headerView
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
            
            addCell.addWish = {
                [weak self] text in
                let newWish = Wish(context: self!.context)
                newWish.wish = text
                self?.wishArray.append(newWish)
                WishStoringViewController.applicationDelegate.saveContext()
                self?.table.reloadData()
            }
            
            return addCell

        } else {
            table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
            
            let cell = tableView.dequeueReusableCell(
                withIdentifier: WrittenWishCell.reuseId,
                for: indexPath
            )
            guard let wishCell = cell as? WrittenWishCell else { return cell }
            wishCell.contentView.isUserInteractionEnabled = false
            let wish = wishArray[indexPath.row]
            wishCell.configure(with: wish.wish ?? "")
            wishCell.deleteWish = {
                [weak self] in 
                let wishToRemove = self?.wishArray[indexPath.row]
                self?.context.delete(wishToRemove!)
                self?.wishArray.remove(at: indexPath.row)
                WishStoringViewController.applicationDelegate.saveContext()
                self?.table.reloadData()
            }
            
            wishCell.editWish = {
                [weak self] text in
                let editController = EditWishCellController()
                editController.wishTextView.text = text
                editController.editWish = {
                    [weak self] text in
                    let editedWish = self!.wishArray[indexPath.row]
                    editedWish.wish = text
                    WishStoringViewController.applicationDelegate.saveContext()
                    self?.table.reloadData()
                }
                self?.present(editController, animated: true)
            }
            
            return wishCell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.numberOfSections
    }
}
