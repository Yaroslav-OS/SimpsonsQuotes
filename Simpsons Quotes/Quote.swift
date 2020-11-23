//
//  Quote.swift
//  SimpsonsQuotes
//
//  Created by Yaroslav on 11.10.2020.
//  Copyright © 2020 Yaroslav. All rights reserved.
//

import Foundation

struct Quote: Decodable {
    let quote: String
    let character: String
    let image: String
}
