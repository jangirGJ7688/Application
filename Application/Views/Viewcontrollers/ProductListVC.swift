//
//  ProductListVC.swift
//  Application
//
//  Created by Ganpat Jangir on 27/12/25.
//

import UIKit

class ProductListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loaderView: UIActivityIndicatorView!
    @IBOutlet weak var noDataLable: UILabel!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    private var viewModel: ProductListVM = ProductListVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Products"
        self.setupTableView()
        viewModel.delegate = self
        loaderView.isHidden = false
        loaderView.startAnimating()
        viewModel.getProducts()
    }
    
    @IBAction func retryButtonTapped(_ sender: Any) {
        viewModel.getProducts()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "ProductTVCell", bundle: nil), forCellReuseIdentifier: "ProductTVCell")
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension ProductListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTVCell", for: indexPath) as? ProductTVCell else {
            return UITableViewCell()
        }
        let product = self.viewModel.products[indexPath.row]
        cell.configureCell(product: product)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ProductDetailVC()
        vc.product = self.viewModel.products[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.viewModel.products.count - 1 {
            self.viewModel.getNextPageProducts()
        }
    }
}

extension ProductListVC: ProductListVMProtocol {
    func didGetError(_ error: APIError) {
        self.loaderView.stopAnimating()
        loaderView.isHidden = true
        self.errorMessageLabel.text = error.errorDescription
        self.errorView.isHidden = false
    }
    
    func didLoadProducts() {
        self.loaderView.stopAnimating()
        loaderView.isHidden = true
        self.errorView.isHidden = true
        if viewModel.products.isEmpty == true {
            self.tableView.isHidden = true
            self.noDataLable.isHidden = false
        } else {
            self.tableView.isHidden = false
            self.noDataLable.isHidden = true
        }
        self.tableView.reloadData()
    }
}

