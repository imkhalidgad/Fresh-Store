//
//  ProductDetailsVC.swift
//  ITI Task
//

import UIKit

class ProductDetailsVC: UIViewController {

    var product: Product!
    var index: Int!
    
    @IBOutlet weak var productIMG: UIImageView!
    @IBOutlet weak var productNameTextField: UILabel!
    @IBOutlet weak var productCategoryTextField: UITextField!
    @IBOutlet weak var productStockTextField: UITextField!
    @IBOutlet weak var productRatingTextField: UITextField!
    @IBOutlet weak var productPriceTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productIMG.layer.cornerRadius = productIMG.frame.height/2
        // Do any additional setup after loading the view.
        
        setupUI()
    }
    
    func setupUI(){
       // descriptionTextView.text = product!.description

        if product?.name != nil {
            productNameTextField.text = product!.name
        } else {
            productNameTextField.text = "No Name"
        }
        
        if product?.category != nil {
            productCategoryTextField.text = product!.category
        } else {
            productCategoryTextField.text = "No Category"
        }
        
        if product?.stock != nil {
            productStockTextField.text = product!.stock
        } else {
            productStockTextField.text = "Not Avaliable"
        }
        
        if product?.rating != nil {
            productRatingTextField.text = product!.rating
        } else {
            productRatingTextField.text = "Not Rating"
        }
        
        if product?.price != nil {
            productPriceTextField.text = product!.price
        } else {
            productPriceTextField.text = "Not Available"
        }
        
        if product?.description != nil {
            descriptionTextView.text = product!.description
        } else {
            descriptionTextView.text = "No Details"
            descriptionTextView.textColor = UIColor.lightGray
        }
       
        if product?.image != nil {
            productIMG.image = product!.image
        } else {
            productIMG.image = UIImage.productPlaceHolder
        }

    }

    
}
