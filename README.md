<p align="center">
<img src="https://raw.githubusercontent.com/DianQK/TransitionTreasury/master/transitiontreasury.png" alt="TransitionTreasury" title="TransitionTreasury" width="1000"/>
</p>

<p align="center">
<a href="https://travis-ci.org/DianQK/TransitionTreasury"><img src="https://travis-ci.org/DianQK/TransitionTreasury.svg"></a>
<a href="https://img.shields.io/cocoapods/v/TransitionTreasury.svg"><img src="https://img.shields.io/cocoapods/v/TransitionTreasury.svg"></a>
<a href="https://github.com/Carthage/Carthage"><img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat"></a>
<a href="http://cocoadocs.org/docsets/TransitionTreasury"><img src="https://img.shields.io/cocoapods/p/TransitionTreasury.svg?style=flat"></a>
<a href="https://raw.githubusercontent.com/DianQK/TransitionTreasury/master/LICENSE.md"><img src="https://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat"></a>
<a href="http://twitter.com/Songxut"><img src="https://img.shields.io/badge/twitter-@Songxut-blue.svg?style=flat"></a>
</p>

TransitionTreasury is a viewController transition framework in Swift.      

> **You can see [transitiontreasury.com](http://transitiontreasury.com)**

## Features    

* [x] Push & Present & TabBar transition animation
* [x] Easy create transition & extension
* [x] Support completion callback
* [x] Support modal viewController data callback
* [x] Support Custom Transition
* [x] Support Update Status Bar Style
* [x] Support Push & Present & TabBar Gesture.
* [x] [Complete Documentation](https://github.com/DianQK/TransitionTreasury/wiki)

## Requirements   

* iOS 8.0+
* Xcode 7.1+

## Communication

* If you **need help or found a bug**, open an issue.
* If you **have a new transition animation** or *want to contribute*, submit a pull request. :]

## Installation

### CocoaPods    

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 0.39.0+ is required to build TransitionTreasury.

To integrate TransitionTreasury into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
use_frameworks!
pod 'TransitionTreasury'
```

Then, run the following command:

```bash
$ pod install
```

### Carthage    

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager for Cocoa application. To install the carthage tool, you can use [Homebrew](http://brew.sh).

```bash
$ brew update
$ brew install carthage
```

To integrate TransitionTreasury into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "DianQK/TransitionTreasury"
```

Then, run the following command to build the TransitionTreasury framework:

```bash
$ carthage update
```

At last, you need to set up your Xcode project manually to add the TransitionTreasury framework.

On your application targets’ “General” settings tab, in the “Linked Frameworks and Libraries” section, drag and drop each framework you want to use from the Carthage/Build folder on disk.

On your application targets’ “Build Phases” settings tab, click the “+” icon and choose “New Run Script Phase”. Create a Run Script with the following content:

```bash
/usr/local/bin/carthage copy-frameworks
```

and add the paths to the frameworks you want to use under “Input Files”:

```bash
$(SRCROOT)/Carthage/Build/iOS/TransitionTreasury.framework
```

For more information about how to use Carthage, please see its [project page](https://github.com/Carthage/Carthage).

## Usage    

### Make a Push   

If we need to push `FirstViewController` to `SecondViewController`, `SecondViewController` should conform `NavgationTransitionable`, and add code `var tr_transition: TRNavgationTransitionDelegate?`, I need use this property to retain animation object. Of course, you can use this do more, but it is dangerous.   

When you need to push, just call `public func tr_pushViewController(viewController: UIViewController, method: TRPushTransitionMethod, completion: (() -> Void)?)`, like Apple method. About `method` parameter, see [transitiontreasury.com](http://transitiontreasury.com).

Example：   

```swift
/// FirstViewController.swift
class FirstViewController: UIViewController {

    func push() {
        let vc = SecondViewController()
        navigationController?.tr_pushViewController(vc, method: .Fade, completion: {
                print("Push finish")
            })
    }
}

/// SecondViewController.swift
class SecondViewController: UIViewController, TRTransition {
    
    var tr_transition: TRNavgationTransitionDelegate?

    func pop() {
        tr_popViewController()
    }
}
```    

When you need to pop, just call `public func tr_popViewController(completion: (() -> Void)? = nil) -> UIViewController?`.

### Make a Present   

If we present `MainViewController` to `ModalViewController`:     

* `MainViewController` should conform `ModalTransitionDelegate`, and add `var tr_transition: TRViewControllerTransitionDelegate?` 
* Add `weak var modalDelegate: ModalViewControllerDelegate?` for `ModalViewController`.

Example：       

```Swift
/// MainViewController.swift
class MainViewController: UIViewController, ModalTransitionDelegate {

    var tr_transition: TRViewControllerTransitionDelegate?

    func present() {
        let vc = ModalViewController()
        vc.modalDelegate = self // Don't forget to set modalDelegate
        tr_presentViewController(vc, method: .Fade, completion: {
                print("Present finished.")
            })
    }
}

/// ModalViewController.swift
class ModalViewController: UIViewController {
    
    weak var modalDelegate: ModalViewControllerDelegate?

    func dismiss() {
        modalDelegate?.modalViewControllerDismiss(callbackData: nil)
    }
}
```

if you need `callbackData` , your `MianViewController` should implement :

```swift
func modalViewControllerDismiss(interactive interactive: Bool, callbackData data:AnyObject?)

// or

func modalViewControllerDismiss(callbackData data:AnyObject?)
```

`interactive` just for interactive dismiss, for more see Advanced Usage.

> Note:      
> If you don't need callbackData, maybe you haven't implemented `func modalViewControllerDismiss(callbackData data:AnyObject?)`. 
> If you don't want to use `ModalTransitionDelegate`, you can use `ViewControllerTransitionable` which only for Animation.
> Warning:    
> You shouldn't use `tr_dismissViewController()` in your **ModalViewController**. Please use `delegate`. I have implented this, just use `modalDelegate?.modalViewControllerDismiss(callbackData: ["data":"back"])`. For more, you can read [Dismissing a Presented View Controller](http://stackoverflow.com/questions/14636891/dismissing-a-presented-view-controller).

## Advanced Usage

### Custom Animation   

Now, there is just **Custom Animation**, other usages are coming after next version.

Like **Basic-Usage**, just replace `method` paramters to `Custom(TRViewControllerAnimatedTransitioning)`, provide your animation object.  

> Note:   
> Thanks to Swift's Enum. I can write more concise code.   
> You also can use exist transition animation, just a joke~, here just be used to show an example.     

Example：    

```swift
navigationController?.tr_pushViewController(vc, method: .Custom(OMINTransitionAnimation(key: view)), completion: {
                print("Push finished")
            })
```     

> About write your animation, you can read [Animation-Guide](https://github.com/DianQK/TransitionTreasury/wiki/Animation-Guide), I happy to you will share your animation for this project.   

### Status Bar Style     

If you want to update status bar style, you should add key `View controller-based status bar appearance` in **info.plist**, and set value is `false`.   

Then like **Basic Usage**, just add param `statusBarStyle`:       

```swift
// Push & Pop
tr_pushViewController(viewController: UIViewController, method: TRPushTransitionMethod, statusBarStyle: UIStatusBarStyle = .Default)    

// Present & Dismiss
tr_presentViewController(viewControllerToPresent: UIViewController, method: TRPresentTransitionMethod, statusBarStyle: UIStatusBarStyle = .Default)
```    

### Interactive Transition Animation

See TransitionTreasuryDemo Scheme:   

```swift
func interactiveTransition(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .Began :
            guard sender.translationInView(view).y > 0 else {
                break
            }
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ModalViewController") as! ModalViewController
            vc.modalDelegate = self
            tr_presentViewController(vc, method: .Scanbot(present: sender, dismiss: vc.dismissGestureRecognizer), completion: {
                print("Present finished")
            })
        default : break
        }
    }
```
> Warning:
> Make sure you just call `tr_presentViewController(_:_:_:)` once.

### TabBar Transition Animation

Just Add this code:

```swift
tabBarController.tr_transitionDelegate = TRTabBarTransitionDelegate(method: .Swipe)
```

> Note:
> If you need `delegate`, please use `tr_delegate`.

You can see TransitionTreasuryTabBarDemo Scheme.

## License

TransitionTreasury is released under the MIT license. See LICENSE for details.
