//
//  NetworkManager.swift
//  MVVMSwift
//
//  Created by David Seca on 14.07.22.
//  Copyright (c) 2022 David Seca. All rights reserved.
//

import Alamofire

/// Content sections to be loaded
public enum Content: String {
    case accounts
}

/// Low level Network service to get data from servers
public class NetworkManager: NetworkManagerProtocol {

    /// Shared instace
    static let sharedInstance = NetworkManager()

    /// Trying timeout
    private static let defaultTimeout: TimeInterval = 10

    /// Private constructor
    private init() { }

    // NetworkManagerProtocol API
    public func getContent(content: Content, completion: @escaping ((Data?, Bool) -> ())) {
        switch content {
        case .accounts: self.getAccountsData(completion: completion)
        }
    }

    /// Get accounts data
    /// - parameters:
    ///    - completion: Callback with optional Data and Boolean inficating if service is offline
    private func getAccountsData(completion: @escaping ((Data?, Bool) -> ())) {
        let data = self.getJsonDataFromFile("Accounts")
        completion(data, false)
    }

    // For testing purposes
    // NB: Replace with getData() ex. using Alamofire
    private func getJsonDataFromFile(_ resource: String) -> Data? {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: resource, withExtension: "json") else {
            return nil
        }
        var json = Data()
        do {
            json = try Data(contentsOf: url)
        } catch {

        }
        print(json)

        return json
    }

}

/// Protocol for NetworkManager for  testing purposes
public protocol NetworkManagerProtocol {

    /// Get content data
    /// - parameters:
    ///    - content: Content section to be loaded
    ///    - completion: Callback with optional Data and Boolean inficating if service is offline
    func getContent(content: Content, completion: @escaping ((Data?, Bool) -> ()))

}
