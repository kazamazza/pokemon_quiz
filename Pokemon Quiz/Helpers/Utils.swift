import Foundation

func classFromString(_ className: String) -> AnyClass! {
    let namespace = (Bundle.main.infoDictionary!["CFBundleExecutable"] as! String).replacingOccurrences(of: " ", with: "_")
    let cls: AnyClass = NSClassFromString("\(namespace).\(className)")!
    return cls
}
