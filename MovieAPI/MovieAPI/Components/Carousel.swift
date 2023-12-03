//
//  CaroselComponent.swift
//  MovieAPI
//
//  Created by Matheus Vicente on 03/12/23.
//

import SwiftUI

struct Carousel<Model: Hashable, Content: View>: View {
    @Binding var items: [Model]
    var content: (Model) -> Content
    var title: String

    init(items: Binding<[Model]>, title: String, content: @escaping (Model) -> Content) {
        self._items = items
        self.content = content
        self.title = title
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title)
                .padding(.leading, 8)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 5) {
                    ForEach(items, id: \.self) { movie in
                        content(movie)
                    }
                }
            }
        }
    }
}
