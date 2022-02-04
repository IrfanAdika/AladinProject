//
//  ProductViewController.swift
//  AladinProject
//
//  Created by Irfan Adika on 03/02/22.
//

import Foundation
import UIKit
import SDWebImage

enum sortProductBy {
    case ascending
    case descending
}

class ProductViewController: BaseViewController {
    
    @IBOutlet weak var btnCart: UIButton!
    @IBOutlet weak var tableViewProduct: UITableView!
    @IBOutlet weak var btnSort: UIButton!
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    private var productEntities = [ProductEntity]()
    var presenter: ProductPresenterProtocol?
    var sortType: sortProductBy = .descending
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getProducts()
        setupTableView()
        setupTarget()
        RealmManager.shared.loadRealmObject()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        refreshLayout()
    }
    
    private func setupTarget() {
        btnCart.addTarget(self, action: #selector(goToCart), for: .touchUpInside)
        btnFilter.addTarget(self, action: #selector(filterProducts), for: .touchUpInside)
        btnSort.addTarget(self, action: #selector(sortProducts), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshLayout), name: Notification.Name("refreshLayout"), object: nil)
    }
    
    @objc private func sortProducts() {
        
        productEntities = {
            switch sortType {
            case .ascending:
                sortType = .descending
                return productEntities.sorted(by: { $0.titleProduct < $1.titleProduct })
            case .descending:
                sortType = .ascending
                return productEntities.sorted(by: { $0.titleProduct > $1.titleProduct })
            }
        }()
        
        tableViewProduct.reloadData()
    }
    
    @objc private func filterProducts() {
        showFilter()
    }
    
    @objc private func goToCart() {
        presenter?.navigateToCart()
    }
    
    private func getProducts() {
        presenter?.getProducts()
    }
    
    private func setupTableView() {
        tableViewProduct.separatorStyle = .none
        tableViewProduct.delegate = self
        tableViewProduct.dataSource = self
        tableViewProduct.register(UINib(nibName: "ProductViewCell", bundle: nil), forCellReuseIdentifier: ProductViewCell.cellName)
    }
    
    @objc private func refreshLayout() {
        let isEmptyCart = RealmManager.shared.retrieveAllDataObject(CartEntity.self) as! [CartEntity]
        
        btnCart.backgroundColor = isEmptyCart.isEmpty ? .systemGray : .systemGreen
        btnCart.isEnabled = !isEmptyCart.isEmpty
        
        tableViewProduct.reloadData()
    }
    
    @objc func showFilter() {
        let alertController = UIAlertController(title: "Filter",
                                                message: nil,
                                                preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "From : IDR 0"
        }

        alertController.addTextField { (textField) in
            textField.placeholder = "To : IDR 1000000"
        }
        
        let continueAction = UIAlertAction(title: "OK", style: .default) {
            [weak alertController] _ in
                                            
            guard let textFields = alertController?.textFields else { return }
            guard let fromPrice = Float(textFields[0].text ?? "0") else { return }
            guard let toPrice = Float(textFields[1].text ?? "0") else { return }
            
            self.productEntities = self.productEntities.filter {
                $0.priceProduct >= fromPrice && $0.priceProduct <= toPrice
            }
            
            self.tableViewProduct.reloadData()
        }

        alertController.addAction(continueAction)
        
        self.present(alertController,
                     animated: true)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension ProductViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productEntities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableViewProduct.dequeueReusableCell(withIdentifier: ProductViewCell.cellName, for: indexPath) as! ProductViewCell
        
        let data = productEntities[indexPath.row]
        
        cell.imageProduct.contentMode = .scaleAspectFill
        cell.imageProduct.sd_setImage(with: URL(string: data.imageUrlProduct), placeholderImage: UIImage(named: "bg_placeholder"), options: .highPriority, completed: nil)
        cell.titleProduct.text = data.titleProduct
        cell.descProduct.text = data.descriptionProduct
        cell.btnCart.tag = indexPath.row
        cell.btnCart.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        
        if let cart = RealmManager.shared.getCartById(idProduct: data.idProduct) {
            cell.priceProduct.textColor = .systemGreen
            cell.priceProduct.text = "\(cart.totalItem) x Rp. \(data.priceProduct)"
        } else {
            cell.priceProduct.textColor = .black
            cell.priceProduct.text = "\(data.priceProduct)".toIDR()
        }
        
        return cell
    }
    
    @objc private func addToCart(_ sender: UIButton) {
        let product = productEntities[sender.tag]
        presenter?.saveToCart(data: product)
        refreshLayout()
    }
    
}

extension ProductViewController: ProductViewProtocol {
    
    func didSuccessGetProducts(data: [ProductEntity]) {
        self.productEntities = data
        self.tableViewProduct.reloadData()
    }
    
    func showProgressDialog(isShow: Bool) {
        loadingIndicator.isHidden = !isShow
        isShow ? loadingIndicator.startAnimating() : loadingIndicator.stopAnimating()
    }
    
    func showAlertMessage(isSuccess: Bool, message: String) {
        showAlertFromTop(message: message, isSuccess: isSuccess)
    }
    
    
}
