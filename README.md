# Urbanlink
<img width="450" alt="image" src="https://user-images.githubusercontent.com/103521468/229154323-64367792-f505-47d9-b270-25e509b9a2cf.png">


## Who are we? <img src="https://raw.githubusercontent.com/MartinHeinz/MartinHeinz/master/wave.gif" width="30px">
>Hi , we are Urbanlink team. We are a team of students from Hongik University in South Korea.
>You can find us on github link.

<table>
    <tr aling="center">
        <td><B>기획 / 모바일 / 백엔드<B></td>
        <td><B>ML / 데이터베이스<B></td>
        <td><B>모바일<B></td>
        <td><B>데이터베이스<B></td>
    </tr>
    <tr align="center">
        <td><B><a href="https://github.com/nx006">이준선</a><B></td>
        <td><B><a href="https://github.com/doammii">김도연</a><B></td>
        <td><B><a href="https://github.com/SHL3">이소현</a><B></td>
        <td><B><a href="https://github.com/baebaebuae">권재현</a><B></td>
    </tr>
    <tr align="center">
        <td>
            <img src="https://github.com/nx006.png" width="100">
        </td>
        <td>
            <img src="https://github.com/doammii.png" width="100">
        </td>
        <td>
            <img src="https://github.com/SHL3.png" width="100">
        </td>
        <td>
            <img src="https://github.com/baebaebuae.png" width="100">
        </td>
    </tr>
</table>

## What's Urbanlink?
* It is a 'space-based multi-purpose community app'.
* Our app’s goal is to help users appreciate and rediscover their local surroundings, transforming them into more vibrant and dynamic spaces.
* Often, we might overlook events happening nearby, but with our service, users can stay informed about their city, local happenings, and the people who livin our city.

### <a href="https://www.youtube.com/watch?v=EOs8m5CF9bQ">See Demo videos here! 🎬</a>

### Features
* You can create a community based on the location keyword found.
* You can create a post with a location tag and images.
* You can add comments, likes, and dislikes to each post to communicate with people in the community.

### Tech Stack
<img src="https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white"> <img src="https://img.shields.io/badge/Firebase-FFCA28?style=flat-square&logo=firebase&logoColor=white"> <img src="https://img.shields.io/badge/Dart-0175C2?style=flat-square&logo=dart&logoColor=white">

## Configuration pages

|First screen|Login|Profile|
|:---:|:---:|:---:|
|<img width="250" alt="first screen" src="https://user-images.githubusercontent.com/103521468/229154729-e0289e00-bff3-41f4-80e1-690bfd4edd5a.png">|<img width="250" alt ="login screen" src="https://user-images.githubusercontent.com/103521468/229152138-6160c3dc-f967-4a2d-83f9-15790518a321.png">|<img width="250" src="https://user-images.githubusercontent.com/103521468/229155590-f55a4609-8d72-4e02-9705-cb317595b3e2.png">|


|Profile Setting|Home|Map|
|:---:|:---:|:---:|
|<img width="250" src="https://user-images.githubusercontent.com/103521468/229160900-1219c893-8027-4d4b-913b-45399e4f100f.png">|<img src="https://user-images.githubusercontent.com/103521468/229155970-42905c70-d13f-477e-be94-ec6c6605da62.png" width="250">|<img src="https://user-images.githubusercontent.com/103521468/229156088-70087fba-2c88-460d-a141-3b5221514ed3.png" width="250">|

|Community|Searching for community location|Specific community|
|:---:|:---:|:---:|
|<img src="https://user-images.githubusercontent.com/103521468/229156353-68331144-acb4-49b8-a1e0-64cdd0a41924.png" width="250">|<img src="https://user-images.githubusercontent.com/103521468/229156375-47f6a957-2bf5-40df-b025-78fda4cab497.png" width="250">|<img src="https://user-images.githubusercontent.com/103521468/229156437-8bcb3296-fe17-47ad-992d-83b835e94110.png" width="250">|

|Posting - post and images|Searching for post location|Comments and appreciation|
|------|------|------|
|<img src="https://user-images.githubusercontent.com/103521468/229157072-461fac28-f955-44e4-a3d9-e1cdefa7e26e.gif" width="250">|<img src="https://user-images.githubusercontent.com/103521468/229157464-bf4142f0-bbe7-4826-ab07-ca3f341c2f4b.gif" width="250">|<img src="https://user-images.githubusercontent.com/103521468/229157643-0bc3b865-6a5b-4f29-83f6-579d8c057fe0.png" width="250">|

</br>

### UI description
* First screen: The blue circle of animation represents the space where the user has a relationship with others based on the space, and the expansion and movement of the circle represents the purpose of the app, "human connection."
* Map page: You can see the area where the community was formed at the location of the circle, and the size of the circle indicates the range of the community. When you press the bottom button, the community with the fast speed of generating posts among the communities is emphasized through color and size variations. This function is designed to share issues around the world, and the increased accessibility resulting from this effect also leads to increased communication as it broadens the user's spatial awareness.

</br>

## Development process  
1. Design Sprint  
* Understand and Define
* Sketch
* Decide
* Make a prototype

2. Interim presentation and feedback  
[![Urbanlink](https://user-images.githubusercontent.com/100724454/229185193-004b06b4-5732-4e71-be8a-798544276054.png)](https://www.youtube.com/watch?v=zZy-AX7FYLo)

3. Implementation  
* Use Flutter : As a cross-platform framework, we created an app using the advantage of good productivity.
* Use Firebase : In the beginning of DB design, we tried to use the 'sqlLite', relational database of pub.dev package. However, we decided to use Firestore because we thought it would be convenient to use NOSQL-based Firestore, which is internally supported by Flutter, including various cloud features.
* Use 'Git flow' for team collaboration : We divided git branches into 'main', 'develop', and 'feature'. Every time each 'develop' branch is completed, a pull request was made in the develop branch and finally merged into the main branch.  
 
</br>

## Future plans  
We are planning to add a space recommendation function in the future. Also, in terms of pursuing convergence in urban spaces such as parks and youth shelters, we are considering promoting the space by recommending the places we paid attention to. In addition, by applying machine learning technology, we're considering to assign appropriate tags and attributes to a space. This will help users know the space better and get attracted even before they visit the space.

## How To Run
### Prerequisites
Before running the app, you need to install the following software.
* [Flutter](https://flutter.dev/docs/get-started/install)
* [Android Studio](https://developer.android.com/studio)
* [Xcode](https://developer.apple.com/xcode/)

Android Studio and Xcode are required to run the app on Android and iOS devices, respectively.
Xcode is only available on macOS, so if you're using Windows or Linux, you can use Android Studio to run the app on Android devices.

Run `flutter doctor` to check if you have all the required software installed.

```bash
$ flutter doctor
```

Result should be similar to this:
```bash
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 3.7.8, on macOS 13.2.1 22D68 darwin-arm64, locale ko-KR)
[✓] Android toolchain - develop for Android devices (Android SDK version 33.0.2)
[✓] Xcode - develop for iOS and macOS (Xcode 14.2)
[✓] Chrome - develop for the web
[✓] Android Studio (version 2022.1)
[✓] IntelliJ IDEA Ultimate Edition (version 2022.3.2)
[✓] VS Code (version 1.77.0)
[✓] Connected device (2 available)
[✓] HTTP Host Availability

• No issues found!
```

1. Clone this repository
```bash
$ git clone https://github.com/HongikB612/UrbanLink.git
```

2. Install dependencies
```bash
$ flutter pub get
```

3. Run the app
Open the terminal on the project directory and run the following command.
```bash
$ flutter run
```

Or in vscode, press `F5` to run the app, or 'Run' button above the main function.

When first running the flutter app, it will take some time to download the required dependencies, build the app, and run it on the device.
