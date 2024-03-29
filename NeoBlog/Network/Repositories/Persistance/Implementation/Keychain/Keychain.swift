//
//  Keychain.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 03/02/24.
//

import Foundation

class Keychain {

  // MARK: - Methods
  static func findItem(query: KeychainItemQuery) throws -> Data? {
    var queryResult: AnyObject?
    let status = withUnsafeMutablePointer(to: &queryResult) {
      SecItemCopyMatching(query.asDictionary(), UnsafeMutablePointer($0))
    }

    if status == errSecItemNotFound {
      return nil
    }
    guard status == noErr else {
      throw KeychainUserSessionDataStoreError.unknown
    }
    guard let itemData = queryResult as? Data else {
      throw KeychainUserSessionDataStoreError.typeCast
    }

    return itemData
  }

  static func save(item: KeychainItemWithData) throws {
    let status = SecItemAdd(item.asDictionary(), nil)
    guard status == noErr else {
      throw KeychainUserSessionDataStoreError.unknown
    }
  }

  static func update(item: KeychainItemWithData) throws {
    let status = SecItemUpdate(item.attributesAsDictionary(), item.dataAsDictionary())
    guard status == noErr else {
      throw KeychainUserSessionDataStoreError.unknown
    }
  }

  static func delete(item: KeychainItem) throws {
    let status = SecItemDelete(item.asDictionary())
    guard status == noErr || status == errSecItemNotFound else {
      throw KeychainUserSessionDataStoreError.unknown
    }
  }
}
