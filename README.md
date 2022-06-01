
#  ****iOS Engg. Test****

  

## Contains a test to compute 3 things in a given HTML file by the engineering team.  

## **Application Architecture**

  

The App is written using **VIPER**  since Viper offers a wide range of advantages over other architectures. The capability to segregate responsibilities amongst various components is ideal. This makes the code READABLE, SCALABLE, MODULAR and ROBUST. Although this being a single view app the capabilities of the ROUTER could not be demonstrated.

The Code uses ****Dependency Injections (DI)**** in most places which makes it easy to write tests and provides great flexibility in Mocking methods and classes.

App folder structure promotes VIPER and also differentiates between Builders, Managers, Modules and Utilities to delegate responsibilities and make the code flexible and reusable.

This code contains some basic ****Unit Tests**** to test the __DashboardViewController__ class, but they have been included to test the flow of function calls and covers almost all aspects of this single view app by achieving a coverage of almost +50%.

__These tests are to demonstrate the concepts used for writing various Unit Tests__. More tests could be included to increase the coverage report.

The UI is pretty basic and supports multiple form factors of ****iPhone****.  

## ****Pods Included****

  There are 2 pods included:

 1. [SwiftCSV](https://github.com/swiftcsv/SwiftCSV)
 2. [Kingfisher](https://github.com/onevcat/Kingfisher)

SwiftCSV is a simple library to parse CSV data with different types of delimiters included.

Kingfisher is a popular 100% SWIFT image caching library. Its is lightweight and is bare minimum to get the job done.
