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

## Preview da App
\
![Alt text](/art/login.gif) \ ![Alt text](/art/recuperar_pw.gif) 

![Alt text](/art/home.gif) \ ![Alt text](/art/feed.gif) 

![Alt text](/art/aulas.gif) \ ![Alt text](/art/propinas.gif)

![Alt text](/art/cineMindelo.gif)

 ```bash   _
       .__(.)< (Sou um gato continua a descer... MEOW!!!)
        \___)   
 ~~~~~~~~~~~~~~~~~~
```

#
## TODO : [ ] Desktop App (Windows & Mac OS) - Em Desenvolvimento.
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






