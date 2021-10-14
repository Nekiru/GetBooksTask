import Foundation

struct Review: Codable {
    let body: String?
}

struct Book: Codable {
    let isbn, title, bookDescription, author: String?
    let publicationDate: Date?
    let reviews: [Review]?

    enum CodingKeys: String, CodingKey {
        case isbn, title
        case bookDescription = "description"
        case author, publicationDate, reviews
    }
}

typealias Books = [Book]
