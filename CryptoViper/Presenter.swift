//
//  Presenter.swift
//  CryptoViper
//
//  Created by Jinu on 17/11/2023.
//

import Foundation
//class,protocol
//talk to -> interactor,router,view

enum NetworkError : Error{
    case NnetworkFailed
    case ParsingFailed
    
}
protocol AnyPresenter{
    var router : AnyRouter? {get set}
    var interactor : AnyInteractor? {get set}
    var view: AnyView?{get set}
    
    func interactorDidDownloadedCrypto(result : Result<[Crypto],Error>)
}

class CryptoPresenter: AnyPresenter{
    var router: AnyRouter?
    
    var interactor: AnyInteractor?{
        didSet{
            interactor?.downloadCryptos()
        }
    }
    
    var view: AnyView?
    
    func interactorDidDownloadedCrypto(result: Result<[Crypto], Error>) {
        switch result{
        case .success(let cryptos):
            view?.update(with: cryptos)
            print("update")
        case .failure(_):
                view?.update(with: "Try again!")
            print("error")
        }
    }
    
    
}
