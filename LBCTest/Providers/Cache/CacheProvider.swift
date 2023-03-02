//
//  CacheProvider.swift
//  LBCTest
//
//  Created by Jeromin Lebon on 28/02/2023.
//

import Foundation

protocol CacheProviderProtocol {
    func set(object: AnyObject, for path: String)
    func get(path: String) -> AnyObject?
}

class CacheProvider: CacheProviderProtocol {
    lazy var cache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100
        return cache
    }()

    func set(object: AnyObject, for path: String) {
        cache.setObject(object, forKey: path as AnyObject)
    }

    func get(path: String) -> AnyObject? {
        let cachedObject = cache.object(forKey: path as AnyObject)
        return cachedObject
    }
}

private struct CacheProviderKey: InjectionKey {
    static var currentValue: CacheProviderProtocol = CacheProvider()
}

extension InjectedValues {
    var cacheProvider: CacheProviderProtocol {
        get { Self[CacheProviderKey.self] }
        set { Self[CacheProviderKey.self] = newValue }
    }
}
