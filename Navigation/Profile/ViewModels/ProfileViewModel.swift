//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 02.08.2025.
//
import Combine
import StorageService

protocol ProfileViewOutputFactory {
    func makeOutput(user: User) -> ProfileViewOutput
}

class ProfileViewModelFactory: ProfileViewOutputFactory {
    func makeOutput(user: User) -> ProfileViewOutput {
        ProfileViewModel(user: user)
    }
}

class ProfileViewModel: ProfileViewOutput {

    @Published private var _config: ProfileViewConfig
    var config: AnyPublisher<ProfileViewConfig, Never> {
        $_config.eraseToAnyPublisher()
    }

    var onSetStatusAction: (String) -> Void {
        { [weak self] status in
            guard let self else { return }
            _config = _config.updateStatus(status)
        }
    }

    init(user: User) {
        self._config = Self.createConfig(user: user)
    }

    private static func createConfig(user: User) -> ProfileViewConfig {
        let images = GetPhotos.shared.getImages().take(4)
        let photosViewModelItems: [PhotosViewModelItem] = [PhotosViewModelItem(images: images)]

        let posts = GetPosts.fetch()
        let postViewModels = posts.map(PostViewModelItem.fromPost)

        return ProfileViewConfig(user: user, items: photosViewModelItems + postViewModels)
    }
}
