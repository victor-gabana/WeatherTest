# WeatherTest

## Running the app
The app will run in every iOS device, in any orientation. Please feel free to run it in any of the device simulator provided by the latest Xcode version.

## Running tests
I have added some UnitTests for ForecastPresenter. Some mocks and a stub have been created in order to write these tests. All tests are passing.

## Architecture
I have used VIPER to architecture the app, although Routing and Wireframing have not been needed as it is a single view app.

## 3rd party libraries 
No 3rd party libraries have been used in the development of this test.

## Improvements with more time:

* Extend the Unit Test coverage
* Add UITests, Automation Tests, Integration Tests and Acceptance Tests
* Error handlig. Although I have implemented several errors, specially in the networking layer, they are not being actually handled properly by the UI.
* Cache API responses to be able to present information to the user in case of no internet reachavility.
* Improve the UI for every device and orientation
* Add a Pull To Refresh
* Add some sleek animations


Thanks for your time. Hope you like it.
