# seekmax-ios-codetest

### THOUGHT PROCESS

- Written in UIKit but using Combine in-place of the all familiar RxSwift
- Used MVVM-C for separation of concerns
- Defined a Theme file that contains all settings of Colors and Fonts and Margins

### TODO: FEATURES

- ~~Login Screen~~
- ~~Auto-login~~
- Jobs List Screen
- Job Details Screen
- Apply for job
- Logout Mechanism
- Edit Profile Mechanism
- Applied Jobs screen

### TODO: BUGS & ENGINEERING EXCELLENCE

- Unit tests with Combine's Publisher framework
- Implment a sessionManager to listen to login state in Singleton form
- Use Interceptor to inject access token to every request
- Bug on login form where button is not enabled for a bried moment after you clear password via backspace. Reproduce via keying in username and password. Then backspace the password textfield all the way. The button is still enabled even though the password textfield is empty. It will only be disabled after the first character of password is keyed in again and then it will re-enable.
