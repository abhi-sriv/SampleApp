//
//  NetworkManager.swift
//  SampleApp
//
//  Created by Abhishek Srivastava on 28/05/22.
//

import Foundation
import UIKit

class NetworkManager: NSObject {
    
    static let sharedManager: NetworkManager = NetworkManager()
    private override init() {/*true singltons cannot be initialised from outside*/}
        
    /// Use this method to get response from your API server or any other server
    /// - Parameters:
    ///   - request: URLRequest object, using which you intend to get data from the server
    ///   - completionHandler: Completion handler that returns a Data, URLResponse and Error objects to handle everything elegently.
    func getDataFor(request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            /*
             - Handle all common errors here that can occur for the complete app, for example timeouts and authentication or expired token logics here.
             - Since the scope here is too thin, we will just return everything in the completion block
            */
            completionHandler(data, response, error)
        }.resume()
    }
}
