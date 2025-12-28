//
//  ProductDetailVC.swift
//  Application
//
//  Created by Ganpat Jangir on 27/12/25.
//

import UIKit
import SDWebImage

class ProductDetailVC: UIViewController {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var productBrandLbl: UILabel!
    @IBOutlet weak var productPriceLbl: UILabel!
    @IBOutlet weak var productDesLbl: UILabel!
    @IBOutlet weak var productCateLbl: UILabel!
    @IBOutlet weak var productStockLbl: UILabel!
    @IBOutlet weak var productColorLbl: UILabel!
    @IBOutlet weak var productWeightLbl: UILabel!
    @IBOutlet weak var productStorageLbl: UILabel!
    @IBOutlet weak var productRatingLbl: UILabel!
    @IBOutlet weak var productRatingCountLbl: UILabel!
    
    var product: ProductModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        productImageView.sd_setImage(with: URL(string: product.image ?? ""),
                                     placeholderImage: UIImage(named: "placeholder"),
                                     options: [
                                        .retryFailed,
                                        .continueInBackground,
                                        .scaleDownLargeImages])
        productNameLbl.text = product.title
        productPriceLbl.text = "Price ₹ \(product.price ?? 0.0)"
        productDesLbl.text = product.description
        productCateLbl.text = "Category: \(product.category ?? "")"
        productStockLbl.text = "Stock: \(product.stock ?? 0)"
        productColorLbl.text = "Color: \(product.specs?.color ?? "")"
        productBrandLbl.text = "Brand: \(product.brand ?? "")"
        productRatingLbl.text = "User Rating: \(product.rating?.rate ?? 0.0)"
        productRatingCountLbl.text = "Users Rated: \(product.rating?.count ?? 0)"
        productWeightLbl.text = "Weight: \(product.specs?.weight ?? "")"
        productStorageLbl.text = "Memory: \(product.specs?.storage ?? "")"
    }
}
