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
        static let topHeadlinesURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=bc18c720aaf04b3887d907ad9fd2e797")
        
        //search bar
        static let searchUrlString = "https://newsapi.org/v2/everything?apple&from=2021-10-07&to=2021-10-07&sortBy=popularity&apiKey=bc18c720aaf04b3887d907ad9fd2e797&q="
        //https://newsapi.org/v2/everything?apple&from=2021-07-28&to=2021-07-28&sortBy=popularity&apiKey=bc18c720aaf04b3887d907ad9fd2e797&q=
        
        
        //bussiness
        static let businessURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=bc18c720aaf04b3887d907ad9fd2e797")
        
        //headlines
        static let headlinesURL = URL(string: "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=bc18c720aaf04b3887d907ad9fd2e797")
        
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
