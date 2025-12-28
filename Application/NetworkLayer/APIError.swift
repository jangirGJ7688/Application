//
//  APIError.swift
//  Application
//
//  Created by Ganpat Jangir on 28/12/25.
//


import Foundation

enum APIError: LocalizedError {
    case noInternet
    case invalidURL
    case requestFailed
    case invalidResponse
    case decodingError
    case serverError(Int)

    var errorDescription: String? {
        switch self {
        case .noInternet:
            return "No internet connection"
        case .invalidURL:
            return "Invalid URL"
        case .requestFailed:
            return "Request failed. Please try again."
        case .invalidResponse:
            return "Invalid server response"
        case .decodingError:
            return "Unable to process data"
        case .serverError(let code):
            return "Server error (\(code))"
        }
    }
}
