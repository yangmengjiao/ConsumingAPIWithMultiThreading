//
//  AllCovidData.swift
//  ConsumingAPIWithMultiThreading
//
//  Created by mengjiao on 12/23/20.
//

import Foundation


struct AllCovidData: Codable {
    let delta: Delta?
}

// MARK: - Delta
struct Delta: Codable {
    let confirmed: Int?
}

struct StateData: Codable {
    var districtData: [String:DistrictData]?
}

struct DistrictData: Codable {
    var confirmed: Int?
    var lastupdatedtime: String?
    var delta: DailyConfirmedData?
}

struct DailyConfirmedData: Codable {
    var confirmed: Int?
}
