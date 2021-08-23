import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}

protocol SessionProtocol {
  func dataTask(
    with url: URL,
    completionHandler: @escaping
    (Data?, URLResponse?, Error?) -> Void)
    -> URLSessionDataTask

    func dataTask(
        with url: URLRequest,
        completionHandler: @escaping
            (Data?, URLResponse?, Error?) -> Void)
            -> URLSessionDataTask
}

extension URLSession: SessionProtocol {}

enum WebserviceError : Error {
  case DataEmptyError
}

protocol APIClient {
    var httpClient: HttpClient { get set }
}

protocol ViewFactoring {
    static func generateView(viewController: UIViewController) throws -> UIView?
}
