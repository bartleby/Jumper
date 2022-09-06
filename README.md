<p align="center">
  <img src="/Images/header.png">
</p>

---

Simple, powerful and elegant implementation of the Coordinator pattern in Swift for UIKit


## Installation

#### Swift Package Manager

```
https://github.com/bartleby/Jumper.git
```

## How to use Jumper

### Coordinators

Jumper из коробки имеет три вида протоколов координатора, которые могут реализовать ваши координаторы:
> Вы так же можете реализовать свой собственный координатор, смотрите исходный код.

* `RootCoordinable` - Является контейнером `UIViewController`, отлично подходит для стартовой логикии в вашем приложении.
* `NavigationCoordinable` - Используется для навигации по стеку
* `TabCoordinable` - Реализует `UITabBarController`

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

В этом примере создается `AppCoordinator` который реализует `RootCoordinable` протокол
- Шаг 1 - Вы должны реализовать `navigation` проперти и инициализировать ее c `Route` по умолчанию
- Шаг 2 - Инициализация переходов, задается с помощью ключевого слова `@Route` который должен указывать на функцию создания `View` или другого `Coordinator`a для перехода
- Шаг 3 - Реализация методов на кототые ссылаются `Route`

#### Список методов перехода

* `root(\.someRoute)` Заменяет текущее представлениие или координатор
* `root(\.someRoute, input: "any type")`
* `isRoot(\.someRoute)` Возвращает булево значение, которое указывает, является ли данный `Route` корневым
* `hasRoot(\.someRoute)` Возвращает корневой координатор или nil если указаный `Route` не является корневым
* `present(\.someRoute)` Презентует вью или координатор
* `present(\.someRoute, input: "any type")`
* `present(\.someRoute, input: "any type", animated: false)`
* `dismiss()`

В каждый метод перехода вы можете передать аргумент, используя поле `input`, который будет передан в функциию создания вью/координатора

```swift
@Route var userList = userListScreen

func userListScreen(listData: [User]) -> UserListCoordinator {
    UserListCoordinator(data: listData)
}
```
вызов такого перехода будет выглядеть так

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

#### Список методов перехода

* `push(\.someRoute)`
* `push(\.someRoute, input: "any type")`
* `push(\.someRoute, animated: false)`
* `push(stack: )` 
* `pop(\.someRoute)`
* `pop(\.someRoute, animated: false)`
* `pop(to: \.someRoute)` переход к указаному `Route`
* `pop(to: \.someRoute, animated: false)`
* `popToRoot()` переход в начала стека
* `popToRoot(animated: false)`
* `present(\.someRoute)`
* `present(\.someRoute, input: "any type")`
* `present(\.someRoute, input: "any type", animated: false)`
* `dismiss()`

используя метод `push(stack:)` вы можете сделать `push` сразу нескольких `Route` в навигейшен стек, при этом анимация будет применена только для последнего перехода

```swift
coordinator?.push {
    \SettingsCoordinator.yellow
    \SettingsCoordinator.green
    \SettingsCoordinator.green
    \SettingsCoordinator.green
    \SettingsCoordinator.yellow
    \SettingsCoordinator.green
}
```

тоже самое вы можете сделать при помощи цепочки `Route`

```swift
coordinator?
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
Тут все по аналогии с другими координаторами за небольшим исключениием, в @Route появляется новый аргумент, в который вы должны передать TabItem, и в инициализации `navigation` проперти, теперь передается список роутов которые будут являться табами

* Шаг 1 - Инициализируйте `navigation` с несколькимии `Route` которые будут являться табами в таб баре
* Шаг 2 - Определите `Route` указав в аргументе tabItem
* Шаг 3 - Определите координаторы для переходов
* Шаг 4 - Методы которые возвращают TabItem

#### Список методов перехода

* `focus(\.someTabRoute)` переход на таб 
* `present(\.someRoute)` презентация `Route`
* `dismiss()`

### Alert's
Для того, чтобы показать алерт и другие всплывающие элементы, через координатор, вы должны поддержать протокол `ScreenViewPresentable`

Например, создайте протокол `AlertCoordinable` и реализуйте в нем логику показа Алерта.
Чтобы получить контроллер на который нужно показать всплывающий элемент, вызовете метод `view()`


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

Теперь, если этот протокол указать вашему координатору, у него появится возможность отображать Алерты

```swift
final class SettingsCoordinator: NavigationCoordinable, AlertCoordinable {
    //...
}
```

```swift
coordinator.presentAlert(title: "Title", message: "Message")
```


### Customizing

Иногда вам может понадобится обратится к `UITabBarController`, `UINavigationController` или `UIViewController` контроллеру из вашего координатора, для этого есть метод `configure(controller: )`

```swift
final class MainCoordinator: NavigationCoordinable {
    
    //...
    
    func configure(controller: UINavigationController) {
        // Customaize here
    }
}
```



### Chaining

Одной из сильных сторон Jumper является объеденение переходов в цепочки 

```swift
coordinator
    .hasRoot(\.tabBar)
    .focus(\.todoList)
    .push(\.todoDetail, input: todoIdentifier)
    .present(\.todoEditor)
```

каждый переход, если это переход на координатор, возвращает координатор перехода, если это переход на вью, то возвращается текущий координатор.


Наприимер:
В координаторе `SettingsCoordinator` есть два перехода:

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
coordinator.present(\.rateApp) \\ вернет SettingsCoordinator
coordinator.present(\.notification) \\ вернет NotificationCoordinator
```


### Deep Linking

Благодаря объеденению `Route` в цепочки вы получаете `DeepLink` из коробки, да их реализации, определите метод `scene(scene:, openURLContexts:)` в `SceneDelegate`

```swift
func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
    appCoordinator.onOpenURL(URLContexts.first?.url)
}
```

создайте метод `onOpenURL(url:)` в вашем главном координаторе 

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

Реализацию `DeepLink` вы можете посмотреть в Demo проекте.


Чтобы протестировать диплинкии используйте терминальную команду `xcrun simctl openurl booted <url>`

в Demo проекте настроены следущие deeplink


> Переход на таб Main
> 
> `xcrun simctl openurl booted jumper://io.idevs/home`



> Переход на таб Settings
> 
> `xcrun simctl openurl booted jumper://io.idevs/settings`



> Открывает модальное окно и передает в него аргумент `hello-world`
> 
> `xcrun simctl openurl booted jumper://io.idevs/todo/hello-world`


![ezgif-4-59b7108f97](https://user-images.githubusercontent.com/236311/188562865-cbd4e186-12d8-4a79-814e-b49060e28379.gif)

## Demo project

Скачайте демо проект из [репозитория](https://github.com/bartleby/Jumper-Demo.git)


## License


MIT license. See the [LICENSE file](LICENSE) for details.
