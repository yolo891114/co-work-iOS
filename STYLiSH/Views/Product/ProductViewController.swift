//
//  ProductViewController.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/2/15.
//  Copyright © 2019 AppWorks School. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

    private enum LayoutType {
        case list
        case grid
    }

    private enum ProductType: Int {
        case women = 0
        case men = 1
        case accessories = 2
    }

    private struct Segue {
        static let men = "SegueMen"
        static let women = "SegueWomen"
        static let accessories = "SegueAccessories"
    }

    @IBOutlet weak var indicatorView: UIView!

    @IBOutlet weak var indicatorCenterXConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var layoutBtn: UIBarButtonItem!

    @IBOutlet weak var menProductsContainerView: UIView!

    @IBOutlet weak var womenProductsContainerView: UIView!

    @IBOutlet weak var accessoriesProductsContainerView: UIView!

    @IBOutlet var productBtns: [UIButton]!

    private var containerViews: [UIView] {
        return [menProductsContainerView, womenProductsContainerView, accessoriesProductsContainerView]
    }

    private var isListLayout: Bool = false {
        didSet {
            switch isListLayout {
            case true: showListLayout()
            case false: showGridLayout()
            }
        }
    }

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        isListLayout = false
        
        navigationItem.rightBarButtonItem = nil
    }

    // MARK: - Action
    @IBAction func onChangeProducts(_ sender: UIButton) {
        for btn in productBtns {
            btn.isSelected = false
        }
        sender.isSelected = true
        moveIndicatorView(reference: sender)
        
        guard let type = ProductType(rawValue: sender.tag) else { return }
        updateContainer(type: type)
    }

    @IBAction func onChangeLayoutType(_ sender: UIBarButtonItem) {
        isListLayout = !isListLayout
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let productListVC = segue.destination as? ProductListViewController else { return }
        let identifier = segue.identifier
        var provider: ProductListDataProvider?
        let marketProvider = MarketProvider()
        
        if identifier == Segue.men {
            provider = ProductsProvider(productType: ProductsProvider.ProductType.men, dataProvider: marketProvider)
        } else if identifier == Segue.women {
            provider = ProductsProvider(productType: ProductsProvider.ProductType.women, dataProvider: marketProvider)
        } else if identifier == Segue.accessories {
            provider = ProductsProvider(
                productType: ProductsProvider.ProductType.accessories,
                dataProvider: marketProvider
            )
        }
        productListVC.provider = provider
    }

    // MARK: - Private method
    private func showListLayout() {
        layoutBtn.image = .asset(.Icons_24px_CollectionView)
        showLayout(type: .list)
    }

    private func showGridLayout() {
        layoutBtn.image = .asset(.Icons_24px_ListView)
        showLayout(type: .grid)
    }

    private func showLayout(type: LayoutType) {
        children.forEach { child in
            if let child = child as? ProductListViewController {
                switch type {
                case .list: child.showListView()
                case .grid: child.showGridView()
                }
            }
        }
    }

    private func moveIndicatorView(reference: UIView) {
        indicatorCenterXConstraint.isActive = false
        indicatorCenterXConstraint = indicatorView.centerXAnchor.constraint(equalTo: reference.centerXAnchor)
        indicatorCenterXConstraint.isActive = true

        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.view.layoutIfNeeded()
        })
    }

    private func updateContainer(type: ProductType) {
        containerViews.forEach { $0.isHidden = true }
        
        switch type {
        case .men:
            menProductsContainerView.isHidden = false
        case .women:
            womenProductsContainerView.isHidden = false
        case .accessories:
            accessoriesProductsContainerView.isHidden = false
        }
    }
}
