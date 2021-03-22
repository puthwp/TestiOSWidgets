//
//  PillsViewController.swift
//  TestiOSWidgets
//
//  Created by ONEAPP-IT4IT on 22/3/2564 BE.
//

import Foundation
import UIKit
import iOSWidgets

class PillsViewController: UIViewController, TTBBaseBlueDesign {
    
    @IBOutlet weak var accountCards: AccountCardsView!
    @IBOutlet weak var categoryPills: PrimaryPillCategory!
    @IBOutlet weak var dynamicTextPills: PrimaryPillCategory!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setTitleNavigation(title: "Pill Designs")
        categoryPills.source = self
        dynamicTextPills.source = self
        categoryPills.deselectable = false
        categoryPills.font = UIFont.h3NavyLeft!
        
        self.accountCards.datasource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        categoryPills.reloadItems()
        dynamicTextPills.reloadItems()
        self.accountCards.reloadCards {
            //
        }
    }
}

extension PillsViewController: PrimaryPillCategorySourceProtocol {
    func createPill(source: Pills) -> [String]? {
        if source == categoryPills {
            return ["20", "30", "40", "50", "60", "100"]
        }
        return [
            "Savings & Investment",
            "Food & Drinks",
            "Bills & Utilities",
            "Shopping",
            "Travel",
            "Others"
        ]
    }
    
    func didSelected(source: Pills, item: String, index: Int) {
        ///
    }
    
    func didDeselected(source: Pills, item: String, index: Int) {
        ///
    }
    func sizeForItem(source: Pills, at index: Int) -> CGSize? {
        source == categoryPills ? CGSize(width: 85, height: 44) : nil
    }
    
}

extension PillsViewController: PrimaryAccountCardViewsProtocol {
    func createCardViews(_ controller: V?) -> [T]? {
        guard let pathURL = Bundle.main.url(forResource: "FetchAccountList", withExtension: "json") else {
            return []
        }
        do {
            let rawData = try Data(contentsOf: pathURL)
            let decode = JSONDecoder()
            decode.keyDecodingStrategy = .convertFromSnakeCase
            let response = try decode.decode(AccountItemsResponse.self, from: rawData)
            return response.data?.compactMap { DisplayAccountItems(with: $0) } ?? []
        } catch {
            print(error)
            return []
        }
    }
    
    func cardDidSelected(_ vc: V, item: T, at index: Int) {
        ///
    }
    
    func controller() -> V? {
        self
    }
    
    func dismiss(_ controller: V?) {
        ///
    }
    
    
}
