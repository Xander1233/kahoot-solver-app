import SwiftUI

struct ShowQuiz: View {
    
    public let quiz: Quiz
    
    public init(_ quiz: Quiz) {
        self.quiz = quiz
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            ForEach(0..<quiz.questions.count, id: \.self) {
                ShowQuestion(question: quiz.questions[$0])
                Spacer()
            }
        }
        .frame(maxWidth: 500)
        .navigationTitle(quiz.title)
    }
}

