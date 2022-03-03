//
//  Question.swift
//  LOGIN
//
//  Created by Nicola D'Abrosca on 22/02/22.
//

import Foundation

public class Questions: Identifiable{
    
    
    public init(){
        getQuestions()
    }
    
    struct Entry: Decodable{
        var error: Bool
        var message: String
        var question: [QuestionStruct]
    }
    
    public struct QuestionStruct: Decodable{
        var id : Int
        var category: String
        var text: String
        var r1 : String
        var r2: String
        var r3: String
        var answer: String
    }
    
    var questions: [QuestionStruct] = []
    
    
    public func getQuestions(){
        let request = NSMutableURLRequest(url: NSURL(string:
                                                        "https://quizcode.altervista.org/API/user/getQuestions.php")! as URL)
        request.httpMethod = "POST"
        let postString = "language=" + NSLocale.current.languageCode!
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(String(describing: error))")
                
            }
            
           
            if let data = data {
                let jsonDecoder = JSONDecoder()
                do {
                    let parsedJSON = try jsonDecoder.decode(Entry.self, from: data)
                    
                    self.questions = parsedJSON.question
                    

                } catch {
                    print(error)
                }
            }
        }
        task.resume()
      
    }

}
