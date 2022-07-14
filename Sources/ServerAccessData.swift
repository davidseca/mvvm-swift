//
//  ServerAccessData.swift
//  MVPSwift
//
//  Created by David Seca on 15.04.20.
//  Copyright © 2020 David Seca. All rights reserved.
//

import Foundation

// TODO: If needed add ServerConfiguration enum for ex. test, production, staging,... enviroments
// hard-coded initial endpoints
enum BankAPI {
    case accounts

    var url: String {
        switch self {
        case .accounts: return "https://accounts"
        }
    }
}
