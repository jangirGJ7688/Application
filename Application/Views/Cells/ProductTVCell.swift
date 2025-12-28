//
//  ProductTVCell.swift
//  Application
//
//  Created by Ganpat Jangir on 27/12/25.
//

import UIKit
import SDWebImage

class ProductTVCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var productDesLbl: UILabel!
    @IBOutlet weak var productCategoryLbl: UILabel!
    @IBOutlet weak var productPriceLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        productImageView.sd_cancelCurrentImageLoad()
        productImageView.image = UIImage(named: "placeholder")
    }
    
    func configureCell(product: ProductModel) {
        addShadow()
        productNameLbl.text = product.title ?? ""
        productDesLbl.text = product.description ?? ""
        productCategoryLbl.text = "Category: " + (product.category ?? "")
        productPriceLbl.text = "Price ₹ \(product.price ?? 0.0)"
        productImageView.sd_setImage(with: URL(string: product.image ?? ""),
                                     placeholderImage: UIImage(named: "placeholder"),
                                     options: [
                                        .retryFailed,
                                        .continueInBackground,
                                        .scaleDownLargeImages])
    }
    
    func addShadow() {
        bgView.layer.shadowColor = UIColor.black.cgColor
        bgView.layer.shadowOpacity = 0.3
        bgView.layer.shadowOffset = CGSize(width: 0, height: 0)
        bgView.layer.shadowRadius = 5
        bgView.layer.cornerRadius = 10
        bgView.layer.masksToBounds = false
    }
    
}
