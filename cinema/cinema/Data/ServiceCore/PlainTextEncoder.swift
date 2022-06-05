//
//  PlainTextEncoder.swift
//  cinema
//
//  Created by Jesus Alejandro Pablo Ojeda on 05/06/22.
//
import Alamofire
struct PlainTextEncoder: ParameterEncoder {
    func encode<Parameters>(_ parameters: Parameters?, into urlRequest: URLRequest) throws -> URLRequest where Parameters : Encodable {
        var request = try JSONParameterEncoder.default.encode(parameters, into: urlRequest)
        if let body = request.httpBody, let httpBody = NSString(data: body, encoding: String.Encoding.utf8.rawValue) {
            request.httpBody = httpBody
                .replacingOccurrences(of: ":", with: "=")
                .replacingOccurrences(of: "{", with: "")
                .replacingOccurrences(of: "}", with: "")
                .replacingOccurrences(of: ",", with: "&")
                .replacingOccurrences(of: "\"", with: "")
                .data(using: .utf8)
            request.headers["Content-Type"]="text/plain"
        }
        return request
    }
}
