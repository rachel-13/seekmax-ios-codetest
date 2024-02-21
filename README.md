# seekmax-ios-codetest

### THOUGHT PROCESS

- Written in UIKit but using Combine in-place of the all familiar RxSwift
- Used MVVM-C for separation of concerns but due to time constraints, not all modules may have it
- Defined a Theme file that contains all constants of the application
- Used a SessionManager to keep track of login status and change UIWIndows based on a stream that emits status. AppCoordinator listens to this stream
- Job Detail screen uses a stackview within a scrollview so that screen can be scrollable if content size exceeds screen height
- ProfileViewController only has a Logout button for me to test the flow between landing on Login screen or TabBar screen on app launch with the session manager

### TODO: FEATURES

- ~~Login Screen~~
- ~~Auto-login~~
- ~~Jobs List Screen~~
- ~~Job Details Screen~~
- Apply for job
- ~~Logout Mechanism~~
- Edit Profile Mechanism
- Applied Jobs screen

### TODO: ENGINEERING EXCELLENCE

- Unit tests with Combine's Publisher framework, need to study this as I am used to using RxTest with a TestSchedule to create HotObservables. Need to find an equivalent of RxTest
- Implment a sessionManager to listen to login state in Singleton pattern. Still need to inject this as dependency such that classes that use it can still be unit tested or at least Mocks can be created
- Use Interceptor to inject access token to every request
- Implement Coordinator for all Tab bar screens that are functional
- Find ways to consolidate `Job` object from GraphQL's `GetActiveJobsListQuery.Data.Active.Job` and `GetJobDetailQuery.Data.Job` to a common `JobModel` so that the logic to parse them are the streamlined 
- Better error handling on `LoginService` with other errors such as decoding errors or client network failures


### TODO: BUGS 

- Bug on company name, since there aren't any company names returned from backend, job._id was used as place holder. Industry and location also returns Int, need to figure out a good way to check if these variables are of valid locations. Maybe check for CharacterSet existence
- Bug on login form where button is not enabled for a bried moment after you clear password via backspace. Reproduce via keying in username and password. Then backspace the password textfield all the way. The button is still enabled even though the password textfield is empty. It will only be disabled after the first character of password is keyed in again and then it will re-enable.
