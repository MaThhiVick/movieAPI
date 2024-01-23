//
//  BundleMock.swift
//  MovieAPITests
//
//  Created by Matheus Vicente on 18/12/23.
//

import Foundation

class BundleMock: Bundle {
    var shouldReturnNil = false
    var shouldReturnString = false
    var dictToReturn = [String: Any]()

    override func object(forInfoDictionaryKey key: String) -> Any? {
        if shouldReturnNil {
            return nil
        }
        
        if shouldReturnString {
            return "test"
        }

        return dictToReturn
    }
}
