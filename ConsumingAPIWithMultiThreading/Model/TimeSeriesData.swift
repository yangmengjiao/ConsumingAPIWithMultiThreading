//
//  TimeSeriesData.swift
//  ConsumingAPIWithMultiThreading
//
//  Created by mengjiao on 12/23/20.
//

import Foundation


struct TimeSeriesData: Codable {
    let Afghanistan: [AfghanistanData]
}

struct AfghanistanData: Codable {
    let date: String
    let deaths: Int
}
