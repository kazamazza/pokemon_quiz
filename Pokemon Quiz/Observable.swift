import Foundation

class Observable<Type> {
    typealias Observer = (Type) -> ()
    typealias Token = NSObjectProtocol

    private var observers = [(Token, Observer)]()

    var value: Type? {
        didSet {
            notify()
        }
    }

    init() {}

    @discardableResult
    func bind(_ observer: @escaping Observer) -> Token {
        let obj = NSObject()
        observers.append((obj, observer))
        return obj
    }

    func unbind(_ token: Token) {
        observers.removeAll { $0.0.isEqual(token) }
    }

    private func notify() {
        guard let value = value else {return}
        observers.forEach { (_, observer) in
            observer(value)
        }
    }
}
