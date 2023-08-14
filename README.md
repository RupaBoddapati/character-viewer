# Character Viewer App
This app allows us to view the list of characters using the API from DuckDuckGo and it is written entirely using the Flutter framework, supporting both IOS and Android platforms. This supports both potrait and landscape orientations. 

https://github.com/RupaBoddapati/character-viewer/assets/142184584/464852d0-d458-4796-8411-0f47bef43eed
https://github.com/RupaBoddapati/character-viewer/assets/142184584/75f8fbe3-9c43-487b-a34c-b163ed5e6135

## Dependencies & versions
Current Flutter version 3.3.9
Install all dependecies:
```bash
flutter pub get
```

## How to run the App
1) Clone the application to your desktop.
2) Open the project from the IDE and run the below commands from the terminal screen of the project.
```bash
## The below command builds and runs "The Wire Character Viewer" app.
flutter run -t lib/main_wire.dart --flavor the_wire_character_viewer
## The below command builds and runs "Simpsons Character Viewer" app.
flutter run -t lib/main_simpsons.dart --flavor simpsons_character_viewer
```

## App Features
1) Orientation Support: The app adapts to portrait and landscape orientations on all devices.
2) List View: Displays a scrollable list of character names.
3) Search Functionality: Users can filter the list based on titles or descriptions.
4) Detail View: Clicking on a character opens a detailed view with image, title, and description.
5) Image Handling: The detail view image uses the "Icon" field from the API JSON response. Missing images are replaced with placeholders resolved using https://duckduckgo.com/.
6) Shared Codebase: The app is structured with a single codebase, managing the two variants efficiently.
7) Unit Tests: Critical and high-priority functionality are covered by unit tests.
