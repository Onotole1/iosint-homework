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
        container.register(LogInViewController.self) { resolver in
            LogInViewController(
                coordinator: resolver.resolve(Coordinator.self)!,
                userService: resolver.resolve(UserService.self)!,
            )
        }
        container.register(PhotosViewController.self) { _ in PhotosViewController() }
        container.register(PostViewControllerFactory.self) { _ in PostViewControllerFactoryImpl() }
        container.register(Coordinator.self) { _ in CoordinatorImpl(container: container) }
        container.register(FeedViewController.self) { resolver in
            FeedViewController(postViewControllerFactory: resolver.resolve(PostViewControllerFactory.self)!)
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
        container.register(ProfileViewControllerFactory.self) { _ in ProfileViewControllerFactoryImpl() }
        return container
    }
}
