//
//  NetworkManager.swift
//  awesome-q42
//
//  Created by vladimir.kuzomenskyi on 15.09.2023.
//

import Combine
import UIKit

final class NetworkManager: NSObject {
    // MARK: Private Constant
    private let checkerURLString = "https://jideltdapp.info"
    
    // MARK: Private Variable
    private var progressHandler: ((Float) -> Void)?
    private var completionHandler: ((URL) -> Void)?
    private var errorCompletion: ((Error) -> Void)?
    
    private lazy var session: URLSession = .init(configuration: .default, delegate: self, delegateQueue: .main)
    
    // MARK: Function
    func checkWebsite(_ address: String) async throws -> WebsiteCheckResponse? {
        guard let domainName = getDomainName(from: address) else {
            throw CustomError.invalidWebsiteAddress
        }
        return try await checkDomain(domainName)
    }
    
    func getDomainName(from url: String) -> String? {
        if let url = URL(string: url), let host = url.host {
            if host.hasPrefix("www.") {
                let string = String(host.dropFirst(4))
                let components = string.components(separatedBy: ".")
                return components[0]
            } else {
                let components = host.components(separatedBy: ".")
                return components[0]
            }
        }
        return url.components(separatedBy: ".").first
    }
    
    // MARK: Private Function
    
    /// Checks the website for leaks
    /// - Parameter address:  String in format "jefit" instead of "https://www.jefit.com" etc.
    /// - Returns: Nil if safe. Otherwise, WebsiteCheckResponse instance that contains the info about the leak
    private func checkDomain(_ address: String) async throws -> WebsiteCheckResponse? {
        var components = URLComponents(string: "https://haveibeenpwned.com/api/v3/breach/\(address)")
        components!.queryItems = [.init(name: "Add-Padding", value: "true")]
        let url = components!.url!

        var request: URLRequest = .init(url: url)
        request.addValue("578ae2e2c38d44649b98fa6a6256e5bc", forHTTPHeaderField: "hibp-api-key")
        request.addValue("Mozilla/5.0", forHTTPHeaderField: "User-agent")
        request.addValue("*/*", forHTTPHeaderField: "Accept")
        
        return try await withCheckedThrowingContinuation { continuation in
            URLSession.shared.dataTask(with: request) { data, _, error in
                guard error == nil else {
                    continuation.resume(throwing: error!)
                    return
                }
                
                guard let data else {
                    continuation.resume(throwing: CustomError("Failed to get response for the request. Data is nil"))
                    return
                }
                
                do {
                    let info = try JSONDecoder().decode(WebsiteCheckResponse.self, from: data)
                    continuation.resume(returning: info)
                } catch DecodingError.dataCorrupted {
                    continuation.resume(returning: nil)
                } catch {
                    continuation.resume(throwing: error)
                }
            }.resume()
        }
    }
}

// MARK: - URLSessionDelegate, URLSessionDownloadDelegate
extension NetworkManager: URLSessionDelegate, URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        let url = location
        let error = downloadTask.error
        guard error == nil else {
            self.errorCompletion?(error!)
            return
        }
        
        let outputURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("output.zip")
        
        if FileManager.default.fileExists(atPath: outputURL.path) {
            do {
                try FileManager.default.removeItem(atPath: outputURL.path)
            } catch {
                self.errorCompletion?(error)
            }
        }
        
        do {
            try FileManager.default.copyItem(at: url, to: outputURL)
        } catch {
            self.errorCompletion?(error)
        }
        completionHandler?(outputURL)
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let progress = Float(totalBytesWritten)/Float(totalBytesExpectedToWrite)
        progressHandler?(progress)
    }
}

