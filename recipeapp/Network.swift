//
//  Network.swift
//  recipeapp
//
//  Created by Lana Do on 11/13/23.
//

import Foundation
class Network {
    
    //Session and Configuration Lazily Loaded
    lazy var configuration = URLSessionConfiguration.default
    lazy var session = URLSession(configuration: configuration)
    
    //url
    let url : URL?
    
    init(url : URL){
        self.url = url
    }
    
    
    typealias jsonCompletionHandler = ( ([String : Any]?)-> Void )
    typealias dataCompletionHandler = ((Data?)-> Void)
    
    func downloadJSONData(completion: @escaping jsonCompletionHandler){
        
        let request = URLRequest(url: url!)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            if error == nil {
                if let responseFromServer = response as? HTTPURLResponse {
                    switch responseFromServer.statusCode {
                    case 200:
                        //STATUS OK
                        if let dataResult = data {
                            do {
                                let serializedData = try JSONSerialization.jsonObject(with: dataResult, options: .mutableContainers)
                                completion(serializedData as? [String : Any])
                                
                                //print("data ok")
                                //print(serializedData)
                            }catch let dataError as NSError{
                                print("Error serializing data: \(String(describing : dataError.localizedDescription))")
                            }
                        }
                        print("OK")
                    default:
                        print("Error from Response, status code: \(String(describing: responseFromServer.statusCode))")
                    }
                }
            }else {
                print("Error Downloading JSON: \(String(describing: error?.localizedDescription))")
            }
        }
        dataTask.resume()
    }

    
    
    //Downloads Image data from url with completion to pass image data object to
    //the caller
    func downloadImageData(completion: @escaping dataCompletionHandler){
        
        let request = URLRequest(url: url!)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            if error == nil {
                if let responseFromServer = response as? HTTPURLResponse {
                    switch responseFromServer.statusCode {
                    case 200:
                        //STATUS OK
                        if let dataResult = data {
                            completion(dataResult)
                        }
                        //print("OK")
                    default:
                        print("Error from Response, status code: \(String(describing: responseFromServer.statusCode))")
                    }
                }
            }else {
                print("Error Downloading Image Data: \(String(describing: error?.localizedDescription))")
            }
        }
        dataTask.resume()
    }
        
    
}
