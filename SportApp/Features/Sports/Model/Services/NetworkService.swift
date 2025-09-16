//
//  File.swift
//  ProductsApp
//
//  Created by mohamed ezz on 15/09/2025.
//

import Foundation
class NetworkService : FootballNetworkProtocol , BasketballNetworkProtocol  , TennisNetworkProtocol , CricketNetworkProtocol {
    static func fetchFootballFromJSON(completionHandler: @escaping (FootballRequest?) -> Void) {
        let task = URLSession.shared.dataTask(with: URLRequest(url: URL(string: ApiUrls.football)!)){
            data , response , error in
            guard let data = data else{
                return
            }
            do {
                let res = try JSONDecoder().decode(FootballRequest.self, from: data)
                completionHandler(res)
            }
            catch{
                completionHandler(nil)
                print(error.localizedDescription)
                
            }
        }.resume()
    }  
    static func fetchBasketballFromJSON(completionHandler: @escaping (BasketballRequest?) -> Void) {
        let task = URLSession.shared.dataTask(with: URLRequest(url: URL(string: ApiUrls.basketball)!)){
            data , response , error in
            guard let data = data else{
                return
            }
            do {
                let res = try JSONDecoder().decode(BasketballRequest.self, from: data)
                completionHandler(res)
            }
            catch{
                completionHandler(nil)
                print(error.localizedDescription)
                
            }
        }.resume()
    } 
    static func fetchTenniesFromJSON(completionHandler: @escaping (TenniesRequest?) -> Void) {
        let task = URLSession.shared.dataTask(with: URLRequest(url: URL(string: ApiUrls.tennis)!)){
            data , response , error in
            guard let data = data else{
                return
            }
            do {
                let res = try JSONDecoder().decode(TenniesRequest.self, from: data)
                completionHandler(res)
            }
            catch{
                completionHandler(nil)
                print(error.localizedDescription)
                
            }
        }.resume()
    } 
    static func fetchCricketFromJSON(completionHandler: @escaping (CricketRequest?) -> Void) {
        let task = URLSession.shared.dataTask(with: URLRequest(url: URL(string: ApiUrls.cricket)!)){
            data , response , error in
            guard let data = data else{
                return
            }
            do {
                let res = try JSONDecoder().decode(CricketRequest.self, from: data)
                completionHandler(res)
            }
            catch{
                completionHandler(nil)
                print(error.localizedDescription)
                
            }
        }.resume()
    }
}
