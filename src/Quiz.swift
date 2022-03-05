import SwiftUI

struct Quiz: Decodable {
    public var questions: [Question]
    public var title: String
}
