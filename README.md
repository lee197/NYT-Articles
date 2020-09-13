# NYT-Articles
(Rxswift + MVVM) An app to display a list of New York Times News

## Branches:

* master - stable app releases
* develop - development branch, merge features branches here

## New York Times Articles API:

* Emailed Sorted News: https://api.nytimes.com/svc/mostpopular/v2/emailed/7.json?api-key=dylOnQnYUzEF1B9MTYYHM0MyffMPBZRi
* Viewed Sorted News: https://api.nytimes.com/svc/mostpopular/v2/viewed/7.json?api-key=dylOnQnYUzEF1B9MTYYHM0MyffMPBZRi
* Shared Sorted News: https://api.nytimes.com/svc/mostpopular/v2/shared/7.json?api-key=dylOnQnYUzEF1B9MTYYHM0MyffMPBZRi

## Dependencies:

The project is using cocoapods for managing external libraries and a Gemfile for managing the cocoapods version.

In case you need to use cocoapods, please follow the instructions: 

Installation
```
$ sudo gem install cocoapods
```
Then install the pods in your Xcode project directory:
```
$ pod install
```
Run Project:
```
cmd + R
```

Run Test:
```
cmd + U
```

## Project structure:

* ViewModel: viewmodel objects with all logic
* Model: data model objects
* Network: Networking Layer
* Support: Code supporting the main functions
## References:
* Rxtest: https://benoitpasquier.com/how-to-use-rxtests-to-test-mvvm/
* Rxtest tutorail: https://www.raywenderlich.com/7408-testing-your-rxswift-code
* Rxswift with URLSession: https://www.codementor.io/@mehobega/urlsession-web-api-calls-reactive-way-rxswift-rxcocoa-10kmc5h669
* Rxswif testable MVVM: https://medium.com/blablacar-tech/rxswift-mvvm-66827b8b3f10

## Next step:

*  add the unit test with Rxtest

## Author:

*  Qi Li

## Contact:

* https://www.linkedin.com/in/lee-qi/
* www.leeqii.com
