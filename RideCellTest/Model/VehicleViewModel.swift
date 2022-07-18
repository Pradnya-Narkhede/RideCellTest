//
//  VehicleViewModel.swift
//  RideCellTest
//
//  Created by Apple on 17/07/22.
//

import Foundation
//MARK: VehicleProtocol
protocol VehicleProtocol{
    func readLocalFile(forName name:String)->Data?
    func parse(jsonData: Data, completion:@escaping ([VehicleModel]) -> ())
}
//MARK: VehicleViewModel
class VehicleViewModel:VehicleProtocol{
    
    
    func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    func parse(jsonData: Data, completion:@escaping ([VehicleModel]) -> ()) {
        do {
            let decodedData = try JSONDecoder().decode([VehicleModel].self,
                                                       from: jsonData)
            completion(decodedData)
        } catch {
            print("decode error")
            print(error)
        }
    }
}
