//
//  CurrencyResult.swift
//  WalletApp
//

import Foundation

// MARK: - Valute
struct Valute: Decodable {
    let id, numCode, charCode: String
    let nominal: Int
    let name: String
    let value, previous: Double

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case numCode = "NumCode"
        case charCode = "CharCode"
        case nominal = "Nominal"
        case name = "Name"
        case value = "Value"
        case previous = "Previous"
    }
}

// MARK: - Currency
struct ValuteResult: Decodable {
    let result: [String: Valute]

    enum CodingKeys: String, CodingKey {
        case result = "Valute"
    }
}
