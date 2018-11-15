//
//  RequestHandler.swift
//  AccugentixApp
//
//  Created by Bharat chowdary Kolla on 11/6/18.
//  Copyright © 2018 Bharat chowdary Kolla. All rights reserved.
//

import UIKit

class RequestHandler: NSObject {

    static let sharedInstance = RequestHandler()
    
    public func requestDataFromUrl(urlName:String, httpMethodType:String, body:[String:Any], completionHandler:@escaping (([String:Any]?, Error?)->())){
        
        if let requestURL = URL(string: urlName ) {
            var urlRequest =  URLRequest(url: requestURL)
            urlRequest.httpMethod = httpMethodType
            for (key, value) in getHeadersData() {
                urlRequest.setValue(value as? String, forHTTPHeaderField:key)
            }
            
            if body.count > 0 {
                let jsonData = try? JSONSerialization.data(withJSONObject: body)
                urlRequest.httpBody = jsonData
            }
            
            
            // set up the session
            let sessionConfig = URLSessionConfiguration.default
            sessionConfig.timeoutIntervalForRequest = 600.0
            sessionConfig.timeoutIntervalForResource = 600.0
            let session = URLSession(configuration: sessionConfig)
            
            // make the request
            let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                if let err = error {
                    completionHandler(nil, err)
                }else {
                    let httpResponse: HTTPURLResponse = response as! HTTPURLResponse
                   
                    if httpResponse.statusCode == 202  || httpResponse.statusCode == 200 {
                        if let data = data {
                            do {
                                if let dictionary = try? JSONSerialization.jsonObject(with: data, options:.allowFragments) as? [String:Any], dictionary != nil {
                                    completionHandler(dictionary, error)
                                } else if let dictionary = try? JSONSerialization.jsonObject(with: data, options:.allowFragments) as? [[String:Any]] {
                                    let tempDict:[String:Any] = ["response":(dictionary ?? "")]
                                    completionHandler(tempDict, error)
                                }
                            }
                        }
                    }else{
                        print("Status Code - \(httpResponse.statusCode) \(String(describing: error))")
                        let err = NSError(domain:"Server Error", code:httpResponse.statusCode, userInfo:nil)
                        completionHandler(nil, err)
                        
                    }
                }
            })
            
            task.resume()
        }
    }
    
    //Service headers instance
    func getHeadersData() -> [String:Any] {
        var headers: [String:Any]  = [:]
        
//        if urlName  == "\(TEMPBASEURL)api/user/login" {
//            headers = ["Content-Type": "application/json",
//                       "basic-auth": "intralox"]
//        } else {
        headers = ["Content-Type": "application/json"]
        //}
        return headers
    }
}
