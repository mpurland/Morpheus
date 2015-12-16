Morpheus
========

Morpheus is a Swift library for functional and reactive MVVM.

:warning: This is very alpha :warning:

Setup
-----

To add Morpheus to your application:

**Using Carthage**

- Add Morpheus to your Cartfile
- Run `carthage update`
- Drag the relevant copy of Morpheus into your project.
- Expand the Link Binary With Libraries phase
- Click the + and add Morpheus
- Click the + at the top left corner to add a Copy Files build phase
- Set the directory to `Frameworks`
- Click the + and add Morpheus

**Using Git Submodules**

- Clone Morpheus as a submodule into the directory of your choice
- Run `git submodule init -i --recursive`
- Drag `Morpheus.xcodeproj` or `Morpheus-iOS.xcodeproj` into your project tree as a subproject
- Under your project's Build Phases, expand Target Dependencies
- Click the + and add Morpheus
- Expand the Link Binary With Libraries phase
- Click the + and add Morpheus
- Click the + at the top left corner to add a Copy Files build phase
- Set the directory to `Frameworks`
- Click the + and add Morpheus

License
=======

Morpheus is released under the BSD license.
