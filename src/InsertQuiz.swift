import SwiftUI

struct InsertQuiz: View {
    
    public var id: Binding<String>
    public var quiz: Binding<Quiz?>
    @State private var showingScanner = false
    
    
    
    var body: some View {
        VStack {
            Form {
                Section {
                    HStack {
                        TextField("Quiz ID", text: id.animation())
                        Text("\(id.wrappedValue.count)/36")
                            .foregroundColor(.accentColor)
                    }
                } header: {
                    Text("Quiz ID")
                } footer: {
                    Text("The Quiz ID can be found in the URL from the host game.\nIt usually looks something like this: 2eb74179-19e7-44f0-9071-816f97783080")
                }
                
                Button {
                    showingScanner = true
                } label: {
                    HStack {
                        Image(systemName: "camera.fill")
                        Text("Use camera to find the ID")
                    }
                }
            }
            .frame(minHeight: 10)
        }
        .sheet(isPresented: $showingScanner) {
            ScanDocumentView(recognizedText: self.id)
        }
    }
}

func fetchQuiz(_ id: String) async -> Quiz? {
    
    var req = URLRequest(url: URL(string: "https://play.kahoot.it/rest/kahoots/" + id)!)
    req.httpMethod = "GET"
    
    do {
        let (data, res) = try await URLSession.shared.data(for: req)
        let statusCode = (res as? HTTPURLResponse)?.statusCode
        
        if statusCode != 200 {
            return nil
        }
        
        let decoded = try JSONDecoder().decode(Quiz.self, from: data)
        return decoded
    } catch {
        return nil
    }
}
