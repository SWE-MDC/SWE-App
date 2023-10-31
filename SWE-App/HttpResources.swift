//
//  HttpResources.swift
//  SWE-App
//
//  Created by Liang Geng on 10/17/23.
//

import Foundation

struct HttpResources {
    static var url_base = "http://hp.gengl.me:8081"
    static var url_login = url_base + "/api/v1/auth/signin"
    static var url_signup = url_base + "/api/v1/auth/signup"
    static var url_list_events = url_base + "/api/v1/resource/event/get"
    
    static func prepareGetRequest(s_url: String,
                                  token: String) -> URLRequest {
        // create post request
        let url = URL(string: s_url)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        return request
    }
    
    static func preparePostRequest(s_url: String, json: [String:Any]) -> URLRequest {
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        // create post request
        let url = URL(string: s_url)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // insert json data to the request
        request.httpBody = jsonData
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")  // the request is JSON
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")        // the
        return request
    }
}
