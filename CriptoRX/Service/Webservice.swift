//
//  Webservice.swift
//  CriptoRX
//
//  Created by Hatice Taşdemir on 6.11.2024.
//

import Foundation
//kendi loglarımda takip edebilmek için enum oluşturur error protocolüne conform ederim.
enum CryptoError : Error{
    case serverError
    case parsingError
}

class Webservice {

    
    func downloadCurrencies(url: URL, completion: @escaping (Result<[Crypto],CryptoError>)->()){
        URLSession.shared.dataTask(with: url) { data, response, error in
           
            if let error = error {
                completion(.failure(CryptoError.serverError))
              
            }else if let data = data {
                //typeı yani modeli yazarız ne alacağım, nereden alaacğım ise yukarıda kontrol ettiğimiz datayı alırsa dataadan alaacak demek. try catchde yapılmalı
                let cryptoList = try? JSONDecoder().decode([Crypto].self, from: data)
                //eğer cryptoList jsonveri varsa yazdığımız hem hata hem de başarıyı veren completion çağırırız. kontrol ederiz öncesinde:
                if let cryptoList = cryptoList{
                    completion(.success(cryptoList))
                }else{
                    completion(.failure(.parsingError))
                }
                
                
            }
        }.resume()
       
    }
}
