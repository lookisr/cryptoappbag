//
//  Tickers.swift
//  cryptobag
//
//  Created by Rafael Shamsutdinov on 22.04.2023.
//

import Foundation

public struct Ticker: Decodable {
    
    public var totals:Double!
    
    /// Coin id, eg. btc-bitcoin
    public let id: String
        
    /// Coin name, eg. Bitcoin
    public let name: String
    
    /// Coin logo, eg. Bitcoin
    public var logo: String?
    
    /// Coin symbol, eg. BTC
    public let symbol: String
    
    /// Coin position in Coinpaprika ranking
    public let rank: Int
    
    /// Coins circulating on the market
    public let circulatingSupply: Decimal?
    
    /// Total number of coins
    public let totalSupply: Decimal
    
    /// Maximum number of coins that could exist
    public let maxSupply: Decimal
    
    /// Circulating Supply / Max Supply Rate
    public var circulatingSupplyPercent: Decimal? {
        guard maxSupply != 0 else {
            return nil
        }
        
        return (circulatingSupply ?? 1000000)/maxSupply
    }
    
    public let betaValue: Decimal
    
    /// Last update time
    public let lastUpdated: String
    
    public let quotes: [String: Quote]
    
    enum CodingKeys: String, CodingKey {
        case totals
        case id
        case name
        case symbol
        case rank
        case logo
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case betaValue = "beta_value"
        case lastUpdated = "last_updated"
        case quotes
    }
    
    /// Coin market data
    public struct Quote: Codable, Equatable {
        
        /// Price
        public var price: Double
        
        /// Volume from last 24h
        public let volume24h: Decimal
        
        /// Volume change in last 24h
        public let volume24hChange24h: Decimal
        
        /// Market capitalization
        public let marketCap: Decimal
        
        /// Market capitalization change in last 24h
        public let marketCapChange24h: Decimal
        
        /// Percentage price change in last 1 hour
        public let percentChange1h: Decimal
        
        /// Percentage price change in last 12 hours
        public let percentChange12h: Decimal
        
        /// Percentage price change in last 24 hours
        public let percentChange24h: Decimal
        
        /// Percentage price change in last 7 days
        public let percentChange7d: Decimal
        
        /// Percentage price change in last 30 days
        public let percentChange30d: Decimal
        
        /// Percentage price change in last 1 yours
        public let percentChange1y: Decimal
        
        /// ATH (All Time High) price
        public let athPrice: Decimal?
        
        /// ATH (All Time High) date
        public let athDate: String?
        
        /// Percentage price change from ATH
        public let percentFromPriceAth: Decimal?
        
        /// Volume / MarketCap rate
        public var volumeMarketCapRate: Decimal? {
            guard marketCap != 0 else {
                return nil
            }
            
            return volume24h/marketCap * 100
        }
        
        enum CodingKeys: String, CodingKey {
            case price
            case volume24h = "volume_24h"
            case volume24hChange24h = "volume_24h_change_24h"
            case marketCap = "market_cap"
            case marketCapChange24h = "market_cap_change_24h"
            case percentChange1h = "percent_change_1h"
            case percentChange12h = "percent_change_12h"
            case percentChange24h = "percent_change_24h"
            case percentChange7d = "percent_change_7d"
            case percentChange30d = "percent_change_30d"
            case percentChange1y = "percent_change_1y"
            case athPrice = "ath_price"
            case athDate = "ath_date"
            case percentFromPriceAth = "percent_from_price_ath"
        }
    }
}
struct BasicCurrencyInfo {
    let name: String
    let symbol: String
    let logo: String
    let price: String
    let change1d: String
}
