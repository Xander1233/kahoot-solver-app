import SwiftUI

struct ShowAnswer: View {
    
    public var answer: Answer
    public var index: Int
    
    var body: some View {
        HStack {
            Text("Answer: \(answer.answer)")
            Spacer()
            Spacer()
            HStack {
                Text("Color: ")
                Image(systemName: "circle.fill")
            }
            .foregroundColor(index == 0 ? .red : index == 1 ? .blue : index == 2 ? .yellow : index == 3 ? .green : .red)
            Spacer()
        }
        .frame(minHeight: 50)
        .padding(.leading, 10)
    }
}

