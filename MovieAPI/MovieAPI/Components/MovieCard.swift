//
//  MovieCard.swift
//  MovieAPI
//
//  Created by Matheus Vicente on 03/12/23.
//

import SwiftUI

enum MovieCardType {
    case big
    case small
}

struct MovieCard: View {
    @State var image: UIImage
    let cardSize: MovieCardType

    init(image: UIImage, cardSize: MovieCardType) {
        self.cardSize = cardSize
        self.image = image
    }

    var body: some View {
        VStack(spacing: .none) {
            if cardSize == .big {
                Image(uiImage: image)
                    .resizable()
            } else {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 120, height: 140)
            }
        }
    }
}

#Preview {
    MovieCard(image: UIImage().dataConvert(data: nil), cardSize: .small)
}
