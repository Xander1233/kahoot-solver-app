import SwiftUI
import Vision

struct TextRecognition {
    
    var scannedImages: [UIImage]
    @ObservedObject var recognizedContent: RecognizedContent
    var didFinishRecognition: () -> Void
    
    
    private func getTextRecognitionRequest(with textItem: TextItem) -> VNRecognizeTextRequest {
        let request = VNRecognizeTextRequest { request, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let observations = request.results as? [VNRecognizedTextObservation] else {
                return
            }
            
            observations.forEach { observation in
                guard let recognizedText = observation.topCandidates(1).first else { return }
                
                textItem.text += recognizedText.string
            }
        }
        
        request.recognitionLevel = .fast
        request.usesLanguageCorrection = false
        
        return request
    }
    
    func recognizeText() {
        let queue = DispatchQueue(label: "textRecognitionQueue", qos: .userInitiated)
        
        queue.async {
            for image in scannedImages {
                guard let cgImage = image.cgImage else { return }
                
                let reqHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
                
                do {
                    let textItem = TextItem()
                    
                    try reqHandler.perform([getTextRecognitionRequest(with: textItem)])
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            DispatchQueue.main.async {
                didFinishRecognition()
            }
        }
    }
    
}
