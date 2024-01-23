import XCTest
@testable import UserDefault

final class UserDefaultTests: XCTestCase {
    private let key = "test"
    private var sut: UserDefaultImplementation!
    private let object = MockObject()

    override func setUp() {
        sut = UserDefaultImplementation(suiteName: key)
        sut.removePersistentDomain(forName: key)
    }

    override func tearDown() {
        sut = nil
    }

    func testSaveInformation_whenInsertString_shouldReturnString() throws {
        let informationToSave = "just a test"

        sut?.saveInformation(informationToSave)
        let string: String = try getObject()
        XCTAssertEqual(string, informationToSave)
    }

    func testSaveInformation_whenInsertAnObject_shouldReturnObject() throws {
        sut?.saveInformation(object)
        let objectReturn: MockObject = try getObject()
        XCTAssertEqual(objectReturn, object)
    }

    func testGetListInformation_whenInsertObject() {
        sut?.set(Data.convertToData(object), forKey: key)
        guard let result: MockObject = sut.getListInformation() else {
            XCTFail()
            return
        }

        XCTAssertEqual(result, object)
    }

    func testGetListInformation_whenInsertObjectlist() {
        let objectList = [object, object, object]

        sut?.set(Data.convertToData(objectList), forKey: key)
        guard let result: [MockObject] = sut.getListInformation() else {
            XCTFail()
            return
        }

        XCTAssertEqual(result, objectList)
    }

    func testGetListInformation_whenThereIsNoData_shouldReturnNil() {
        guard let _: MockObject = sut.getListInformation() else {
            return
        }
        XCTFail()
    }

    private func getObject<T:Codable>() throws -> T  {
        let data = sut?.object(forKey: key) as? Data
        let object: T! = data?.convertToObject()
        return object
    }
}
