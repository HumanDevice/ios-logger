# ios-logger
Simple iOS logger

# Installation

## Download XcodeColors

Install module using manual: [https://github.com/robbiehanson/XcodeColors](https://github.com/robbiehanson/XcodeColors)

## Modify Podfile

- in your project's directory in terminal type `Pod init` if you have not created Podfile yet
- add `source 'https://github.com/CocoaPods/Specs.git'` to your Podfile
- add `pod 'HDLogger', '~> 0.9.0'` for you target
- type `pod install` in terminal to download library

### Example Pod file

```ruby
source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/HumanDevice/ios-logger.git'

target 'HDLoggerExample' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for HDLoggerExample
  pod 'HDLogger', '~> 0.9.0'
end
```

# Usage

## Basic usage

Add `import HDLogger` to file where you want to use logger.

In specified place use one of the following functions

```swift
Log.verbose("verbose message")
Log.debug("debug message")
Log.info("info message")
Log.warning("warning message")
Log.error("error message")
```

## Configuration

Access configuration struct using following call to configure logger

```swift
Log.sharedInstance.config
```


