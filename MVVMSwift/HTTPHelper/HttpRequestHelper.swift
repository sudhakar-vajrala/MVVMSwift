//
//  HttpRequestHelper.swift
//  MVVMSwift
//
//  Created by Venkata Sudhakar Reddy on 06/03/25.
//

import Foundation

class HttpRequestHelper {
    
    enum HTTPHeaderFields {
        case application_json
        case application_x_www_form_urlencoded
        case none
    }
    
    func GET(url: String, params: [String:String], httpHeader: HTTPHeaderFields, completion: @escaping (Bool, Data?) -> Void) {
        
        guard let url = URL(string: url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        switch httpHeader {
        case .application_json:
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        case .application_x_www_form_urlencoded:
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        case .none: break
        }
        //
        // .ephemeral prevent JSON from caching (They'll store in Ram and nothing on Disk)
        let config = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: config)
        session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: problem calling GET")
                print(error!)
                completion(false, nil)
                return
            }
            guard let data = data else {
                print("Error: did not receive data")
                completion(false, nil)
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                completion(false, nil)
                return
            }
            completion(true, data)
        }.resume()
        
    }
}
