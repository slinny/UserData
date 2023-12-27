import Foundation
import SwiftData

@Model
class User: Codable, Identifiable {
    
    @Attribute(.unique) var id: Int
    let name: String
    let username: String
    let email: String
    @Relationship(deleteRule: .cascade) let address: Address
    let phone: String
    let website: String
    @Relationship(deleteRule: .cascade) let company: Company
    
    init(id: Int, name: String, username: String, email: String, address: Address, phone: String, website: String, company: Company) {
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.address = address
        self.phone = phone
        self.website = website
        self.company = company
    }
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case username
        case email
        case address
        case phone
        case website
        case company
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.username = try container.decode(String.self, forKey: .username)
        self.email = try container.decode(String.self, forKey: .email)
        self.address = try container.decode(Address.self, forKey: .address)
        self.phone = try container.decode(String.self, forKey: .phone)
        self.website = try container.decode(String.self, forKey: .website)
        self.company = try container.decode(Company.self, forKey: .company)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(username, forKey: .username)
        try container.encode(email, forKey: .email)
        try container.encode(address, forKey: .address)
        try container.encode(phone, forKey: .phone)
        try container.encode(website, forKey: .website)
        try container.encode(company, forKey: .company)
    }
}

@Model
class Address: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    @Relationship(deleteRule: .cascade) let geo: Geo
    
    init(street: String, suite: String, city: String, zipcode: String, geo: Geo) {
        self.street = street
        self.suite = suite
        self.city = city
        self.zipcode = zipcode
        self.geo = geo
    }
    
    enum CodingKeys: CodingKey {
        case street
        case suite
        case city
        case zipcode
        case geo
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.street = try container.decode(String.self, forKey: .street)
        self.suite = try container.decode(String.self, forKey: .suite)
        self.city = try container.decode(String.self, forKey: .city)
        self.zipcode = try container.decode(String.self, forKey: .zipcode)
        self.geo = try container.decode(Geo.self, forKey: .geo)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(street, forKey: .street)
        try container.encode(suite, forKey: .suite)
        try container.encode(city, forKey: .city)
        try container.encode(zipcode, forKey: .zipcode)
        try container.encode(geo, forKey: .geo)
    }
}

@Model
class Geo: Codable {
    let lat: String
    let lng: String
    
    init(lat: String, lng: String) {
        self.lat = lat
        self.lng = lng
    }
    
    enum CodingKeys: CodingKey {
        case lat
        case lng
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.lat = try container.decode(String.self, forKey: .lat)
        self.lng = try container.decode(String.self, forKey: .lng)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(lat, forKey: .lat)
        try container.encode(lng, forKey: .lng)
    }
}

@Model
class Company: Codable {
    let name: String
    let catchPhrase: String
    let bs: String
    
    init(name: String, catchPhrase: String, bs: String) {
        self.name = name
        self.catchPhrase = catchPhrase
        self.bs = bs
    }
    
    enum CodingKeys: CodingKey {
        case name
        case catchPhrase
        case bs
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.catchPhrase = try container.decode(String.self, forKey: .catchPhrase)
        self.bs = try container.decode(String.self, forKey: .bs)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(catchPhrase, forKey: .catchPhrase)
        try container.encode(bs, forKey: .bs)
    }
}
