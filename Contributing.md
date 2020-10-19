#  Contributing


## Branch Policy
I have the maintain following branches

 | Branch name | Desc. |
|---|:--|
 | **develop** | All development goes on in this branch. If you're contributing, you are supposed to make a pull request to  _development_. PRs to development branch must pass a build check and a unit-test check on Github Actions. When a pr is merged, it will automatically pushed to the beta version on the Testflight. |
 | **master** |  After a certain period of beta testing from out testflight users, the code will be merged into _master_ which will be deployed to the App Store. If there are some important bug fixes on the _develop_ branch, the code will be immediately merged into _master_. |

## Code Styling 

### Use Constants.swift where ever possible
  Any string, should be entered in Constants file under the model. Do add a test checking if the variable under Constants matches to a independent similar string.

### Prefer implicit getters on read-only properties and subscripts

  When possible, omit the  `get`  keyword on read-only computed properties and read-only subscripts.

  So instead of explicit getters suchs as this :point_down:

```swift
var myGreatProperty: Int {
  get {
    return 4
  }
}

subscript(index: Int) -> T {
    get {
        return objects[index]
    }
}
```
  :rocket: Code them implicitly like so :point_down:

```swift
var myGreatProperty: Int {
  return 4
}

subscript(index: Int) -> T {
    return objects[index]
}
```

  _Rationale_ :  The intent and meaning of the first version are clear, and results in less code.

### Always specify access control explicitly for top-level definitions

  Top-level functions, types, and variables should always have explicit access control specifiers:

```swift
public var whoopsGlobalState: Int
internal struct TheFez {}
private func doTheThings(things: [Thing]) {}
```

  However, definitions within those can leave access control implicit, where appropriate:

```swift
internal struct TheFez {
  var owner: Person = Joshaber()
}
```

  _Rationale:_  It's rarely appropriate for top-level definitions to be specifically  `internal`, and being explicit ensures that careful thought goes into that decision. Within a definition, reusing the same access control specifier is just duplicative, and the default is usually reasonable.

* #### When specifying a type, always associate the colon with the identifier

  When specifying the type of an identifier, always put the colon immediately after the identifier, followed by a space and then the type name.

```swift
class SmallBatchSustainableFairtrade: Coffee { ... }

let timeToCoffee: NSTimeInterval = 2

func makeCoffee(type: CoffeeType) -> Coffee { ... }
```

  _Rationale:_  The type specifier is saying something about the  _identifier_  so it should be positioned with it.

### Only explicitly refer to  `self`  when required

  When accessing properties or methods on  `self`, leave the reference to  `self`  implicit by default:

```swift
  private class History {
    var events: [Event]

    func rewrite() {
      events = []
    }
  }
```

  Only include the explicit keyword when required by the language—for example, in a closure, or when parameter names conflict:

```swift
extension History {
  init(events: [Event]) {
    self.events = events
  }

  var whenVictorious: () -> () {
    return {
      self.rewrite()
    }
  }
}
```

  _Rationale:_  This makes the capturing semantics of  `self`  stand out more in closures, and avoids verbosity elsewhere.

### Prefer structs over classes

  Unless you require functionality that can only be provided by a class (like identity or deinitializers), implement a struct instead.

  Note that inheritance is (by itself) usually  _not_  a good reason to use classes, because polymorphism can be provided by protocols, and implementation reuse can be provided through composition.


  _Rationale:_ Value types are simpler, easier to reason about, and behave as expected with the `let` keyword.

##  Issues

Issues are very valuable to this project.

If you find an issue or would like to work on one already listed in the project, please add a comment with how you can assist. 

If the issue is already assigned to someone, but there is no sign of progress, feel free to leave a comment so that the issue can be reassigned to you.

* Ideas are a valuable source of contributions others can make
* Problems show where this project is lacking
* With a question you show where contributors can improve the user experience

Thank you for creating them.

##  Pull Requests

Pull requests are a great way to get your ideas into this repository. When deciding if I merge in a pull request I look at the following criteria :

###   :one:  Does it state intent?
  You should be clear which problem you're trying to solve with your contribution.

  For example:

  > _Add link to code of conduct in README.md_
  
  :point_right: Doesn't tell me anything about why you're doing that

  > Add link to code of conduct in README.md because users don't always look in the CONTRIBUTING.md
  
  :point_right: Tells me the problem that you have found, and the pull request shows me the action you have taken to solve it.

### :two:  Does it have a Screenshot for any new UI changes?

If the PR is related to any front end change, please attach relevant screenshots in the pull request description.
  

### :three:  Does it follow the contributor covenant?
  This repository has a [code of conduct](CODE_OF_CONDUCT.md), This repository has a code of conduct, I will remove things that do not respect it.


