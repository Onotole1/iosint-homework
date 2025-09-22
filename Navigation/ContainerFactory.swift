//
//  ContainerFactory.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 14.07.2025.
//
import Swinject

struct ContainerFactory {
    static func makeContainer() -> Container {
        let container = Container()
        registerCoordinators(container: container)
        container.register(LogInViewController.self) { resolver in
            LogInViewController(
                coordinator: resolver.resolve(AppCoordinator.self)!,
                userService: resolver.resolve(UserService.self)!,
            )
        }
        container.register(PhotosViewController.self) { _ in PhotosViewController() }
        container.register(PostViewControllerFactory.self) { resolver in
            PostViewControllerFactoryImpl(feedCoordinator: resolver.resolve(FeedBaseCoordinator.self)!)
        }
        container.register(FeedModel.self) { _ in FeedModelImpl(secretWord: "qwerty") }
        container.register(FeedViewController.self) { resolver in
            FeedViewController(
                feedCoordinator: resolver.resolve(FeedBaseCoordinator.self)!,
                feedModel: resolver.resolve(FeedModel.self)!
            )
        }
        container.register(LoginViewControllerDelegate.self) { resolver in
            resolver.resolve(LoginFactory.self)!.makeLoginInspector()
        }.inObjectScope(ObjectScope.container)
        container.register(LoginFactory.self) { _ in MyLoginFactory() }
        container.register(UserService.self) { _ in
            #if DEBUG
            TestUserService()
            #else
            CurrentUserService()
            #endif
        }
        container.register(ProfileViewOutputFactory.self) { _ in ProfileViewModelFactory() }
        container.register(ProfileViewControllerFactory.self) { resolver in
            ProfileViewControllerFactoryImpl(
                profileViewOutputFactory: resolver.resolve(ProfileViewOutputFactory.self)!,
                profileCoordinator: resolver.resolve(ProfileBaseCoordinator.self)!,
            )
        }
        container.register(InfoViewController.self) { _ in InfoViewController(viewOutput: PlanetViewModel()) }
        return container
    }

    private static func registerCoordinators(container: Container) {
        container.register(ProfileBaseCoordinator.self) { _ in
            ProfileCoordinator(container: container)
        }.inObjectScope(ObjectScope.container)
        container.register(FeedBaseCoordinator.self) { _ in
            FeedCoordinator(container: container)
        }.inObjectScope(ObjectScope.container)
        container.register(MainBaseCoordinator.self) { resolver in
            MainCoordinator(
                feedCoordinator: resolver.resolve(FeedBaseCoordinator.self)!,
                profileCoordinator: resolver.resolve(ProfileBaseCoordinator.self)!,
            )
        }.inObjectScope(ObjectScope.container)
        container.register(AppCoordinator.self) { _ in AppCoordinatorImpl(container: container) }
    }
}
