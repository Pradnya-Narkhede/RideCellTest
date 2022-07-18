//
//  VehicleModel.swift
//  RideCellTest
//
//  Created by Apple on 16/07/22.
//

import Foundation
//MARK: - carModel
struct carModel{
    var id : Int
    var lat,lng: Double
    var carImg: String
    var vehicleTypes:String
    var remainingMilege,remainingRangeInMeters : Int
    let licensePlateNumber: String
}

// MARK: - VehicleModel
struct VehicleModel: Codable {
    let id: Int?
    let isActive, isAvailable: Bool?
    let lat: Double?
    let licensePlateNumber: String?
    let lng: Double?
    let pool: String?
    let remainingMileage, remainingRangeInMeters: Int?
    let transmissionMode, vehicleMake, vehiclePic: String?
    let vehiclePicAbsoluteURL: String?
    let vehicleType: String?
    let vehicleTypeID: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case isActive = "is_active"
        case isAvailable = "is_available"
        case lat
        case licensePlateNumber = "license_plate_number"
        case lng, pool
        case remainingMileage = "remaining_mileage"
        case remainingRangeInMeters = "remaining_range_in_meters"
        case transmissionMode = "transmission_mode"
        case vehicleMake = "vehicle_make"
        case vehiclePic = "vehicle_pic"
        case vehiclePicAbsoluteURL = "vehicle_pic_absolute_url"
        case vehicleType = "vehicle_type"
        case vehicleTypeID = "vehicle_type_id"
    }
}


