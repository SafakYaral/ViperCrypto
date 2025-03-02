//
//  Presentor.swift
//  ViperCrypto
//
//  Created by Safak Yaral on 27.11.2024.
//

import Foundation

// Class , protocol
// Talks to -> ınteractor, router, view

enum NetworkError : Error {
    case networkFailed
    case parsingFailed
}

protocol AnyPresenter {
    
    var router: AnyRouter? {get set } //get = okuma ve set = değer değiştirme izni verir
    var interactor: AnyInteractor? {get set }
    var view : AnyView? {get set}
    
    func interactorDidDownloadCrypto(result: Result<[CryptoEntity], Error>)
}

class CryptoPresenter: AnyPresenter {
    var router: (any AnyRouter)?
    
    var interactor: (any AnyInteractor)?{
        didSet{
            interactor?.downloadCryptos()
        }
    }
    
    
    var view: (any AnyView)?
    
    
    func interactorDidDownloadCrypto(result: Result<[CryptoEntity], any Error>) {
        switch result {
        case .success(let crypto):
            view?.update(with: crypto)
        case .failure(_):
            view?.update(with: "Please try again later!")
        }
    }
    
    
}
