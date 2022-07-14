//
//  NetworkManager.swift
//  MVVMSwift
//
//  Created by David Seca on 14.07.22.
//  Copyright (c) 2022 David Seca. All rights reserved.
//

import Alamofire

public enum Content: String {
    case accounts
}

public class NetworkManager: NetworkManagerProtocol {

    static let sharedInstance = NetworkManager()

    private static let defaultTimeout: TimeInterval = 10

    private init() { }

    public func getContent(content: Content, completion: @escaping ((Data?, Bool) -> ())) {
        switch content {
        case .accounts: self.getAccountsData(completion: completion)
        }
    }

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

public protocol NetworkManagerProtocol {

    func getContent(content: Content, completion: @escaping ((Data?, Bool) -> ()))

}
