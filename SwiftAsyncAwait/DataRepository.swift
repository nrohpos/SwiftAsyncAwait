//
//  DataRepository.swift
//  SwiftAsyncAwait
//
//  Created by Papaya on 18/10/2022.
//

import Foundation
enum MyError : Error{
    case somethingWentWrong
}

class DataRepository {
    let url = URL(string: "https://api.github.com/users/hadley/orgs")
    
}

extension DataRepository {
    func getModels() async -> Result<[DataModel],Error> {
        guard let url = url else { return .failure(MyError.somethingWentWrong) }

        do {
            let (data,_) = try await URLSession.shared.data(from: url)
            let datas = try JSONDecoder().decode([DataModel].self, from: data)
            return .success(datas)
        } catch {
            return .failure(MyError.somethingWentWrong)
        }
    }
}
