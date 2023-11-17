//
//  Interactor.swift
//  CryptoViper
//
//  Created by Jinu on 17/11/2023.
//

import Foundation
//business logic
//class,protocol
//talk to -> presenter
protocol AnyInteractor{
    var presenter : AnyPresenter?{get set}
    func downloadCryptos()
}
class CryptoInteractor: AnyInteractor{
    var presenter : AnyPresenter?
    func downloadCryptos() {
        
        guard let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json") else{
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self]data, response, error in
            
            guard  let data = data , error == nil else{
                self?.presenter?.interactorDidDownloadedCrypto(result: .failure(NetworkError.NnetworkFailed))
                return
            }
            do{
                let cryptos = try JSONDecoder().decode([Crypto].self, from: data)
                self?.presenter?.interactorDidDownloadedCrypto(result: .success(cryptos))
            } catch{
                self?.presenter?.interactorDidDownloadedCrypto(result: .failure(NetworkError.ParsingFailed))

                
            }
        }
        task.resume()
    }
    
    
}
