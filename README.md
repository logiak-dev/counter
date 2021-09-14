<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

This is a Flutter package -

COUNTER: Respiratory Rate / Pulse Rate. 

## Features

This widget facilitates the measurement of breath or pulse rates by health workers.

## Getting started

The user starts the stopwatch, and then clicks a large button upon observing each
breath/pulse. The widget calculates and presents the rate/min on an ongoing basis.

The widget alerts the user with a tone at 30 seconds and 60 seconds.

Its simple, but useful.

![Counter](https://github.com/logiak-dev/counter/blob/master/counter.gif)

## Usage

If you want to programmatically extract the rate, you can pass a key for the widget
and then query its current state

```dart

GlobalKey<CounterState> key = GlobalKey<CounterState>()

Counter(key)
 

IconButton(icon: Icon(Icons.refresh, color: Colors.white),
          onPressed: () => print(key.currentState?.ratePerMinute.toString()))
```
Or you could modify Counter to pass a listener function which is updated at every cycle.

## Additional information

We intend to offer other simple widgets which might be useful 
in building applications for healthworkers.

We would be interested in hear from anyone using this or having other ideas for potentially useful healthcare widgets.
