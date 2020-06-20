# NYT-Articles
An app to display a list of New York Times News

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

## Project structure:

* ViewModel: viewmodel objects with all logic
* Model: data model objects
* Network: Networking Layer
* Support: Code supporting the main functions

## Next step:

*  add the unit test with Rxtest

## Author:

*  Qi Li

## Contact:

* https://www.linkedin.com/in/lee-qi/
* www.leeqii.com
