//
//  NetworkProcessor.swift
//  Azimo_GitHub
//
//  Created by Nikita Gura on 5/2/19.
//  Copyright © 2019 Nikita Gura. All rights reserved.
//

import Foundation

class NetworkProcessor{
    

    private let userName: String
    
    enum API: String {
        case start = "https://api.github.com/users/"
        case end = "/repos"
    }
    
    
    typealias getJson = (([Repo]) -> Void)
    typealias getError = (() -> Void)
    init(userName: String){
        self.userName = userName
    }
    
    public func getJSON(_ completion: @escaping getJson,userNotExist: @escaping getError, getError: @escaping getError){
        guard let url = URL(string: API.start.rawValue+userName+API.end.rawValue)  else {return}
        URLSession.shared.dataTask(with: url) { (data, response, err) in
             if err == nil {
           
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200:
                    guard let data = data else {return}
                    do{
                        let decoder = JSONDecoder()
                        let model = try? decoder.decode([Repo].self, from:
                            data)
                        if let m = model {
                            completion(m)
                        }
            }catch let jsonErr{
                print("Error serilizing json: ", jsonErr)
            }
                default:
                    userNotExist()
                }
            }
        } else {
                getError()
            }
        }.resume()
    }
}
