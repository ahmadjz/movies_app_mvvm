# Movies Store Flutter App

This is a Movies Store Flutter App that allows users to browse and search movies, add movies to their watchlist, and manage their profile. The application uses Clean Architecture and the MVVM pattern.

## Project Architecture

The project is structured using the Clean Architecture pattern, which separates the codebase into three main layers:

- Presentation Layer (UI) - Contains the UI code and its related classes.
- Domain Layer - Contains the use cases, business logic, and entities of the app.
- Data Layer - Contains the implementation of data sources, repositories, and models.

The project also implements the MVVM pattern in the Presentation Layer, which separates the UI code from the business logic and improves testability.

Here is a diagram illustrating the project architecture:

![Clean-Architecture-Flutter-Diagram](https://user-images.githubusercontent.com/46372418/225314861-2d5e98b9-06a5-453b-8ebf-e6a349a8a23c.jpg)

## Main Screens  

1. **Login Screen**: This screen allows users to log in using their email and password. Validations are performed for email and password inputs, with error messages displayed for any invalid input. Once logged in, user information is stored in SharedPreferences, allowing direct navigation to the Home screen on subsequent app launches.
2. **Home Screen**: Displays movie categories fetched from a remote source. Categories are cached using SharedPreferences for offline access. A search bar is included for searching within categories.
3. **Movies List Screen**: Shows a list of movies within a selected category. Movies are fetched from a remote source and cached using SharedPreferences for offline access. A search bar is included for searching within movies. If a category doesn't have movies yet, a no data animation label is displayed.
4. **Movie Details Screen**: Displays detailed information about a movie, including an embedded YouTube trailer, title, rating, summary, year, actors, director, and writers. A dynamic button allows users to add or remove the movie from their watchlist.
5. **WatchList Screen**: Lists movies added to the user's watchlist. If the watchlist is empty, a no data animation is displayed. A search bar is included for searching within watchlist movies.
6. **Profile Screen**: Allows users to log out, removing their logged-in status and watchlist data from SharedPreferences.

## Videos
[Mobile Screen](https://drive.google.com/file/d/1qfchzpPAqN-dXPuIVY3IpMjnDQNC5qIt/view?usp=share_link)

## Flutter Environment Check
Before running the app, ensure that your development environment meets the required dependencies and configurations by running `flutter doctor`. Here's an example screenshot of a `flutter doctor` output:
![Screenshot from 2023-03-21 16-05-30](https://user-images.githubusercontent.com/46372418/226614816-93ac529c-0840-419f-9fe6-2cceb55a2b27.png)

If you encounter any issues or missing dependencies, please refer to the [Flutter documentation](https://flutter.dev/docs/get-started/install) for guidance on setting up your development environment.
