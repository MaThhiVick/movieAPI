import Foundation

extension Data {
    static func convertToData(_ information: Codable) -> Data? {
        let result = try? JSONEncoder().encode(information)
        return result
    }

    func convertToObject<T:Codable>() -> T? {
        let result: T? = try? JSONDecoder().decode(T.self, from: self)
        return result
    }
}
