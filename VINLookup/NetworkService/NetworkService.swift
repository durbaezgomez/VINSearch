//
//  NetworkService.swift
//  VINLookup
//
//  Created by Dominik Urbaez Gomez on 06/12/2024.
//

import Foundation
import OSLog

class NetworkService {
    enum APIMethod: String {
        case get = "GET"
    }
    
    private let session: URLSession
    private let logger = Logger(subsystem: "VINLookup", category: "Network Service")
    private let timeout: TimeInterval = 10 // 10 seconds timeout
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func performRequest<T: Decodable>(
        url: URL,
        endpoint: String,
        method: APIMethod = .get,
        headers: [String: String]? = nil,
        params: [String: String]? = nil,
        body: Data? = nil
    ) async throws -> T {
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw URLError(.badURL)
        }
        
        if let params {
            components.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let finalURL = components.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        request.setValue(Configuration.apiKey, forHTTPHeaderField: "X-Api-Key")
        request.timeoutInterval = timeout
        
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        
        if let body {
            request.httpBody = body
        }
        
        logger.debug("Performing \(method.rawValue) request to \(finalURL.absoluteString)")
        
        let task = Task {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                logger.error("Invalid response type received")
                throw URLError(.badServerResponse)
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                logger.error("Request failed with status code: \(httpResponse.statusCode)")
                throw URLError(.badServerResponse)
            }
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                logger.debug("Successfully decoded response")
                return decoded
            } catch {
                throw error
            }
        }
        
        return try await withTimeout(task, timeout: timeout)
    }
    
    private func withTimeout<T>(_ task: Task<T, Error>, timeout: TimeInterval) async throws -> T {
        try await withThrowingTaskGroup(of: T.self) { group in
            group.addTask {
                try await task.value
            }
            
            group.addTask {
                try await Task.sleep(nanoseconds: UInt64(timeout * 1_000_000_000))
                throw TimeoutError()
            }
            
            let result = try await group.next()!
            group.cancelAll()
            return result
        }
    }
}
