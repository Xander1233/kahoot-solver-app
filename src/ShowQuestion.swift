import SwiftUI

struct ShowQuestion: View {
    
    public var question: Question
    
    var body: some View {
        VStack {
            HStack {
                Text(question.question)
                    .padding(.leading, 5)
                    .font(.headline)
                Spacer()
            }
            
            ShowAnswer(answer: question.choices.filter { i in
                return i.correct == true
            }.first!, index: question.choices.firstIndex { i in
                return i.correct == true
            }!)
        }
        .foregroundColor(.white)
        .padding(.all, 5)
        .background(.thinMaterial)
        .cornerRadius(8)
        .padding(.all, 5)
    }
}
