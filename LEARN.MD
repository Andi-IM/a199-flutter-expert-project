# How to understand this project structure
to read this in INDONESIA [click this](LEARN_ID.MD). This project was used for dicoding flutter submission.
<b>Warning, use this project just for guide, don't copy and paste!</b>

## Why the file 'custom_drawer.dart' is exist?
You can read this course material: https://www.dicoding.com/academies/199/tutorials/19832.
it looks like this:
<p align="center">
    <img src="https://dicoding-web-img.sgp1.cdn.digitaloceanspaces.com/original/academy/dos:3418aae7e5130f925d085a8a601f812d20210921110424.gif" width="500">
</p>

## What is injection.dart on lib?
read more on: https://www.dicoding.com/academies/199/tutorials/19357
> Dependency Injection (DI) is a design pattern used to implement Inversion of Control. It allows the creation of dependent objects outside of a class and provides those objects to a class through different ways. Using DI, we move the creation and binding of the dependent objects outside of the class that depends on them. This brings a higher level of flexibility, decoupling, and easier testing.

## Why injection?
- Make testing easier
- Avoid Tightly Coupled

## How to create this project as modular

more info on : 
- https://www.dicoding.com/academies/199/tutorials/19862
- https://medium.com/flutter-community/mastering-flutter-modularization-in-several-ways-f5bced19101a

## What is Modularization
> Modular programming is a software design technique to separate functionality into independent, interchangeable module, so that each contains everything necessary to execute a specific functionality.

<p align="center">
<img src="https://dicoding-web-img.sgp1.cdn.digitaloceanspaces.com/original/academy/dos:7ffe87c509effa2964ae6dbeb41f461520210921141751.jpeg" height=200/>
</p>

For starting modularization, you must follow the steps shown on [this](https://www.dicoding.com/academies/199/tutorials/19877).

basic for modularization is:
```bash
flutter create --template=package name_of_module
```

for example:
```bash
# more info on: https://www.dicoding.com/academies/199/tutorials/19877
flutter create --template=package about
```

