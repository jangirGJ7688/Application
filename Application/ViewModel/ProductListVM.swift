//
//  ProductListVM.swift
//  Application
//
//  Created by Ganpat Jangir on 27/12/25.
//

import Foundation

protocol ProductListVMProtocol: AnyObject {
    func didGetError(_ error: APIError)
    func didLoadProducts()
}

class ProductListVM {
    
    private let apiService: ProductAPIServiceProtocol
    private(set) var products: [ProductModel] = []
    private var currentPage = 0
    private var pageLimit: Int = 10
    private var totalItems: Int = 0
    private var isLoading = false
    weak var delegate: ProductListVMProtocol?
    
    init(apiService: ProductAPIServiceProtocol = ProductAPIService()) {
        self.apiService = apiService
    }
    
    func getProducts() {
        guard !isLoading else { return }
        isLoading = true
        
        apiService.fetchProducts(page: currentPage) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let response):
                    self?.products.append(contentsOf: response.data ?? [])
                    self?.totalItems = response.pagination?.total ?? 0
                    self?.delegate?.didLoadProducts()
                    
                case .failure(let error):
                    self?.delegate?.didGetError(error)
                }
            }
        }
    }
    
    func getNextPageProducts() {
        if !isNextPageAvailable() || isLoading { return }
        self.currentPage += 1
        getProducts()
    }
    
    func isNextPageAvailable() -> Bool {
        return (currentPage+1) * pageLimit < totalItems
    }
}
