import SwiftUI
import Combine

struct ContentView: View {
    
    @State private var quiz: Quiz? = nil
    @State private var id: String = ""
    @State private var insertNew: Bool = true
    
    @State private var showQuiz: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                if !showQuiz {
                    InsertQuiz(id: $id.animation(), quiz: $quiz)
                        .navigationTitle("Kahoot solver")
                        .navigationBarTitleDisplayMode(.inline)
                        .background(.clear)
                        .onReceive(Just(id)) { _ in
                            if id.count > 36 {
                                id = String(id.prefix(36))
                            }
                        }
                    
                    if id.count == 36 {
                        Button {
                            Task {
                                let quiz = await fetchQuiz(id)
                                
                                if quiz == nil {
                                    return
                                }
                                
                                self.quiz = quiz
                                
                                showQuiz = true
                            }
                        } label: {
                            Text("Solve")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .frame(width: 200, height: 60)
                                .background(.blue)
                                .cornerRadius(8)
                        }
                    }
                    
                    Spacer(minLength: 350)
                } else {
                    NavigationLink(destination: ShowQuiz(quiz!).background(.clear), isActive: $showQuiz) {
                        EmptyView()
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        .navigationBarBackButtonHidden(true)
        .background(.clear)
        .background(.linearGradient(colors: [ .red, .green ], startPoint: .topLeading, endPoint: .bottomTrailing))
    }
}
