//
//  FetchDataProtocol.swift
//  SportApp
//
//  Created by mohamed ezz on 17/09/2025.
//

import Foundation
protocol FetchDataProtocol{
    static func fetchData<T: Decodable>(from url: String, completionHandler: @escaping (T?) -> Void)
}
