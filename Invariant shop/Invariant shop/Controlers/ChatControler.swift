//
//  ChatControler.swift
//  Invariant shop
//
//  Created by Benjamin Sabo on 17.02.2024..
//
import OpenAISwift
import Foundation

// Define a protocol for dependency injection and easier testing
protocol OpenAIServiceProtocol {
    func fetchCompletion(for input: String, completion: @escaping (Result<String, Error>) -> Void)
}



// Implement the OpenAI Service
class OpenAIService: OpenAIServiceProtocol {
    private let apiKey: String
    private let session: URLSession
    
    init(apiKey: String, session: URLSession = .shared) {
        self.apiKey = apiKey
        self.session = session
    }
    
    func fetchCompletion(for input: String, completion: @escaping (Result<String, Error>) -> Void) {
        // Construct your URL and request here based on OpenAI's API documentation
        let url = URL(string: "https://api.openai.com/v1/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        // Add more headers and body according to the API requirements
        
        let task = session.dataTask(with: request) { data, response, error in
            // Handle the response and errors here, then call the completion handler
        }
        
        task.resume()
    }
}


class ChatController {
    static var shared: ChatController = {
        let openAIService = OpenAIService(apiKey: "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")
        return ChatController(openAIService: openAIService)
    }()
    
    private var openAIService: OpenAIServiceProtocol
    
    init(openAIService: OpenAIServiceProtocol) {
        self.openAIService = openAIService
    }
    
    func processInputWithAI(_ input: String, completion: @escaping (Bool, String) -> Void) {
        DataManager.shared.processInputText(input)
        completion(true, "Processed input: \(input)")
    }
}
















//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
