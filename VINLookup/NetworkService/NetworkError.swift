//
//  NetworkError.swift
//  VINLookup
//
//  Created by Dominik Urbaez Gomez on 06/12/2024.
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case serverSide
    case generic
    case timeout
}
