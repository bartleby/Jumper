<p align="center">
  <img src="/Images/header.png">
</p>

---

A simple, powerful and elegant implementation of the coordinator template in Swift for UIKit


## Installation

#### Swift Package Manager

```
https://github.com/bartleby/Jumper.git
```

## How to use Jumper

### Coordinators

Jumper out of the box has three kinds of coordinator protocols that your coordinators can implement:
> You can also implement your own coordinator, see the source code.

* `RootCoordinable` - It is a `UIViewController` container, great for starting logic in your application.
* `NavigationCoordinable` - Used for stack navigation
* `TabCoordinable` - Implements 'UITabBarController`

### RootCoordinable

```swift
final class AppCoordinator: RootCoordinable {

    // step 1
    var navigation: RootNavigation<AppCoordinator> = .init(initial: \.onboarding)
    
    // step 2
    @Route var onboarding = onboardingScreen
    @Route var home = homeScreen

    // step 3
    func onboardingScreen() -> ScreenView {
        OnboardingScreenView()
    }
    
    func homeScreen() -> TabBarCoordinator {
        TabBarCoordinator()
    }
}

```

In this example, an `AppCoordinator` is created that implements the `RootCoordinable` protocol
- Step 1 - You have to implement the `navigation` property and initialize it with `Route` by default
- Step 2 - Initialization of transitions, set using the keyword `@Route` which should indicate the function of creating a `View` or another `Coordinator` for the transition
- Step 3 - Implementation of methods referenced by `Route`

#### List of transition methods

* `root(\.someRoute)` Replaces the current view or coordinator
* `root(\.someRoute, input: "any type")`
* `isRoot(\.someRoute)` Returns a boolean value that indicates whether the given `Route` is root
* `hasRoot(\.someRoute)` Returns the root coordinator or nil if the specified `Route` is not root
* `present(\.someRoute)` Is presented by a view or coordinator
* `present(\.someRoute, input: "any type")`
* `present(\.someRoute, input: "any type", animated: false)`
* `dismiss()` Dismiss the current Coordinator

You can pass an argument to each transition method using the `input` field, which will be passed to the view/coordinator creation function.

```swift
@Route var userList = userListScreen

func userListScreen(listData: [User]) -> UserListCoordinator {
    UserListCoordinator(data: listData)
}
```
calling such a transition will look like this

```swift
coordinator.present(\.userList, input: userListData)
```

### NavigationCoordinable

```swift
final class AuthorizationCoordinator: NavigationCoordinable {
    
    var navigation: Navigation<AuthorizationCoordinator> = .init(initial: \.authorization)
    
    @Route var authorization = authorizationScreen
    @Route var registration = registrationScreen
    
    func authorizationScreen() -> ScreenView {
        AuthorizationScreen()
    }
    
    func registrationScreen() -> ScreenView {
        RegistrationScreen()
    }
}
```

#### List of transition methods

* `push(\.someRoute)`
* `push(\.someRoute, input: "any type")`
* `push(\.someRoute, animated: false)`
* `push(stack: )` 
* `pop(\.someRoute)`
* `pop(\.someRoute, animated: false)`
* `pop(to: \.someRoute)` going to the specified `Route`
* `pop(to: \.someRoute, animated: false)`
* `popToRoot()`
* `popToRoot(animated: false)`
* `present(\.someRoute)`
* `present(\.someRoute, input: "any type")`
* `present(\.someRoute, input: "any type", animated: false)`
* `dismiss()` Dismiss the current Coordinator

using the `push(stack:)` method you can `push` several `Routes` into the navigation stack at once, and the animation will be applied only for the last transition

```swift
coordinator.push {
    \SettingsCoordinator.yellow
    \SettingsCoordinator.green
    \SettingsCoordinator.green
    \SettingsCoordinator.green
    \SettingsCoordinator.yellow
    \SettingsCoordinator.green
}
```

you can do the same with the `Route` chain

```swift
coordinator
    .push(\.yellow, animated: false)
    .push(\.green, animated: false)
    .push(\.green, animated: false)
    .push(\.green, animated: false)
    .push(\.yellow, animated: false)
    .push(\.green, animated: true)
```


### TabCoordinable

```swift
final class TabBarCoordinator: TabCoordinable {
    
    // Step 1
    var navigation: TabNavigation<TabBarCoordinator> = .init {
        \TabBarCoordinator.main
        \TabBarCoordinator.settings
    }
    
    // Step 2
    @Route(tabItem: mainTab) var main = mainScreen
    @Route(tabItem: settingsTab) var settings = settingsScreen

    // Step 3
    func mainScreen() -> MainCoordinator {
        MainCoordinator()
    }
    
    func settingsScreen() -> SettingsCoordinator {
        SettingsCoordinator()
    }
    
    // Step 4
    func mainTab() -> UITabBarItem {
        UITabBarItem()
            .image(UIImage(systemName: "circle.fill"))
            .title("Main")
    }
    
    func settingsTab() -> UITabBarItem {
        UITabBarItem()
            .image(UIImage(systemName: "square.fill"))
            .title("Settings")
    }
}
```
Here everything is similar to other coordinators, with a small exception, a new argument appears in @Route, to which you must pass TabItem, and in the initialization of the `navigation` property, a list of routes that will be tabs is now passed

* Step 1 - Initialize `navigation` with several `Routes` that will be tabs in the tabbar
* Step 2 - Define `Route` by specifying TabItem in the argument
* Step 3 - Define the coordinators for transitions
* Step 4 - Define the methods that will return TabItem's

#### List of transition methods

* `focus(\.someTabRoute)` switching to tab 
* `present(\.someRoute)` presentation of `Route`
* `dismiss()` Dismiss the current Coordinator

### Alert's
In order to show the alert and other pop-up elements through the coordinator, you must support the `ScreenViewPresentable` protocol

For example, create the `AlertCoordinable` protocol and implement the Alert display logic in it.
To get the controller to which you want to show the popup element, call the `view()` method


` let controller = view() `

```swift
public protocol AlertCoordinable: ScreenViewPresentable {
    func showAlert(title: String, message: String)
}

extension AlertCoordinable {
    func presentAlert(title: String, message: String) {
        let controller = view()
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let completeAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(completeAction)
        controller.present(alertController, animated: true, completion: nil)
    }
}
```

Implement the 'AlertCoordinable` protocol in the coordinator. 
Now the coordinator has the opportunity to display an alert

```swift
final class SettingsCoordinator: NavigationCoordinable, AlertCoordinable {
    //...
}
```

```swift
coordinator.presentAlert(title: "Title", message: "Message")
```


### Customizing

Sometimes you may need to access the `UITabBarController`, `UINavigationController` or `UIViewController` controller from your coordinator, there is a `configure(controller: )` method for this

```swift
final class MainCoordinator: NavigationCoordinable {
    
    //...
    
    func configure(controller: UINavigationController) {
        // Customize here
    }
}
```



### Chaining

One of the strengths of `Jumper` is the integration of transitions into chains

```swift
coordinator
    .hasRoot(\.tabBar)
    .focus(\.todoList)
    .push(\.todoDetail, input: todoIdentifier)
    .present(\.todoEditor)
```

each transition, if it is a transition to the coordinator, returns the transition coordinator, if it is a transition to the view, then the current coordinator is returned.

For example:
There are two transitions in the `SettingsCoordinator` coordinator:

```swift
final class SettingsCoordinator: NavigationCoordinable {
    
    //...
    
    @Route var rateApp = rateAppScreen
    @Route var notification = notificationScreen

    func rateAppScreen() -> ScreenView {
        RateAppViewController()
    }
    
    func notificationScreen() -> NotificationCoordinator {
        NotificationCoordinator()
    }
}
```

```swift
coordinator.present(\.rateApp) \\ return SettingsCoordinator
coordinator.present(\.notification) \\ return NotificationCoordinator
```


### Deep Linking

By combining `Route` into chains, you get `DeepLink ` out of the box, to implement them, define the `scene(scene:, openURLContexts:)` method in `SceneDelegate`


```swift
func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
    appCoordinator.onOpenURL(URLContexts.first?.url)
}
```

define the `onOpenURL(url:)` method in your app coordinator

```swift
func onOpenURL(_ url: URL?) {
    guard let url = url else { return }
    guard let deepLink = try? DeepLink(url: url) else { return }

    if let coordinator = self.hasRoot(\.home) {
        switch deepLink {
        case .todo(let id):
            coordinator
                .focus(\.main)
                .present(\.todo, input: id)
        case .settings:
            coordinator.focus(\.settings)
        case .home:
            coordinator.focus(\.main)
        }
    }
}
```

You can see the implementation of `DeepLink` in the Demo project.

To test the 'DeepLink ' use the terminal command `xcrun simctl openurl booted <url>`

deep links that are configured in the Demo project


> Switching to Main Tab
> 
> `xcrun simctl openurl booted jumper://io.idevs/home`



> Switching to Settings Tab
> 
> `xcrun simctl openurl booted jumper://io.idevs/settings`



> Opens the modal view and passes the `hello-world` argument to it
> 
> `xcrun simctl openurl booted jumper://io.idevs/todo/hello-world`


![ezgif-4-59b7108f97](https://user-images.githubusercontent.com/236311/188562865-cbd4e186-12d8-4a79-814e-b49060e28379.gif)

## Demo project

Download the demo project from [repository](https://github.com/bartleby/Jumper-Demo.git)


## License


MIT license. See the [LICENSE file](LICENSE) for details.
