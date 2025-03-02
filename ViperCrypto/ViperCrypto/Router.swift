//
//  Router.swift
//  ViperCrypto
//
//  Created by Safak Yaral on 27.11.2024.
//

import Foundation
import UIKit
//Class, protocol
//Entrypoint
//Router = presentor,view,interactor aşamalarını kontrol eder

typealias EntryPoint = UIViewController & AnyRouter
protocol AnyRouter {
     var entry : EntryPoint? { get }
    static func startExecution() -> AnyRouter//static olmasının sebebi her yerden erişim sağlamak için
}

class CryptoRouter: AnyRouter {
    
    var entry: EntryPoint?
    
    static func startExecution() -> AnyRouter {
         
        let router = CryptoRouter()
        
        var view : AnyView = CryptoViewController()
        var presenter : AnyPresenter = CryptoPresenter()
        var interactor : AnyInteractor = CryptoInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        router.entry = view as? EntryPoint
        return router
    }
}

