//
//  CodableDefault.swift
//  iTunesMusicMain
//
//  Created by Andy on 2022/3/15.
//

import Foundation

@propertyWrapper
public struct Default<Provider: ValueProver>: Codable {
    public var wrappedValue: Provider.Value

    public init() {
        wrappedValue = Provider.default
    }

    public init(wrappedValue: Provider.Value) {
        self.wrappedValue = wrappedValue
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if container.decodeNil() {
            wrappedValue = Provider.default
        } else {
            wrappedValue = try container.decode(Provider.Value.self)
        }
    }
}

extension Default: Equatable where Provider.Value: Equatable {}
extension Default: Hashable where Provider.Value: Hashable {}

public extension KeyedDecodingContainer {
    func decode<P>(_: Default<P>.Type, forKey key: Key) throws -> Default<P> {
        if let value = try decodeIfPresent(Default<P>.self, forKey: key) {
            return value
        } else {
            return Default()
        }
    }
}

public extension KeyedEncodingContainer {
    mutating func encode<P>(_ value: Default<P>, forKey key: Key) throws {
        guard value.wrappedValue != P.default else { return }
        try encode(value.wrappedValue, forKey: key)
    }
}

public protocol ValueProver {
    associatedtype Value: Equatable & Codable

    static var `default`: Value { get }
}

public enum False: ValueProver {
    public static let `default` = false
}

public enum True: ValueProver {
    public static let `default` = true
}

public enum Empty<A>: ValueProver where A: Codable, A: Equatable, A: RangeReplaceableCollection {
    public static var `default`: A { A() }
}

public enum EmptyDictionary<K, V>: ValueProver where K: Hashable & Codable, V: Equatable & Codable {
    public static var `default`: [K: V] { Dictionary() }
}

public enum FirstCase<A>: ValueProver where A: Codable, A: Equatable, A: CaseIterable {
    public static var `default`: A { A.allCases.first! }
}

public enum Zero: ValueProver {
    public static let `default` = 0
}

public enum One: ValueProver {
    public static let `default` = 1
}

public enum ZeroDouble: ValueProver {
    public static let `default`: Double = 0
}

public enum YValue: ValueProver {
    public static let `default`  = "Y"
}

public enum FalseValue: ValueProver {
    public static let `default` = false
}
