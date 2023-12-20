//
//  APICaller.swift
//  Cinemate
//

import Foundation

struct Constants {
    static let API_KEY = "05b7ef2feef7c687f452d8275a76ad1d"
    static let baseURL = "https://api.themoviedb.org"
    static let Youtube_API_KEY = "AIzaSyBwcEXJAMPb8to5sdRaZvhDNmhGhBlwITg"
    static let YoutuveBaseURL = "https://youtube.googleapis.com/youtube"
}

enum APIError: Error {
    case failedGetData
}

class APICaller {
    static let shared = APICaller()
    
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> (Void)) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let result = try JSONDecoder().decode(TrendingTitlesResponse.self, from: data)
                completion(.success(result.results))
            } catch {
                completion(.failure(APIError.failedGetData))
            }
        }
        task.resume()
    }
    
    func getPopularMovies(completion: @escaping (Result<[Title], Error>) -> (Void)) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let result = try JSONDecoder().decode(TrendingTitlesResponse.self, from: data)
                completion(.success(result.results))
            } catch {
                completion(.failure(APIError.failedGetData))
            }
        }
        task.resume()
    }
    
    func getTrendingTV(completion: @escaping (Result<[Title], Error>) -> (Void)) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let result = try JSONDecoder().decode(TrendingTitlesResponse.self, from: data)
                completion(.success(result.results))
            } catch {
                completion(.failure(APIError.failedGetData))
            }
        }
        task.resume()
    }
    
    func getComingMovies(completion: @escaping (Result<[Title], Error>) -> (Void)) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let result = try JSONDecoder().decode(TrendingTitlesResponse.self, from: data)
                completion(.success(result.results))
            } catch {
                completion(.failure(APIError.failedGetData))
            }
        }
        task.resume()
    }
    
    func getTopRatedMovies(completion: @escaping (Result<[Title], Error>) -> (Void)) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let result = try JSONDecoder().decode(TrendingTitlesResponse.self, from: data)
                completion(.success(result.results))
            } catch {
                completion(.failure(APIError.failedGetData))
            }
        }
        task.resume()
    }
    
    func getDiscoverMovies(completion: @escaping (Result<[Title], Error>) -> (Void)) {
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let result = try JSONDecoder().decode(TrendingTitlesResponse.self, from: data)
                completion(.success(result.results))
            } catch {
                completion(.failure(APIError.failedGetData))
            }
        }
        task.resume()
    }
    
    func search(with query: String, completion: @escaping (Result<[Title], Error>) -> (Void)) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let result = try JSONDecoder().decode(TrendingTitlesResponse.self, from: data)
                completion(.success(result.results))
            } catch {
                completion(.failure(APIError.failedGetData))
            }
        }
        task.resume()
    }
    
    func getMovies(with query: String, completion: @escaping (Result<VideoElement, Error>) -> (Void)) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string: "\(Constants.YoutuveBaseURL)/v3/search?q=\(query)&key=\(Constants.Youtube_API_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let result = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                completion(.success(result.items[0]))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
