//
//  Interactor.swift
//  ViperCrypto
//
//  Created by Safak Yaral on 27.11.2024.
//

import Foundation
 
//Class, protocol
//talks to -> presenter

protocol AnyInteractor {
    
    var presenter: AnyPresenter? { get set }
    
    func downloadCryptos()
    
}
class CryptoInteractor: AnyInteractor {
    
    var presenter: (any AnyPresenter)?
    
    func downloadCryptos() {
        
        guard let url = URL(string: "https://github.com/atilsamancioglu/K21-JSONDataSet/blob/master/crypto.json") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self]data, response, error in //weak self verinin tekrar karşımıza çıkmaması için kullanılabilir.
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidDownloadCrypto(result: .failure(NetworkError.networkFailed))
                
                return
            }
            
            do {
                let cryptos = try JSONDecoder().decode([CryptoEntity].self, from: data)
                self?.presenter?.interactorDidDownloadCrypto(result: .success(cryptos))
            }catch{
                self?.presenter?.interactorDidDownloadCrypto(result: .failure(NetworkError.parsingFailed))
            }
        }
        task.resume()
    }
    
    
}
