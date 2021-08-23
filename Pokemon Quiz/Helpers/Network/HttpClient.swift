import Foundation

class HttpClient {
    
    lazy var session: SessionProtocol = URLSession.shared
    
    func get(url: URL, completion: @escaping (Data?, Error?) -> ()) {
        session.dataTask(with: url) {data, response, error in
            completion(data, error)
        }.resume()
    }
    
    func post(url: URL, body: [String: Any], completion: @escaping (Data?, Error?) -> ()) {
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        session.dataTask(with: request) {data, response, error in
            completion(data, error)
        }.resume()
    }
}
