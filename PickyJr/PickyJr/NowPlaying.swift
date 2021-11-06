//
//  NowPlaying.swift
//  PickyJr
//
//  Created by Charles Joseph on 2021-11-05.
//

import SwiftUI

struct NowPlaying: View {
    var image: UIImage?

    var body: some View {
        BlurryBorderedContentView {
            ImageWithPlaceholder(
                image: image,
                placeholderSymbolName: "music.note.list"
            )
        }
        .frame(maxWidth: 300, maxHeight: 300, alignment: .center)
        .clipShape(
            RoundedRectangle(
                cornerSize: CGSize(width: 45, height: 45),
                style: RoundedCornerStyle.continuous
            )
        )
    }
}

struct ImageWithPlaceholder: View {
    let image: UIImage?
    let placeholderSymbolName: String

    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
        }
        else {
            Image(systemName: placeholderSymbolName)
                .resizable()
                .padding()
                .background(.blue)
        }
    }
}

struct BlurryBorderedContentView<Content: View>: View {
    @ViewBuilder let content: Content
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                content
                    .overlay(.ultraThinMaterial)
                content
                    .frame(width: geometry.size.width * 0.6, height: geometry.size.height * 0.6, alignment: .center)
            }
        }
    }
}

struct NowPlaying_Previews: PreviewProvider {
    static var previews: some View {
        NowPlaying(image: nil)

        NowPlaying(image: UIImage(named: "wiggles"))
    }
}
