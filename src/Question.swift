import SwiftUI

struct Question: Decodable {
    public var choices: [Answer]
    public var question: String
    public var time: Int
}
