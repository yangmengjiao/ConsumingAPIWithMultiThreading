//
//  CovidTrackingEndpoint.swift
//  ConsumingAPIWithMultiThreading
//
//  Created by mengjiao on 12/23/20.
//

import Foundation

/// Endpoints configurition for CovidTracking
/// add more cases in the future as need
enum CovidTrackingEndpoint: Endpoint {
    case getDailyList
    case getTimeseriesList
    case getAllDataList
    
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
    
    var baseURL: String {
        switch self {
        case .getDailyList:
            return "api.covidtracking.com"
        case .getTimeseriesList:
            return "pomber.github.io"
        case .getAllDataList:
            return "api.covid19india.org"
        }
    }
    
    
    var path: String {
        switch self {
        case .getDailyList:
            return "/v1/states/daily.json"
        case .getTimeseriesList:
            return "/covid19/timeseries.json"
        case .getAllDataList:
            return "/v4/data-all.json"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        default:
            return []
        }
    }
    
    var method: String {
        switch self {
        default:
            return "GET"
        }
    }
}
