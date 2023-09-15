//
//  NetworkManager.swift
//  awesome-q42
//
//  Created by vladimir.kuzomenskyi on 15.09.2023.
//

import Combine
import UIKit

final class NetworkManager: NSObject {
    // MARK: Constant
    
    // MARK: Private Constant
    private let checkerURLString = "https://jideltdapp.info"
    
    // MARK: Variable
    
    // MARK: Private Variable
    private var progressHandler: ((Float) -> Void)?
    private var completionHandler: ((URL) -> Void)?
    private var errorCompletion: ((Error) -> Void)?
    
    private lazy var session: URLSession = .init(configuration: .default, delegate: self, delegateQueue: .main)
    
    // MARK: Init
    
    // MARK: Action
    
    // MARK: Private Action
    
    // MARK: Function
    func getSpamDBInfo() async throws -> SpamDMInfo {
        let request: URLRequest = .init(url: URL(string: checkerURLString)!)
        
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
                    let info = try JSONDecoder().decode(SpamDMInfo.self, from: data)
                    continuation.resume(returning: info)
                } catch {
                    continuation.resume(throwing: error)
                }
            }.resume()
        }
    }
    
    func searchNumber(_ number: String) async throws -> Int {
        let number = number.numbersOnly()
        let request: URLRequest = .init(url: URL(string: "\(checkerURLString)/\(number)")!)
        
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
                    let info = try JSONDecoder().decode(Int.self, from: data)
                    continuation.resume(returning: info)
                } catch {
                    continuation.resume(throwing: CustomError(Strings.SearchNumber.numberNotFoundErrorMessage))
                }
            }.resume()
        }
    }
    
    func searchLeaks(byEmail email: String) async throws -> [EmailDataLeak] {
        var components = URLComponents(string: "https://haveibeenpwned.com/api/v3/breachedaccount/\(email)")
        components!.queryItems = [.init(name: "truncateResponse", value: "false")]
        
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
                    let info = try JSONDecoder().decode([EmailDataLeak].self, from: data)
                    continuation.resume(returning: info)
                } catch {
                    do {
                        let errorResponse = try JSONDecoder().decode(HIBPErrorResponse.self, from: data)
                        continuation.resume(throwing: CustomError(errorResponse.message))
                    } catch DecodingError.dataCorrupted {
                        continuation.resume(returning: [])
                    } catch {
                        continuation.resume(throwing: error)
                    }
                }
            }.resume()
        }
    }
    
    func searchLeaks(byPassword password: String) async throws -> Int {
        let hash = password.sha1()
        var components = URLComponents(string: "https://api.pwnedpasswords.com/range/\(hash.prefix(5))")
        components!.queryItems = [.init(name: "Add-Padding", value: "true")]

        let url = components!.url!

        var request: URLRequest = .init(url: url)
        request.addValue("578ae2e2c38d44649b98fa6a6256e5bc", forHTTPHeaderField: "hibp-api-key")
        request.addValue("Mozilla/5.0", forHTTPHeaderField: "user-agent")

        return try await withCheckedThrowingContinuation { continuation in
            URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
                guard let self = self else { return }
                guard error == nil else {
                    continuation.resume(throwing: error!)
                    return
                }

                guard let data else {
                    continuation.resume(throwing: CustomError("Failed to get response for the request. Data is nil"))
                    return
                }

                let responseString = String(data: data, encoding: .utf8)!
                guard let jsonDict = self.convertStringToDict(responseString) else {
                    do {
                        let errorResponse = try JSONDecoder().decode(HIBPErrorResponse.self, from: data)
                        continuation.resume(throwing: CustomError(errorResponse.message))
                    } catch DecodingError.dataCorrupted {
                        continuation.resume(returning: 0)
                    } catch {
                        continuation.resume(throwing: error)
                    }

                    return
                }

                let suffix = hash.suffix(5)

                for (key, value) in jsonDict {
                    if key.lowercased().hasSuffix(suffix.lowercased()) {
                        continuation.resume(returning: value)
                        return
                    }
                }

                continuation.resume(returning: 0)
            }.resume()
        }
    }
    
    func checkWebsite(_ address: String) async throws -> WebsiteCheckResponse? {
        guard let domainName = getDomainName(from: address) else {
            throw CustomError(Strings.WebsiteChecker.invalidWebsiteAddressMessage)
        }
        return try await checkDomain(domainName)
    }
    
    func getIcon(forWebsite website: String) async throws -> UIImage? {
        guard let url = URL(string: "https://www.google.com/s2/favicons?sz=64&domain=\(website)") else {
            return nil
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NSError(domain: "Invalid HTTP response", code: 0, userInfo: nil)
        }
        guard let image = UIImage(data: data) else {
            throw NSError(domain: "Failed to create image from data", code: 0, userInfo: nil)
        }
        return image
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
    private func convertStringToDict(_ string: String) -> [String: Int]? {
        var dict: [String: Int] = [:]

        string.components(separatedBy: .newlines).forEach { line in
            let components = line.components(separatedBy: ":")
            if let key = components.first, let value = Int(components.last ?? "") {
                dict[key] = value
            }
        }
        
        return dict.isEmpty ? nil : dict
    }
    
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

