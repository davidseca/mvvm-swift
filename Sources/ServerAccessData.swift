//
//  ServerAccessData.swift
//  MVVMSwift
//
//  Created by David Seca on 14.07.22.
//  Copyright (c) 2022 David Seca. All rights reserved.
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
