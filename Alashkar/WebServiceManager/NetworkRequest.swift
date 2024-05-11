//
//  NetworkRequest.swift
//  FitMate
//
//  Created by Rohit SIngh Dhakad on 18/06/23.
//

import Foundation
import Alamofire


class WebServiceHelper {
    static let instance = WebServiceHelper()
    let connectivityManager = NetworkReachabilityManager()
    let manager = AF.session
    
    func getServiceData <T: Codable> (url: String, method: HTTPMethod, parameters: [String:Any], encodingType: ParameterEncoding, completion: @escaping (T?, String?) ->()) {
        
        let header: HTTPHeaders = [
            "authToken": strAuthToken ,
            "Accept": "application/json"]
        
        if connectivityManager?.isReachable ?? false {
            //print("Network is Reachable")
            let manager = AF.session
            manager.configuration.timeoutIntervalForRequest = 20
            
            AF.request(url, method: method, parameters: parameters, encoding: encodingType, headers: header)
                .responseDecodable(of: T.self) { response in
                    if let error = response.error {
                        completion(nil, error.localizedDescription)
                    } else if let returnedResponse = response.value {
                        completion(returnedResponse, nil)
                    } else {
                        completion(nil, "Unknown error occurred")
                    }
                }

            
            
//            AF.request(url, method: method, parameters: parameters, encoding: encodingType, headers: header).responseJSON { (response) in
//
//                if response.error != nil {
//                    //debugPrint(response.error?.localizedDescription ?? "")
//                    completion(nil, response.error?.localizedDescription)
//                }
//                else {
//                    guard let data = response.data else {return completion(nil, response.error?.localizedDescription)}
//                    let decoder = JSONDecoder()
//
//                    do{
//                        let returnedResponse = try decoder.decode(T.self, from: data)
//                        completion(returnedResponse, nil)
//                    }catch{
//                        //debugPrint(error)
//                        completion(nil, error.localizedDescription)
//                    }
//
//                }
//
//            }
            
        }
        else {
            //print("Network Not Reachable")
            completion(nil, "Network Not Reachable")
        }
        
    }
}
