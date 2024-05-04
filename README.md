Simple program to demonstrate Swift 5.10 inconsistent garbage collection behavior between "debug" and "release" configurations.

The `tick` publisher is expected to publish a date every second, until the program is terminated:
```
CombineTicks % swift run -c debug
Building for debugging...
[7/7] Applying ticks
Build complete! (0.47s)
receive subscription: ((extension in Foundation):__C.NSTimer.TimerPublisher.Inner<Combine.Publishers.Autoconnect<(extension in Foundation):__C.NSTimer.TimerPublisher>.(unknown context at $198ef8058).Inner<Combine.Publishers.Print<Combine.Publishers.Autoconnect<(extension in Foundation):__C.NSTimer.TimerPublisher>>.(unknown context at $198ef81d0).Inner<Combine.Subscribers.Sink<Foundation.Date, Swift.Never>>>>)
request unlimited
receive value: (2024-05-04 16:02:38 +0000)
receive value: (2024-05-04 16:02:39 +0000)
receive value: (2024-05-04 16:02:40 +0000)
receive value: (2024-05-04 16:02:41 +0000)
^C
```
The expected behavior is observed with "debug" builds (`-c debug`) in Swift 5.10. It is also observed in Swift 5.9 (both "debug" and "release" builds).

When using the "release" configuration however, note that the publisher is cancelled, presumably because `subscriptions` has been garbage collected:
```
CombineTicks % swift run -c release
Building for production...
[1/1] Write swift-version--58304C5D6DBC2206.txt
Build complete! (0.14s)
receive subscription: ((extension in Foundation):__C.NSTimer.TimerPublisher.Inner<Combine.Publishers.Autoconnect<(extension in Foundation):__C.NSTimer.TimerPublisher>.(unknown context at $198ef8058).Inner<Combine.Publishers.Print<Combine.Publishers.Autoconnect<(extension in Foundation):__C.NSTimer.TimerPublisher>>.(unknown context at $198ef81d0).Inner<Combine.Subscribers.Sink<Foundation.Date, Swift.Never>>>>)
request unlimited
receive cancel
^C
```
