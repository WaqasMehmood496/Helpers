//
//  PurchasesVC.swift
//  Core-Data-Implementation
//
//  Created by Mapple.pk on 14/06/2023.
//

import UIKit
import StoreKit

class PurchasesVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func fetchProducts(_ sender: UIButton) {
        let productIdentifiers: Set<String> = ["com.example.product1", "com.example.product2"]

        // Fetch available products
        InAppPurchaseManager.shared.fetchProducts(productIdentifiers: productIdentifiers) { result in
            switch result {
            case .success(let products):
                // Process the retrieved products
                for product in products {
                    print("Product ID: \(product.productIdentifier)")
                    print("Product Title: \(product.localizedTitle)")
                    print("Product Description: \(product.localizedDescription)")
                    print("Product Price: \(product.price)")
                }
                
                // Perform further actions with the products
                
            case .failure(let error):
                // Handle the error
                print("Failed to fetch products: \(error.localizedDescription)")
            }
        }
    }
    
    @IBAction func purchase(_ sender: UIButton) {
        let selectedProduct = SKProduct()
        InAppPurchaseManager.shared.purchase(product: selectedProduct) { result in
            switch result {
            case .success(let success):
                if success {
                    // Purchase was successful
                    print("Purchase completed successfully!")
                    
                    // Perform any additional actions after successful purchase
                    
                } else {
                    // Purchase was not successful
                    print("Purchase failed.")
                    
                    // Handle the failed purchase
                    
                }
            case .failure(let error):
                // Handle the error
                print("Failed to make a purchase: \(error.localizedDescription)")
            }
        }
    }
    
    @IBAction func transections(_ sender: UIButton) {
        
    }
    
    @IBAction func restore(_ sender: UIButton) {
        
    }

}
