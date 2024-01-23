import Foundation

final class UserDefaultImplementation: UserDefaults {
    private var key: String

    override init?(suiteName: String?) {
        guard let suiteName else {
            fatalError("Cannot find suiteName")
        }
        
        key = suiteName
        super.init(suiteName: suiteName)
    }

    @discardableResult
    func saveInformation(_ information: Codable) -> Bool {
        guard let data = Data.convertToData(information) else {
            return false
        }

        self.set(data, forKey: key)
        return true
    }

    func getListInformation<T:Codable>() -> T? {
        guard let data = self.object(forKey: key) as? Data else {
            return nil
        }

        let object: T? = data.convertToObject()
        return object
    }
}
