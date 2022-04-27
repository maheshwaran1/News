//
//  APICaller.swift
//  News
//
//  Created by MAHESHWARAN on 7/29/21.
//


import Foundation



//API Caller

final class APICaller {
    
    static let shared = APICaller()
    
    //api
    struct Constants{
        static let topHeadlinesURL = URL(string: "Your Key")
        
        //search bar
        static let searchUrlString = "Your Key"
        
        //bussiness
        static let businessURL = URL(string: "Your Key")
        
        //headlines
        static let headlinesURL = URL(string: "Your Key")
        
    }
    
   
    
    private init(){}
    
    
    public func getTopStories(completion: @escaping (Result<[Article], Error>) -> Void){
          
        //unwarp url string
        guard let url = Constants.topHeadlinesURL else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _ , error in
            
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIRespone.self, from: data)
                    
                    print("Articles: \(result.articles.count)")
                    
                    completion(.success(result.articles))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
  }
    
    
    //Business------------
    
    public func getTopBusiness(completion: @escaping (Result<[Article], Error>) -> Void){
          
        //unwarp url string
        guard let url = Constants.businessURL else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _ , error in
            
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIRespone.self, from: data)
                    
                    print("Articles: \(result.articles.count)")
                    
                    completion(.success(result.articles))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
  }
    
    
    
    
    
    
    
    
    
 //Search result -------------------------------------------------------------------
    
    public func search(with query: String,completion: @escaping (Result<[Article], Error>) -> Void){
         
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        let urlstring = Constants.searchUrlString + query
        
        //unwarp url string
        guard let url = URL(string: urlstring) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _ , error in
            
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIRespone.self, from: data)
                    
                    print("Articles: \(result.articles.count)")
                    
                    completion(.success(result.articles))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
  }
}

//models---------------------------

struct APIRespone: Codable {
    let articles: [Article]
}


//Article

struct Article: Codable {
    //source
    let source: Source
    
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
}


//source
struct Source: Codable {
    let name: String
}
