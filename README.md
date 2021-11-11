# UniMindelo App (Flutter & Firebase)

![img](https://miro.medium.com/max/1400/1*X5G-FwdUc0obASLfJ5i8Tg.png)

## Info
App feita com Flutter e FireBase, como proposito de servir e ajudar alunos a terem ideias (TCC),aprender ou dar continuidade a este projecto.

## Requisitos para rodar a APP

### Instalar Flutter, caso não o tenha, e seguir os passos na documentação official.
[https://flutter.dev/docs/get-started/install/windows](https://flutter.dev/docs/get-started/install/windows)

#

### Clone o projecto 

```
git clone https://github.com/hitmacreed/uniMindeloApp.git
```

### Inicializar a APP
```
flutter pub get
flutter run lib/main.dart
```
#

### LOGIN
```
email:kevindiasdeda@hotmail.com
pass:1234567890
```
#

## Estrutura  da APP

 ```bash
 |-- assets
    |-- i18n
    |-- images
 |-- lib
    |-- apis
        |-- fireBaseCalls.dart
    |-- utils
        |-- constants
             |-- colors.dart
             |-- errors.dart
             |-- paymentTitle.dart
        |-- services  
             |-- dialogService.dart
             |-- launchUrlService.dart  
             |-- loaderService.dart
             |-- router.dart
             |-- storage.service.dart
    |-- views
        |-- auth
            |-- forgotPassword.dart
            |-- Login.dart
        |-- cineMindelo
            |-- cineMindelo.dart
        |-- classes
            |-- classes.dart
        |-- feed
            |-- feed.dart
        |-- grades
            |-- grades.dart
        |-- home
            |-- home.dart
        |-- payment
            |-- payments.dart
            |-- paymentsList.dart
    |-- widgets   
        |-- appBar.dart
        |-- background.dart
        |-- drawer.dart 
    |-- main.dart         
 ```

 #

## Estrutura FireStore DB (Simples, Consulta App Somente)
```json
    |-- CineMindeloMovies
        {
        "img": "https://firebasestorage.googleapis.com/v0/../jumanji.jpg",
        "description": "Este final de semana.... não fique de fora...",
        "subTitle": "Familia Addams",
        "ytUrl": "https://www.youtube.com/watch?v=rBxcF-r9Ibs",
        "title": "Jumani Next Level",
        "price": 200
        }(... MORE DATA)

    |-- ClassesSchedule
       {
        "end": "2021-09-26T10:00:00Z",
        "classId": "sFUthBc3WpxBDaeNSsxS",
        "teacher": "Wario",
        "description": "Engenharia Informática e Sistemas Computacionais",
        "start": "2021-09-26T08:00:00Z"
        }(... MORE DATA)

    |-- Courses 
        {
        "id": "sFUthBc3WpxBDaeNSsxS",
        "title": "Engenharia Informática"
        } (... MORE DATA)    

    |-- Feed 
        {
        "img": "https://firebasestorage.googleapis.com/../Screenshot_1.png",
        "title": "💥CANDIDATURAS ABERTAS💥 🔥Ano Lectivo 2021/2022🔥",
        "description": "📍Conheça a nossa oferta formativa em uni-mindelo.edu.cv/pt",
        "url": "https://www.facebook.com/UniversidadeDoMindelo/videos/131399275695610",
        "id": 3,
        "subTitle": "🆕🚨Faça a sua Candidatura online em uni-mindelo.edu.cv/pt/ensino/candidaturas 🆕"
        }(... MORE DATA)  

    |-- UserBribes  
        {
        "userId": "9mLFDcY9LNW1Fw74bDmGhI5nJY33",
        "amount": "12000",
        "isPaid": false,
        "duePayment": "2022-03-31T23:00:00Z"
        }(... MORE DATA)   

    |-- Users  
        {
        "phoneNumber": "966303XXX",
        "userName": "Kevin",
        "course": "Engenharia Informática",
        "userSurname": "Dias",
        "isPaid": true,
        "address": "rua cidade de XXX n1 2A XXX",
        "semester": "3",
        "classId": "sFUthBc3WpxBDaeNSsxS",
        "grades": [
            {
            "grade": {
                "stringValue": "17"
            },
            "title": {
                "stringValue": "Marketing Digital"
            },
            "teacherEmail": {
                "stringValue": "horafithelp@gmail.com"
            },
            "teacher": {
                "stringValue": "Luna Dias"
            },
            "semester": {
                "stringValue": "3"
            }
            },
            {
            "teacherEmail": {
                "stringValue": "horafithelp@gmail.com"
            },
            "semester": {
                "stringValue": "3"
            },
            "grade": {
                "stringValue": "14.4"
            },
            "title": {
                "stringValue": "Engenharia do Conhecimento"
            },
            "teacher": {
                "stringValue": "Wario Luigi"
            }
            },
            {
            "teacherEmail": {
                "stringValue": "horafithelp@gmail.com"
            },
            "semester": {
                "stringValue": "3"
            },
            "teacher": {
                "stringValue": "Morty Sanchez"
            },
            "title": {
                "stringValue": "Programação Concorrente"
            },
            "grade": {
                "stringValue": "15"
            }
            },
            {
            "grade": {
                "stringValue": "12.9"
            },
            "teacher": {
                "stringValue": "Rick Sanchez"
            },
            "semester": {
                "stringValue": "3"
            },
            "title": {
                "stringValue": "Redes e Internetworking"
            },
            "teacherEmail": {
                "stringValue": "horafithelp@gmail.com"
            }
            },
            {
            "semester": {
                "stringValue": "3"
            },
            "teacherEmail": {
                "stringValue": "horafithelp@gmail.com"
            },
            "grade": {
                "stringValue": "9"
            },
            "teacher": {
                "stringValue": "Eric Cartman"
            },
            "title": {
                "stringValue": "Sistemas de Bases de Dados"
            }
            }
        ],
        "birthDay": "1993-10-04T11:00:00Z",
        "id": "9mLFDcY9LNW1Fw74bDmGhI5nJY33",
        "id_student": "2399134576",
        "email": "kevindiasdeda@hotmail.com",
        "age": 27
        }       
```


## Preview da App
\
![Alt text](/art/login.gif)  ![Alt text](/art/recuperar_pw.gif) 

![Alt text](/art/home.gif)  ![Alt text](/art/feeds.gif) 

![Alt text](/art/aulas.gif)  ![Alt text](/art/propinas.gif)

![Alt text](/art/cineMindelo.gif) ![ios](/art/iosPreview.png)

 ```bash   _
       .__(.)< (Sou um gato continua a descer... MEOW!!!)
        \___)   
 ~~~~~~~~~~~~~~~~~~
```


## Todos
#
- [ ] Improve Layout
- [ ] Improve FireStore DB CRUD App && BackOffice (Desktop App)
- [ ] Desktop App (Windows & Mac OS) - Em Desenvolvimento (preview em baixo).

\
![Alt text](/art/desktopApp1.png)
\
\
![Alt text](/art/desktopApp2.png)


#
## License

```
MIT License

Copyright (c) 2021 Kevin Dias

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```






