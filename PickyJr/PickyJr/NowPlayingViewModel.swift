//
//  NowPlayingViewModel.swift
//  PickyJr
//
//  Created by Charles Joseph on 2021-11-06.
//

import Foundation
import MediaPlayer
import Combine

protocol NowPlayingViewModel: ObservableObject {
    var artwork: UIImage? { get }
}

class SystemMusicNowPlayingViewModel: NowPlayingViewModel {
    private var subscriptions = Set<AnyCancellable>()

    @Published private(set) var artwork: UIImage?

    init() {
        MPMusicPlayerController.systemMusicPlayer.beginGeneratingPlaybackNotifications()
        NotificationCenter.default.publisher(for: .MPMusicPlayerControllerNowPlayingItemDidChange, object: nil)
            .map { _ in
                return MPMusicPlayerController.systemMusicPlayer.nowPlayingItem
            }
            .map { nowPlayingItem in
                return nowPlayingItem?.artwork?.image(at: CGSize(width: 1000, height: 1000))
            }
            .sink { [weak self] image in
                self?.artwork = image
            }
            .store(in: &subscriptions)
    }

    deinit {
        MPMusicPlayerController.systemMusicPlayer.endGeneratingPlaybackNotifications()
    }
}

#if DEBUG

class MockNowPlayingViewModel: NowPlayingViewModel {
    @Published var artwork: UIImage?
}

#endif
