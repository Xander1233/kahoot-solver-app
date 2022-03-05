import SwiftUI

class TextItem: Identifiable {
    var id: String
    var text: String = ""
    
    init() {
        id = UUID().uuidString
    }
}
