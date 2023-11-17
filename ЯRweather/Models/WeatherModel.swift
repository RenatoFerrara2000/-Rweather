//
//  WeatherModel.swift
//  ЯRweather
//
//  Created by Renato Ferrara on 14/11/23.
//

import Foundation
import SwiftUI


struct WeatherData: Decodable {

  var latitude             : Double?      = nil
  var longitude            : Double?      = nil
  var generationtimeMs     : Double?      = nil
  var utcOffsetSeconds     : Int?         = nil
  var timezone             : String?      = nil
  var timezoneAbbreviation : String?      = nil
  var elevation            : Int?         = nil
  var hourlyUnits          : HourlyUnits? = HourlyUnits()
  var hourly               : Hourly?      = Hourly()
  var dailyUnits           : DailyUnits?  = DailyUnits()
  var daily                : Daily?       = Daily()

  enum CodingKeys: String, CodingKey {

    case latitude             = "latitude"
    case longitude            = "longitude"
    case generationtimeMs     = "generationtime_ms"
    case utcOffsetSeconds     = "utc_offset_seconds"
    case timezone             = "timezone"
    case timezoneAbbreviation = "timezone_abbreviation"
    case elevation            = "elevation"
    case hourlyUnits          = "hourly_units"
    case hourly               = "hourly"
    case dailyUnits           = "daily_units"
    case daily                = "daily"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    latitude             = try values.decodeIfPresent(Double.self      , forKey: .latitude             )
    longitude            = try values.decodeIfPresent(Double.self      , forKey: .longitude            )
    generationtimeMs     = try values.decodeIfPresent(Double.self      , forKey: .generationtimeMs     )
    utcOffsetSeconds     = try values.decodeIfPresent(Int.self         , forKey: .utcOffsetSeconds     )
    timezone             = try values.decodeIfPresent(String.self      , forKey: .timezone             )
    timezoneAbbreviation = try values.decodeIfPresent(String.self      , forKey: .timezoneAbbreviation )
    elevation            = try values.decodeIfPresent(Int.self         , forKey: .elevation            )
    hourlyUnits          = try values.decodeIfPresent(HourlyUnits.self , forKey: .hourlyUnits          )
    hourly               = try values.decodeIfPresent(Hourly.self      , forKey: .hourly               )
    dailyUnits           = try values.decodeIfPresent(DailyUnits.self  , forKey: .dailyUnits           )
    daily                = try values.decodeIfPresent(Daily.self       , forKey: .daily                )
 
  }

  init() {

  }

}

struct HourlyUnits: Codable {

  var time                     : String? = nil
  var temperature2m            : String? = nil
  var precipitationProbability : String? = nil
  var weatherCode              : String? = nil

  enum CodingKeys: String, CodingKey {

    case time                     = "time"
    case temperature2m            = "temperature_2m"
    case precipitationProbability = "precipitation_probability"
    case weatherCode              = "weather_code"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    time                     = try values.decodeIfPresent(String.self , forKey: .time                     )
    temperature2m            = try values.decodeIfPresent(String.self , forKey: .temperature2m            )
    precipitationProbability = try values.decodeIfPresent(String.self , forKey: .precipitationProbability )
    weatherCode              = try values.decodeIfPresent(String.self , forKey: .weatherCode              )
 
  }

  init() {

  }

}



struct Hourly: Codable {

  var time                     : [String]? = []
  var temperature2m            : [Double]? = []
  var precipitationProbability : [Int]?    = []
  var weatherCode              : [Int]?    = []

  enum CodingKeys: String, CodingKey {

    case time                     = "time"
    case temperature2m            = "temperature_2m"
    case precipitationProbability = "precipitation_probability"
    case weatherCode              = "weather_code"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    time                     = try values.decodeIfPresent([String].self , forKey: .time                     )
    temperature2m            = try values.decodeIfPresent([Double].self , forKey: .temperature2m            )
    precipitationProbability = try values.decodeIfPresent([Int].self    , forKey: .precipitationProbability )
    weatherCode              = try values.decodeIfPresent([Int].self    , forKey: .weatherCode              )
 
  }

  init() {

  }

}



struct DailyUnits: Codable {

  var time        : String? = nil
  var weatherCode : String? = nil

  enum CodingKeys: String, CodingKey {

    case time        = "time"
    case weatherCode = "weather_code"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    time        = try values.decodeIfPresent(String.self , forKey: .time        )
    weatherCode = try values.decodeIfPresent(String.self , forKey: .weatherCode )
 
  }

  init() {

  }

}

struct Daily: Codable {

  var time        : [String]? = []
  var weatherCode : [Int]?    = []

  enum CodingKeys: String, CodingKey {

    case time        = "time"
    case weatherCode = "weather_code"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    time        = try values.decodeIfPresent([String].self , forKey: .time        )
    weatherCode = try values.decodeIfPresent([Int].self    , forKey: .weatherCode )
 
  }

  init() {

  }

}

struct dailyDataValues:Identifiable {
    var id = UUID()
    var datiTempo: [dataWeather]

    init() {
        self.datiTempo = []
    }
    

}
struct dataWeather: Identifiable {
       let id = UUID()
       var time: String
       var temperatura: Double
       var weatherCode: Double
        
}

