import Foundation
import BrightFutures

protocol HTTP {
    func get(_ path: String, forLine busLine: String) -> Future<Data?, NSError>
    func get(_ path: String, withQuery queries: [String: String]) -> Future<Data?, NSError>
}

class KuruyoHTTP: HTTP {
    let host: String = "kuruyo.cfapps.io"

    func get(_ path: String, withQuery queries: [String: String]) -> Future<Data?, NSError> {
        let promise = Promise<Data?, NSError>()

        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path

        var queryList = [URLQueryItem]()
        for (key, value) in queries {
            queryList.append(URLQueryItem(name: key, value: value))
        }
        urlComponents.queryItems = queryList

        guard let url = urlComponents.url else {
            let error = NSError(domain: "Could not create a URL from components", code: 0, userInfo: nil)
            promise.failure(error)
            return promise.future
        }

        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let data = data {
                promise.success(data)
            }
        })
        task.resume()

        return promise.future
    }

    func get(_ path: String, forLine busLine: String) -> Future<Data?, NSError> {
        let promise = Promise<Data?, NSError>()

        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = [URLQueryItem(name: "line", value: busLine)]

        guard let url = urlComponents.url else {
            let error = NSError(domain: "Could not create a URL from components", code: 0, userInfo: nil)
            promise.failure(error)
            return promise.future
        }

        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let data = data {
                promise.success(data)
            }
        })
        task.resume()

        return promise.future
    }
}
