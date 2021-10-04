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

class DataDecoder<T: Codable>{
    static func DecodeData(data: Data) -> T? {
        let decoder =  JSONDecoder()
        //чтобы правильно декодировались даты
        decoder.dateDecodingStrategy = .iso8601
        do{
            let decodedData = try decoder.decode(T?.self, from: data)
            return decodedData
        }
        catch{
            print("Decoding error: \(error.localizedDescription)")
            return nil
        }
    }
}
