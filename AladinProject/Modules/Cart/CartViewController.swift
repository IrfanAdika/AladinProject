//
//  CartViewController.swift
//  AladinProject
//
//  Created by Irfan Adika on 04/02/22.
//

import UIKit

class CartViewController: UIViewController {
    
    @IBOutlet weak var tableViewCart: UITableView!
    @IBOutlet weak var buttonCheckout: UIButton!
    @IBOutlet weak var labelTotalPayment: UILabel!
    
    var presenter: CartPresenterProtocol?
    var cartEntities = [CartEntity]()
    var selectedCart = CartEntity()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupButtonTarget()
        updateGrandTotal()
        RealmManager.shared.loadRealmObject()
    }
    
    private func setupTableView() {
        tableViewCart.separatorStyle = .none
        tableViewCart.delegate = self
        tableViewCart.dataSource = self
        tableViewCart.register(UINib(nibName: "CartViewCellTableViewCell", bundle: nil), forCellReuseIdentifier: CartViewCellTableViewCell.cellName)
         
        tableViewCart.reloadData()
    }
    
    private func updateGrandTotal() {
        let total = presenter?.getTotalProduct()
        labelTotalPayment.text = "Total: " + "\(total ?? 0)".toIDR()
        
        NotificationCenter.default.post(name: Notification.Name("refreshLayout"), object: nil)
    }
    
    private func setupButtonTarget() {
        buttonCheckout.addTarget(self, action: #selector(checkout), for: .touchUpInside)
    }
    
    @objc private func checkout() {
        presenter?.checkout()
        updateGrandTotal()
    }
    
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RealmManager.shared.cart?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewCart.dequeueReusableCell(withIdentifier: CartViewCellTableViewCell.cellName, for: indexPath) as! CartViewCellTableViewCell
        
        if let cartList = RealmManager.shared.cart?[indexPath.row], let data = RealmManager.shared.getProductById(idProduct: cartList.idProduct) {
            cell.imageViewProduct.contentMode = .scaleAspectFill
            cell.imageViewProduct.sd_setImage(with: URL(string: data.imageUrlProduct), placeholderImage: UIImage(named: "bg_placeholder"), options: .highPriority, completed: nil)
            cell.titleProduct.text = data.titleProduct
            cell.descriptionProduct.text = data.descriptionProduct
            cell.priceProduct.text = "\(data.priceProduct)".toIDR()
            cell.labelTotal.text = "\(cartList.totalItem)"
            
            self.selectedCart = cartList
            cell.btnMin.tag = cartList.idProduct
            cell.btnMin.addTarget(self, action: #selector(tapMin), for: .touchUpInside)
            cell.btnPlus.tag = cartList.idProduct
            cell.btnPlus.addTarget(self, action: #selector(tapPlus), for: .touchUpInside)
            cell.btnRemove.tag = cartList.idProduct
            cell.btnRemove.addTarget(self, action: #selector(tapRemove), for: .touchUpInside)
        }
        
        return cell
    }
    
    @objc private func tapMin(_ sender: UIButton) {
        if let cart = RealmManager.shared.getCartById(idProduct: sender.tag) {
            presenter?.minProduct(data: cart)
        }
    }
    
    @objc private func tapPlus(_ sender: UIButton) {
        if let cart = RealmManager.shared.getCartById(idProduct: sender.tag) {
            presenter?.plusProduct(data: cart)
        }
    }
    
    @objc private func tapRemove(_ sender: UIButton) {
        if let cart = RealmManager.shared.getCartById(idProduct: sender.tag) {
            presenter?.removeProduct(data: cart)
        }
    }
    
}

extension CartViewController: CartViewProtocol {
    func didSuccessGetProducts() {
        
    }
    
    func didSuccessCalcuteProduct() {
        if let cart = RealmManager.shared.cart, cart.isEmpty {
            self.dismiss(animated: true, completion: nil)
        }
        updateGrandTotal()
        tableViewCart.reloadData()
    }
    
    func showProgressDialog(isShow: Bool) {
        
    }
    
    func showAlertMessage(title: String, message: String) {
        
    }
    
    
}
