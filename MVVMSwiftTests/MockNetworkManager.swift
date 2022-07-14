//
//  MockNetworkManager.swift
//  MVVMSwiftTests
//
//  Created by David Seca on 14.07.22.
//  Copyright (c) 2022 David Seca. All rights reserved.
//

import XCTest

@testable import MVVMSwift

class MockNetworkManager: NetworkManagerProtocol {
    func getContent(content: Content, completion: @escaping ((Data?, Bool) -> ())) {
        let resource: String
        switch(content) {
        case .accounts: resource = "accounts-test-data"
        }

        let json = getJsonFromFile(resource)
        return completion(json, true)
    }

    private func getJsonFromFile(_ resource: String) -> Data? {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: resource, withExtension: "json") else {
            XCTFail("Missing file: \(resource).json")
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
