//
//  GithubAPI.swift
//  MyFirstAPI
//
//  Created by 小島満天 on 2020/07/20.
//  Copyright © 2020 Manchen. All rights reserved.
//

import Foundation
import APIKit

protocol GithubAPI: Request { }

extension GithubAPI {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
}

extension GithubAPI where Response: Decodable {
    var dataParser: DataParser {
        return DecodableDataParser()
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let data = object as? Data else {
            throw ResponseError.unexpectedObject(object)
        }
        return try JSONDecoder().decode(Response.self, from: data)
    }
}
