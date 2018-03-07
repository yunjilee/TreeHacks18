//
//  APIMedicController.swift
//  HealthProfile
//
//  Created by Gimin Moon on 2/17/18.
//  Copyright © 2018 Gimin Moon. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIMedicController{

    init(){
    }
    
    //let session = URLSession.shared
    let url = "https://sandbox-authservice.priaid.ch/login"
    let urlsymp = "https://sandbox-healthservice.priaid.ch/symptoms"
    let username = "yunalee22@gmail.com"
    let password = "Af43Cio8T5Zxy2G6F"
    let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6Inl1bmFsZWUyMkBnbWFpbC5jb20iLCJyb2xlIjoiVXNlciIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL3NpZCI6IjI4NTkiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3ZlcnNpb24iOiIyMDAiLCJodHRwOi8vZXhhbXBsZS5vcmcvY2xhaW1zL2xpbWl0IjoiOTk5OTk5OTk5IiwiaHR0cDovL2V4YW1wbGUub3JnL2NsYWltcy9tZW1iZXJzaGlwIjoiUHJlbWl1bSIsImh0dHA6Ly9leGFtcGxlLm9yZy9jbGFpbXMvbGFuZ3VhZ2UiOiJlbi1nYiIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvZXhwaXJhdGlvbiI6IjIwOTktMTItMzEiLCJodHRwOi8vZXhhbXBsZS5vcmcvY2xhaW1zL21lbWJlcnNoaXBzdGFydCI6IjIwMTgtMDItMTciLCJpc3MiOiJodHRwczovL3NhbmRib3gtYXV0aHNlcnZpY2UucHJpYWlkLmNoIiwiYXVkIjoiaHR0cHM6Ly9oZWFsdGhzZXJ2aWNlLnByaWFpZC5jaCIsImV4cCI6MTUxODkyNzM5NCwibmJmIjoxNTE4OTIwMTk0fQ.zDYOsnsuDGgoeQw6C4Tkz7y80nYHSRYZbt2P3aGiGlM"

    let sessionManager = SessionManager()
    
    func getSymptoms() -> [String] {
        var listOfSymptoms : [String] = []
        let parameters: Parameters = [
            "token": token,
            "language":"en-gb"
        ]
        Alamofire.request(urlsymp, method: .get, parameters: parameters, encoding: URLEncoding.default).responseData { (response) in
            debugPrint("All Response Info: \(response)")
            
            if let data = response.result.value, let utf8Text = String(data: data, encoding: .utf8) {
                //print("Data: \(utf8Text)")
                
            let json = try? JSON(data: data)
            let errorObj: JSON = json!["error"]
            //Check for errors
            if (errorObj.dictionaryValue != [:]) {
                return
            }
            else {
                let numberofsymptoms = json?.count
                //print(numberofsymptoms)
                for symptomps in (json?.array)!{
                    listOfSymptoms.append(symptomps["Name"].stringValue)
                    print(symptomps["Name"].stringValue)
                    }
                }
            }
        }
        return listOfSymptoms
    }
}



