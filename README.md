<p align="center">
  

# Inglo, international awareness community flutter application

<img width="194" alt="스크린샷 2024-02-26 오전 9 55 19" src="https://github.com/bianbbc87/new/assets/129590633/085aaa87-2dbe-4e7a-90e0-c3852389c04e">

2023-GDSC-Solution-Challenge flutter project

</p>

## Table of Contents

- [Getting_Started](#getting_started)
- [Components](#components)
- [Main_Function](#main_function)
  - [Issue](#issue)
  - [Solution Sketch](#solution-sketch)
    - [Problem Definition](#problem-definition)
    - [HMW](#hmw)
    - [Crazy'8](#crazy'8)
    - [Solution Sketch](#solution-sketch)
  - [Home](#home)
  - [Post](#post)
    - [Feedback](#feedback)
  - [My](#my)
    - [Global Impact](#global-impact)
- [Sub_Function](#sub_function)
- [Futhermore](#furthermore)
- [Download](#download-apk)
- [API](#api)
- [Contributors](#contributors)

## Getting_Started

### What is Inglo?

<p align="center">

***`Let's find out the issues of SDGS around the world, and let's solve them all together!`*** 
 As of 2019, aid to Africa and underdeveloped countries were on the rise before the COVID-19 outbreak, but after the COVID-19 outbreak, the UN predicted that aid to middle- and low-income countries, which are the economic lifeline of numerous poor families, would decrease. UNESCO said that 'sustainable development goals' are the last of the SDGS goals, but they are also the underlying goals for achieving other goals. 
 Global partnership refers to cooperation between governments, private, civil society, and comprehensive partnerships at the global, regional, and national levels. Among the detailed goals of Goal 17, there is "encouraging and promoting effective public, public-private, and civil society partnerships based on the financing strategies and experiences of partnership institutions." Just as partnerships between public and private civil society in one country are important, our team thought that promoting global partnerships with citizens of other countries would eventually contribute to public partnerships. Therefore, the service was planned with the aim of achieving SDGS through global partnerships.

## What is Sustainable Development Goals?

![image](https://user-images.githubusercontent.com/33146152/160327143-e36bb1b9-ccea-4f96-b3b2-d92338dd56c5.png)

The Sustainable Development Goals (SGDs) or Global Goals are a collection of 17 interlinked global goals designed to be a "blueprint to achieve a better and more sustainable future for all.
As can be seen in the figure above, there are 17 goals.

### Our goal

A flutter application was created by selecting several of the UN's 17 sustainable development goals. SDGS and sustainable development goals were thought to be a global partnership, and they planned to get to know each other by sharing issue data from around the world. In the planning process, Google's design print methodology was used, and I thought that the process of deriving a solution sketch from this methodology was good for deriving and developing ideas.

#### Global Partners Growing Together

![sdgs17](https://github.com/bianbbc87/new/assets/129590633/ee16cf29-3ebd-458f-9453-a5060d143b04)

Users of the app can check the news of the selected SDGS category while using this app and host a solution sketch. They can also share their opinions on the news with people and friends all over the world. In addition, they can form a global partnership by creating a post that cites their solution sketch and exchanging feedback with each other.

### The reason why we named "inglo"

<img width="499" alt="스크린샷 2024-02-26 오전 9 45 48" src="https://github.com/bianbbc87/new/assets/129590633/4172af63-407a-44e6-9656-9ac95ba2671a">

inglo is a combination of insight and global, and I thought that receiving and sharing SDGS news data would broaden global insight. Since we respect each other and promote global partnerships through various activities such as solution sketch, post, and feedback, our team added several national images to the cover instead of using simple words to start the app, and the logo was created in the form of a globe reminiscent of global.

## Components

<img src="https://user-images.githubusercontent.com/33146152/160340776-616bc1a4-dd52-40a5-8e9f-dea06cd16952.png" width="120" height="100"> <img width="120" height="100" alt="스크린샷 2024-02-26 오전 9 46 36" src="https://github.com/bianbbc87/new/assets/129590633/5d5c45c7-7a2e-4c5c-aa51-c81891154393"> <img src="https://user-images.githubusercontent.com/33146152/160341802-7eceab71-16af-46c9-a74f-840c030c3abc.png" width="120" height="100"> <img width="120" height="100" src="https://github.com/GDSC-DGU/2024-SolutionChallenge-InGlo-client/assets/86873281/1308405c-7702-480f-b8d0-4911c487a26a"> <img width="120" height="100" src="https://github.com/GDSC-DGU/2024-SolutionChallenge-InGlo-client/assets/86873281/98a5691a-4d05-4994-8011-3a5705a4a029"> <img width="120" height="100" src="https://github.com/GDSC-DGU/2024-SolutionChallenge-InGlo-client/assets/86873281/be31568b-dd21-472f-a67d-73ca315a457a"> <img width="120" height="100" src="https://github.com/GDSC-DGU/2024-SolutionChallenge-InGlo-client/assets/86873281/3db7b91f-95be-4f84-8eac-49fefa7c4878"> <img width="120" height="100" src="https://github.com/GDSC-DGU/2024-SolutionChallenge-InGlo-client/assets/86873281/889fecc4-bd66-4915-88e0-e3b79d5b3b19"> <img width="120" height="100" src="https://github.com/GDSC-DGU/2024-SolutionChallenge-InGlo-client/assets/86873281/bd13b080-a1ae-44c9-93cb-8b5947d7c0cc"> <img width="120" heigth="100" src="https://github.com/GDSC-DGU/2024-SolutionChallenge-InGlo-client/assets/86873281/6bac65aa-0551-4717-928a-850ff07806ae"> <img width="120" height="100" src="https://github.com/GDSC-DGU/2024-SolutionChallenge-InGlo-client/assets/86873281/6916f22c-b6a8-4a2c-8b10-bea2fcc34ced">

- **Disign**
  - [Figma](https://www.figma.com/file/raNldHw9OcIkmgKLP4JYPN/solution-challenge?type=design&node-id=193%3A2339&mode=design&t=Dke0sG6zIzpxXdOH-1))
- **AI/ML** **(** [Python](https://www.python.org/) : `3.7.12` **)**
  - [Pytorch](https://pytorch.org/) : `2.1.0`
  - [Albert Model](https://arxiv.org/abs/1909.11942)
- **Back** **(** [Django](https://www.djangoproject.com/) : `4.2.6`
  - [Django Rest Framework](https://www.django-rest-framework.org/) : `3.14.0`
  - [Django Allauth](https://docs.allauth.org/en/latest/) : `0.61.1`
  - [GCP Compute Engine](https://cloud.google.com/products/compute?hl=ko)
  - [MySQL](https://www.mysql.com/)
  - [NGinX](https://www.nginx.com/)
  - [S3 bucket](https://aws.amazon.com/ko/s3/)
- **Front** **(** [Dart](https://dart.dev/) : `3.3.0` **)**
  - [Flutter](https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_2.10.3-stable.zip) : `1.19.1`
- **Device**
  1. Android Virtual Device
    - Pixel 7 Pro API VanillaIceCream
 
  2. IOS Virtual Device
    - IPhone 14
# Main_Function

## PREVIEW

<p align="center">
<img width="250" src="https://github.com/GDSC-DGU/2024-SolutionChallenge-InGlo-client/assets/86873281/434b3c4d-c4e4-40b2-b137-7b80522b2237">
  &nbsp;&nbsp;

## Issue

<p align="center">
<img width="250" alt="스크린샷 2024-02-26 오전 9 35 21" src="https://github.com/GDSC-DGU/2024-SolutionChallenge-InGlo-client/assets/86873281/7c134d1d-e8a1-4fbe-b589-8b29eea24bf3">
&nbsp;&nbsp;
<img width="250" alt="스크린샷 2024-02-26 오전 9 33 16" src="https://github.com/GDSC-DGU/2024-SolutionChallenge-InGlo-client/assets/86873281/e8304d7b-b097-4c42-809b-079e5b56c9f3">
</p>
&nbsp;&nbsp;
 If you log in after the initial installation, you will be directed to the issue. Through the dropdown above, you can select the SDGS of the category you want to see, and you can check the news content for the issue.

## Solution-Sketch
The issue may be identified, and solution sketching may proceed. It has steps of problem definition, how light we, crazy 8's, and solution sketch, and opinions are shared with other users.
<hr>

### Problem Definition
<p align="center">
<img width="250" alt="스크린샷 2024-02-26 오전 9 36 06" src="https://github.com/GDSC-DGU/2024-SolutionChallenge-InGlo-client/assets/86873281/572e3333-ff9f-43f6-bdcd-4efb05c131bf">
  &nbsp;&nbsp;

You can Create and Choose one of the Problem Definition about selected SDGs.

### HMW
<p align="center">
<img width="250" alt="스크린샷 2024-02-26 오전 9 36 06" src="https://github.com/GDSC-DGU/2024-SolutionChallenge-InGlo-client/assets/86873281/904549d8-133b-4df9-a2b5-0f3dfe8c5076">
  &nbsp;&nbsp;
  
<img width="250" alt="스크린샷 2024-02-26 오전 9 36 28" src="https://github.com/GDSC-DGU/2024-SolutionChallenge-InGlo-client/assets/86873281/6bfe1c63-e961-4640-88c2-0d43d56d3519">
  &nbsp;&nbsp;
</p>

You can Create 'How Might We' about selected 'Problem Definition' and choose one of them.

### Crazy'8
<p align="center">
<img width="250" alt="스크린샷 2024-02-26 오전 9 36 06" src="https://github.com/GDSC-DGU/2024-SolutionChallenge-InGlo-client/assets/86873281/c60bddfc-019b-43bd-972d-79e4b7ff3538">
  &nbsp;&nbsp;
<img width="250" alt="스크린샷 2024-02-26 오전 9 36 28" src="https://github.com/GDSC-DGU/2024-SolutionChallenge-InGlo-client/assets/86873281/e93092ea-6afd-4590-8c14-b6a33cdda219">
  &nbsp;&nbsp;
<img width="250" alt="스크린샷 2024-02-26 오전 9 36 28" src="https://github.com/GDSC-DGU/2024-SolutionChallenge-InGlo-client/assets/86873281/3c2a712a-9daf-4852-a4f0-c7e403fc9c29">
  &nbsp;&nbsp;
</p>

You can do 'Crazy 8s' which is a fast sketching exercise that challenges people to sketch eight distinct ideas in eight minutes. After then, you can vote three of all.

### Solution Sketch
<p align="center">
<img width="250" alt="스크린샷 2024-02-26 오전 9 36 06" src="https://github.com/GDSC-DGU/2024-SolutionChallenge-InGlo-client/assets/86873281/385b5f12-d8f4-4535-914f-764112b94811">
  &nbsp;&nbsp;
  
<img width="250" alt="스크린샷 2024-02-26 오전 9 36 28" src="https://github.com/GDSC-DGU/2024-SolutionChallenge-InGlo-client/assets/86873281/f9d41e06-344e-4e34-ac81-8df5a15b5a23">
  &nbsp;&nbsp;
</p>

Finally, you can drawing 'Solution Sketch' and write description and content about that. 

### Post
<p align="center">
<img width="240" alt="스크린샷 2024-02-26 오전 9 38 52" src="https://github.com/GDSC-DGU/2024-SolutionChallenge-InGlo-client/assets/86873281/202c6b25-c50a-4083-9627-989c56f5eedc">
<img width="240" alt="스크린샷 2024-02-26 오전 9 38 52" src="https://github.com/GDSC-DGU/2024-SolutionChallenge-InGlo-client/assets/86873281/035aae84-751e-4e1c-9cd5-a39a0e04d7a5">
<img width="240" alt="스크린샷 2024-02-26 오전 9 39 04" src="https://github.com/GDSC-DGU/2024-SolutionChallenge-InGlo-client/assets/86873281/e7cf4747-2235-4567-88c4-17fa011c23d9">
<img width="240" alt="스크린샷 2024-02-26 오전 9 39 04" src="https://github.com/GDSC-DGU/2024-SolutionChallenge-InGlo-client/assets/86873281/e5fe6064-2bcd-40c4-aef7-70768e0438c1">
</p>

 Users can create posts by citing their solution sketches. Post can further express their ideas in solution sketches.


#### Feedback

<p align="center">
<img width="250" alt="스크린샷 2024-02-26 오전 9 37 36" src="https://github.com/GDSC-DGU/2024-SolutionChallenge-InGlo-client/assets/86873281/48b41ddf-5f96-4a40-943a-c5efbec15365">
  &nbsp;&nbsp;
<img width="250" alt="스크린샷 2024-02-26 오전 9 37 55" src="https://github.com/GDSC-DGU/2024-SolutionChallenge-InGlo-client/assets/86873281/714e6bb6-dc8e-4364-98ac-4f95d4b00a4c">
  &nbsp;&nbsp;

 For the generated post, feedback can be exchanged with each other. Users can listen to experts' opinions on the post and can also be experts. In this process, we can form a global partnership.

## Home

<p align="center">
<img width="250" alt="스크린샷 2024-02-26 오전 9 37 36" src="https://github.com/bianbbc87/new/assets/129590633/c211720a-6b32-447e-8c82-4d9b1fda4e2c">
  &nbsp;&nbsp;
<img width="250" alt="스크린샷 2024-02-26 오전 9 37 55" src="https://github.com/bianbbc87/new/assets/129590633/f1c64c6d-85a7-4458-aea4-086c687789fe">
  &nbsp;&nbsp;

</p>
 If you are interested in a country, you can find its location by searching. With the globe, you can check the whole world at a glance.


#### My

#### Global-impact

<p align="center">
<img width="250" src="https://github.com/GDSC-DGU/2024-SolutionChallenge-InGlo-client/assets/86873281/434b3c4d-c4e4-40b2-b137-7b80522b2237">
  &nbsp;&nbsp;

Users can promote "global impact" along with their own activities. It was inspired by github's rank system. The higher the global impact, the more users have tried to contribute to SDGS resolution.

## AI part ( New Feature )
#### Preview
In order to increase interest in SDGs and make them more accessible, we used multi class classification to automatically classify the appropriate SDGs from news data. As shown in the figure, when news data comes in, the text is summarized through a summarization model, and then the text is fed into a classification model to be classified into the appropriate SDGs. 


#### SDGS Classification
<p align="center">
  <img width="250" alt="AI_스크린샷1" src="https://github.com/GDSC-DGU/2024-SolutionChallenge-InGlo-client/assets/86873281/0cbf182c-a75d-433a-873e-3cb792e08ff1">
  &nbsp;&nbsp;
  <img width="250" alt="AI_스크린샷3" src="https://github.com/GDSC-DGU/2024-SolutionChallenge-InGlo-client/assets/86873281/ae8bc5d3-40f4-45ce-9f7e-881950652ad5">
  <img width="250" alt="AI_스크린샷3" src="https://github.com/GDSC-DGU/2024-SolutionChallenge-InGlo-client/assets/86873281/e13a8aba-628d-4325-ab78-74ceaaa74ca2">
</p>

We built a training dataset using news datasets from osdg and sdgs datahub to train the ALBERT model to create a classification model, and used facebook/bart-large-cnn as the limit for the maximum number of tokens in the ALBERT model so that the text can input the classification model after summarization.

## Finish

# Contributors

<table>
  <tr>
    <td align="center"><img src="https://github.com/GDSC-DGU/2024-SolutionChallenge-InGlo-client/assets/86873281/304662f1-2a52-4c75-af3c-402bc2d21416" width="100px;" alt=""/><br /><b>Jung Eun ji</b><br/>🇰🇷</td>
    <td align="center"><img src="https://github.com/GDSC-DGU/2024-SolutionChallenge-InGlo-client/assets/86873281/d08ff443-b3c6-4382-befa-f96f7295c383" width="100px;" alt=""/><br /><b>I Na Gyoung</b><br/>🇰🇷</td>
    <td align="center"><img src="https://github.com/GDSC-DGU/2024-SolutionChallenge-InGlo-client/assets/86873281/d20258b4-a5a2-4007-8a0c-64c18d80fb87" width="100px;" alt=""/><br /><b>Jang Dong Kyeom</b><br/>🇰🇷</td>
    <td align="center"><img src="https://github.com/GDSC-DGU/2024-SolutionChallenge-InGlo-client/assets/86873281/0ac44273-ccd7-4f54-867c-d072cd9da6d1" width="100px;" alt=""/><br /><b>Kim Hyeon Jin</b><br/>🇰🇷</td>
  <tr>
<table>
