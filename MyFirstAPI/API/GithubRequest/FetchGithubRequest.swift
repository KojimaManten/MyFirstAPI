//
//  FetchGithubRequest.swift
//  MyFirstAPI
//
//  Created by 小島満天 on 2020/07/20.
//  Copyright © 2020 Manchen. All rights reserved.
//

import Foundation
import APIKit

struct FetchGithubRequest: GithubAPI {
    var path: String {
        return "/users"
    }
    
    var baseURL: URL
    
    typealias Response = [Informations]
    
    var method: HTTPMethod {
        return .get
    }
    
}
