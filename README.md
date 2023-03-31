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
        <td><B>이준선<B></td>
        <td><B>김도연<B></td>
        <td><B>이소현<B></td>
        <td><B>권재현<B></td>
    </tr>
    <tr align="center">
        <td>
            <img src="https://github.com/nx006.png" width="100">
            <br>
            <a href="https://github.com/nx006"><I>이준선</I></a>
        </td>
        <td>
            <img src="https://github.com/scarletKim2001.png" width="100">
            <br>
            <a href="https://github.com/scarletKim2001"><I>김도연</I></a>
        </td>
        <td>
            <img src="https://github.com/SHL3.png" width="100">
            <br>
            <a href="https://github.com/SHL3"><I>이소현</I></a>
        </td>
        <td>
            <img src="https://github.com/baebaebuae.png" width="100">
            <br>
            <a href="https://github.com/baebaebuae"><I>권재현</I></a>
        </td>
    </tr>
</table>

## What's Urbanlink?
* It is a 'space-based multi-purpose community app'.
* Our app’s goal is to help users appreciate and rediscover their local surroundings, transforming them into more vibrant and dynamic spaces.
* Often, we might overlook events happening nearby, but with our service, users can stay informed about their city, local happenings, and the people who livin our city.

### See Demo Video here! 📽️
<br><a href="https://www.youtube.com/watch?v=EOs8m5CF9bQ"><I>See Demo videos here! 🎬</I></a></br>

### Functions
* You can create a community based on the location keyword found.
* You can create a post with a location tag and images.
* You can add comments, likes, and dislikes to each post to communicate with people in the community.

### Technologies
<img src="https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white"> <img src="https://img.shields.io/badge/Firebase-FFCA28?style=flat-square&logo=firebase&logoColor=white"> <img src="https://img.shields.io/badge/Dart-0175C2?style=flat-square&logo=dart&logoColor=white">

</br>

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