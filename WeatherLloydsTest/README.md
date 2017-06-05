The app will run in every iOS device, in any orientation. Although iPhone landscape layout needs tweaking.
Please feel free to run it in any of the device simulator provided by the latest Xcode version.
I have used VIPER to architecture the app, although Routing and Wireframing have not been needed as it is a sinle view app.

With more time I would have developed:
+ Use of protocols and injection in order to be able to Unit Test the code properly.
+ Error handlig. Although I have implemented several errors, specially in the networking layer, they are 
not being actually handled properly by the UI.
+ Added some transitions animations
+ Added a Pull To Refresh
+ Cache API responses to be able to present information to the user in case of no internet reachavility.
