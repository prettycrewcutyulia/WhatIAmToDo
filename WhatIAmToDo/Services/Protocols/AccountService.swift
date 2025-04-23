//
//  AccountService.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 20.04.2025.
//

protocol AccountService {
    func updateAccount(_ request: UpdateAccountRequest, completion: @escaping (Result<Void, Error>) -> Void)
    func deleteAccount(_ request: DeleteAccountRequest, completion: @escaping (Result<Void, Error>) -> Void)
    func getTgExist(userId: Int, completion: @escaping (Result<Void, Error>) -> Void)
}
