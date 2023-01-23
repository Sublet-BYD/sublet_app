# Sublet

Welcome to the official home of the Sublet app! Our application is an open-source project meant to connect all sides involved in a sublet deal.

### What is a sublet?

A sublet is a lease of a temporarily vacant property. A most frequent example for a sublet deal would be an owner traveling for a short expedition, such as a vacation or bussiness trip, and not willing to leave their property unoccupied, leasing it to a willing renter. This method of temporary housing is very popular in isreal, but can only be found in close friend groups or dedicated forums on social media. Our application is here to fix that, and offer a true home for any and all sublet deals.

### What makes our application different than other solutions?

While other popular solutions for subletting act as mediators between a landlord and renter, we focus on short-time sublets, with the important distinction between landlord and host, and renter and owner. The main goal of our app is to offer a place for spontaneous travelers to house their property to any apertment-seeking person of their choice.

## About our code

Our application uses the Google framworks Flutter and Firebase, to have the best connection of the front and back end of the project. Flutter is a relatively new framework offered by Google to develop applications using a single codebase. Since its inception, Flutter was meant to work as a front end to applications using Firebase, and so the connection between the two frameworks is as close to optimal as is achievable.

This project is structured using the MVVM architectural pattern, in order to match the concepts of Flutter. Flutter is meant to be used with the MVVM pattern, using its [providers](https://docs.flutter.dev/development/data-and-backend/state-mgmt/simple) as the view model. A Flutter provider is an app management tool which is used to transfer data between different screens and processes in the application. Our project uses providers in the same way; those providers can be found in the folder //lib/providers.

## How To Run

In order to run this application, do the following:

1. Clone the git repository/download the code to your local machine.
2. Open the project using your preferred IDE (we recommend VS code, as it supports both flutter and local emulators).
3. Open an android emulator of version 10.0 and upwards (or connect your personal device, if it fits the requirements).
4. Select your emulator/device as the preffered device for the IDE
5. Press run or type 'flutter run' in the terminal
6. You're good to go!

We consider our application to be fairly intuitive in terms of user experience; however, we do concede that, as any application, it might be confusing to some at first. For those few, we have included some examples of the application in action below:

### Host home page

Here we see a user of type Host (they have permission to post and manage properties) logging in to their account:



https://user-images.githubusercontent.com/92798950/213928256-da4cb211-9576-4756-8dcf-0c4354013356.mp4


After the user's credentials are confirmed, they are transferred to their home page: the manage_properties page, where they can see all their properties, add new properties using the add button on the bottom right, view and edit indicidual properties by clicking on them and moving to their own page, manage chats with guests on the other tab, and manage their own profile by clicking the app drawer on the top left.


### Host New Property Screen

This next picture is a screeenshot of a new property in the making; we can see the user has provided data for the property in multiple formats and uploaded multiple pictures to describe the property:

![Picture1](https://user-images.githubusercontent.com/92798950/213929394-5c86697f-67c6-443b-b732-44096dc0a3ac.jpg)


### Guest Property Screen

Here we see a screenshot of a property screen from a guest's perspective; this page offers much data about the desired property for the client. other than a picture of the asset (with the option for the host to post multiple) and other important descriptors, the guest has the option of moving to a new chat with the owner of the property, in order to discuss the terms of their potential sublet deal.

![Picture2](https://user-images.githubusercontent.com/92798950/213930882-8f97f9c7-910a-4b62-accb-26a97ca185d7.gif)



## About us

Introducing this project are: Barak Dafna, Daniel Zer Kavod, and Yossie Kachlon. you can find our individual github pages here:

[Daniel](https://github.com/danielzk107)   [Yosef](https://github.com/YosefKahlon)   [Barak](https://github.com/barakdf)

We are third year students for CS in Ariel University; this project was submitted as the main assignment for the course "Software Engineering". 



 
