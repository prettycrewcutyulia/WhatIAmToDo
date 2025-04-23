//
//  UpdateAccountRequest.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 20.04.2025.
//


struct UpdateAccountRequest: Encodable {
    let userId: Int
    let name: String?
    let email: String?
}

struct DeleteAccountRequest: Encodable {
    let userId: Int
}
