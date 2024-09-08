![updated-weathy-icon.png](screenshots%2Fupdated-weathy-icon.png)
# weathy
Weathy is a mobile application that provides real-time weather updates, including current conditions, tomorrow’s forecast, and a 10-day outlook. It also features upcoming football matches for your location and a 10-month weather forecast, allowing you to stay informed and plan ahead with ease.

**Table of Contents**
- Features and usage
- Technologies used
- File Hierarchy
- How it looks
- How to install
- Code Extraction
________________________________________________________________

### Features and usage

The Weathy app provides a comprehensive weather experience with the following features:

- **Current Weather**: Get up-to-date weather conditions for any selected location.

- **Statistics Graphs**: explore every hour condition over the day.

- **Tomorrow's Forecast**: View the weather forecast for the next day.

- **10-Day Outlook**: Access a detailed weather forecast for the upcoming 10 days.

- **Football Matches**: Check upcoming football matches in the selected location.

- **10-Month Forecast**: Plan ahead with a long-term weather forecast for the next 10 months.

*Stay informed about the weather and sports events with Weathy!*

### Technologies used

- Dart
- Flutter 
- Restful API
- LocalStorage
- - Shared Preferences
- - Hive
- Bloc(Cubit)
- Google Maps
- GeoLocator
- Clean Architecture
- Handmade (Rangy Custom Date-Picker)

### File Hierarchy
```
.
└── weathy
    └── lib
        ├── core
        │   ├── assets
        │   │   └── icons/
        │   ├── constants/
        │   ├── env/
        │   ├── theme/
        │   └── utils
        │       ├── components/
        │       ├── extensions/
        │       ├── geo_locator/
        │       ├── inner_models/
        │       └── shared_pref/
        └── features
            ├── date_picker
            │   └── cubit/
            ├── loading_animation/
            ├── maps_screen
            │   └── cubit/
            ├── on_boarding
            │   └── presentation/
            └── weather_screens
                ├── data
                │   ├── data_source/
                │   ├── models/
                │   └── repositories/
                ├── domain
                │   ├── repositories/
                │   └── usecases/
                └── presentation
                    ├── controllers/
                    ├── helpers/
                    ├── screens/
                    └── tabs/
```

### How it looks
![all-in-one-1.png](screenshots%2Fall-in-one-1.png)
![all-in-one-2.png](screenshots%2Fall-in-one-2.png)
![all-in-one-3.png](screenshots%2Fall-in-one-3.png)
![all-in-one-4.png](screenshots%2Fall-in-one-4.png)

you could see screenshots singularly, just go to [screenshots](screenshots) dir.

>For more, watch the following video that demonstrate a walkthrough features of *weathy*:
>
>[Video Preview](https://www.youtube.com/watch?v=pLG6YFbE4Eg)

### How to install

Firstly, You should know this app interacts with an API in which you should have your own `API KEY`, to get one just register on [weatherapi](https://www.weatherapi.com/). once you got a key you can follow the following steps:
1. ```
   git clone https://github.com/AliEsmaeil/weathy.git 
   ```
2. in your project level `weathy`, create a `.env` file and store your `API Key` there.
 this is related to sensitive environment variables hiding (You key shouldn't be exposed in public repos)
for more info about this, you could see my repo [api-key-hiding-client](https://github.com/AliEsmaeil/api-key-hiding-client), this repo involves a detailed explanation of how to hide your api key.

3. ```
   flutter clean
   ``` 
4. ```
   flutter pub get   
   ```
5. ```
   dart run build_runner watch --delete-conflicting-outputs
   ```
   The fifth step to just make sure the generated files are already up and regenerate `_Config.g.dart` file which obfuscates the key you have put in `.env` file.

And you are done, go ahead and run.

### Code Extraction
While this repository is licensed under the Apache License 2.0, we would like to highlight the following important points:

- Code Extraction: Please refrain from extracting code from this repository for use in other projects. The code is provided for the purposes of learning, experimentation, and contribution to this project only.

- Respect the License: Ensure that any use of the code complies with the terms of the Apache License 2.0. The license permits use, modification, and distribution, but does not allow for code extraction for patent-related claims.

Last, but not least this repo is welcoming contribution so, feel free to open a pull request.
