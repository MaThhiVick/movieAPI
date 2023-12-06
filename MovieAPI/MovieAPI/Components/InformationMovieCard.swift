//
//  InformationMovieCard.swift
//  MovieAPI
//
//  Created by Matheus Vicente on 04/12/23.
//

import SwiftUI

struct InformationMovieCard: View {
    let title: String
    let information: String

    init(title: String, information: String) {
        self.title = title
        self.information = information
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            line()
                .padding(.leading, -8)
                .padding(.bottom, 4)
            HStack(spacing: 4) {
                Text("\(title):")
                    .font(.caption)
                Text(information)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
        }
    }

    @ViewBuilder
    func line() -> some View {
        Rectangle()
            .frame(height: 0.3)
            .foregroundStyle(.gray)
    }
}

#Preview {
    InformationMovieCard(title: "Test", information: "test test")
}
