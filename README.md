# studentapp

A new Flutter project.

## Getting Started


*SetUp Instructions*
A documentaion of the things I did and how I did it.

*Clean Code Architecture*
Clean Code Architecture, introduced by Robert C. Martin (Uncle Bob), promotes maintainable, scalable, and testable software design by dividing code into layers with clear responsibilities. This architecture isolates core logic from external concerns, making the codebase more adaptable to change.

Key Principles
Separation of Concerns: Each layer has distinct responsibilities, isolating business logic from frameworks and external components.

Dependency Inversion: High-level modules (like business logic) do not depend on low-level modules (like the UI or data sources). Instead, they depend on abstractions, making it easier to replace or mock components during testing.

Testability: Since dependencies are isolated, each layer can be tested independently, ensuring more reliable code.

Adaptability: By isolating different parts of the system, we can switch frameworks, data sources, or UI without affecting core business logic.

*The clean code architecture is the coding style used.*

├── core/                    # Core logic, shared code, and base classes
├── features/
│   ├── feature_name/
│   │   ├── data/            # Data sources, models, repositories
│   │   ├── domain/          # Entities and Use Cases
│   │   └── presentation/    # UI-related code
└── main.dart                # Entry point


I made use of Privider for my state managemnet.
I decided to animate the container and asset on the dashboard.  and the Navigation Bar.

I also demostrated how I can use normal navigation system and the name route method.

You can drag down the screen to refresh list.


*Feature Overview*

Feature Overview
This app provides functionalities for managing and displaying student information efficiently. Here are the main features:

1. List of Students
Description: Displays a list of all students saved locally on the device.
Details: Users can scroll through this list to view student details, including names, email addresses, and enrollment status.

2. Add Student
Description: Allows users to add a new student by entering their details.
Details: On this screen, users can input a student’s name, email, enrollment status, and an optional profile photo. The new student will then appear in the local list.

3. Delete Student
Description: Enables users to delete a student from the list.
Details: Users can remove a student’s information permanently, and a confirmation prompt will be displayed to prevent accidental deletions.

4. Student List from Endpoint
Description: Displays an up-to-date list of students fetched from a server.
Details: This tab calls a local server API endpoint to retrieve a dynamic list of students. This feature ensures that users have access to the latest student information, synced with the server.
Steps on how to start the server locally is below...


//////////////////////////////////////////////////////////
/////////////////////////////////////////////
/////////////////////////////////////////////

//Steps to setup local server for mocking the api call.
*For the API mock Calls.*


Step 1 (Mac Users)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

So Json_server is not supported anymore as it has been discontinued. I had to look for another way to simulate api calls. Here is  a step by step proces of how to run the local server to test the mock api calls.

Step 2
brew install node

Step3
npm install -g json-server

Step4
json-server --watch db.json --port 3000 (this start and watch the server).

the db.json file is in the project directory.
Once the Server is on, you can go ahead and fetch list of students.


*Limitaitons*
The process of adding a student to the local storage works as expected, but it has not been fully tested in local server scenarios. 

No Real-Time API Integration
Limitation: The app is currently using mock data and local storage to simulate API interactions. There is no live data fetched from or pushed to a real backend server at the moment.


/////////
- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
