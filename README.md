# studentapp

A new Flutter project.

## Getting Started

A documentaion of the things I did and how I did it.

The clean code architecture is the coding style used
I made use of Privider for my state managemnet.
I decided to animate the container and asset on the dashboard.  and the Navigation Bar.

I also demostrated how I can use normal navigation system and the name route method.

You can drag down the screen to refresh list.







//////////////////////////////////////////////////////////
/////////////////////////////////////////////
/////////////////////////////////////////////

//Steps to setup local server for mocking the api call.
For the API mock Calls.


Step 1
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

So Json_server is not supported anymore as it has been discontinued. I had to look for another way to simulate api calls. Here is  a step by step proces of how to run the local server to test the mock api calls.

Step 2
brew install node

Step3
npm install -g json-server

Step4
json-server --watch db.json --port 3000 (this start and watch the server).

the db.json file is in the project directory.








/////////
- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
