//
//  IAPManager.swift
//  Core-Data-Implementation
//
//  Created by Mapple.pk on 14/06/2023.
//

import Foundation
import StoreKit

class InAppPurchaseManager: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    static let shared = InAppPurchaseManager()
    
    private var productsRequest: SKProductsRequest?
    private var productsCompletion: ((Result<[SKProduct], Error>) -> Void)?
    private var purchaseCompletion: ((Result<Bool, Error>) -> Void)?
    
    private override init() {
        super.init()
        SKPaymentQueue.default().add(self)
    }
    
    func fetchProducts(productIdentifiers: Set<String>, completion: @escaping (Result<[SKProduct], Error>) -> Void) {
        productsCompletion = completion
        
        productsRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
        productsRequest?.delegate = self
        productsRequest?.start()
    }
    
    func purchase(product: SKProduct, completion: @escaping (Result<Bool, Error>) -> Void) {
        purchaseCompletion = completion
        
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
    
    // MARK: - SKProductsRequestDelegate
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        productsCompletion?(.success(response.products))
        productsCompletion = nil
        productsRequest = nil
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        productsCompletion?(.failure(error))
        productsCompletion = nil
        productsRequest = nil
    }
    
    // MARK: - SKPaymentTransactionObserver
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                completeTransaction(transaction)
            case .failed:
                failTransaction(transaction)
            case .restored:
                restoreTransaction(transaction)
            case .deferred, .purchasing:
                // Do nothing for now
                break
            @unknown default:
                break
            }
        }
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        // All restored transactions have been processed
    }
    
    // MARK: - Transaction Handling
    
    private func completeTransaction(_ transaction: SKPaymentTransaction) {
        deliverPurchaseNotificationFor(identifier: transaction.payment.productIdentifier)
        SKPaymentQueue.default().finishTransaction(transaction)
        purchaseCompletion?(.success(true))
        purchaseCompletion = nil
    }
    
    private func failTransaction(_ transaction: SKPaymentTransaction) {
        if let error = transaction.error {
            purchaseCompletion?(.failure(error))
        } else {
            purchaseCompletion?(.failure(InAppPurchaseError.unknownError))
        }
        purchaseCompletion = nil
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    private func restoreTransaction(_ transaction: SKPaymentTransaction) {
        deliverPurchaseNotificationFor(identifier: transaction.payment.productIdentifier)
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    private func deliverPurchaseNotificationFor(identifier: String?) {
        guard let identifier = identifier else { return }
        let notification = Notification(name: Notification.Name(rawValue: InAppPurchaseManager.purchaseNotificationIdentifier), object: identifier)
        NotificationCenter.default.post(notification)
    }
}

// MARK: - InAppPurchaseError

enum InAppPurchaseError: Error {
    case unknownError
}

// MARK: - Notification Identifier

extension InAppPurchaseManager {
    static let purchaseNotificationIdentifier = "InAppPurchaseNotification"
}
