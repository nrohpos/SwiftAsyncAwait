//
//  ViewModel.swift
//  SwiftAsyncAwait
//
//  Created by Papaya on 18/10/2022.
//

import Foundation


class ViewModel {
  let dataRepository = DataRepository()
  var itemList = [DataModel]()
}

extension ViewModel {
    func bindData(completion : @escaping (_ isSuccess : Bool , _ error : String?) -> Void) {
        Task {
            let result = await dataRepository.getModels()
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self.itemList = success
                    completion(true,nil)
                case .failure(let failure):
                    completion(false, failure.localizedDescription)
                }
            }
        }
    }
}

