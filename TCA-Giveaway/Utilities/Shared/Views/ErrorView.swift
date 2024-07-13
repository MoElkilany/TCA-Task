//
//  ErrorView.swift
//  Givawayes
//
//  Created by Elkilany on 13/07/2024.
//


import SwiftUI


struct ErrorView: View {
    let errorMessage: String

    var body: some View {
        Text(errorMessage)
            .foregroundColor(.red)
            .padding()
    }
}
