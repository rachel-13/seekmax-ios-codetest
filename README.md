# seekmax-ios-codetest

### GENERAL THOUGHT PROCESS

- Written in UIKit but using Combine in-place of the all familiar RxSwift
- Used MVVM-C for separation of concerns but due to time constraints, not all modules may have it
- Defined a Theme file that contains all constants of the application
- Used a SessionManager to keep track of login status and change UIWIndows based on a stream that emits status. AppCoordinator listens to this stream and decides on if it should route to Login or TabBar
- Dependencies are injected into ViewModels/Coordinators and depend on ProtocolTypes to make it easier to mock or write unit tests. Best effort to follow SOLID principles for Login, JobList and JobDetail module


#### Login module
- Makes the API call and simple mechanism to save token into keychain and update SessionManager on login status
- Only propagates 2 errors as of now i.e. when username/password is mismatched, and when there are network failures

#### Job module
- Lazyloading on job list screen by the time we reach second last item in the tableview
- For `JobListViewModel`, a tradeoff was made between using `Published<Bool>.Publisher` or `Published<[JobListCellViewModel]>.Publisher` to inform the ViewController of the changes in datasource but since the ViewController is not supposed to know about models (the second publisher propagates the entire array of CellViewModels to View), it should tap into the primitive `[JobListCellViewModel]` variable instead. Thus, all we need is a just a Boolean publisher and the first one was chosen.
- Job Detail screen uses a stackview within a scrollview so that screen can be scrollable if content size exceeds screen height
- JobService for both JobList and JobDetail module are injected with different types to disallow one from tapping into the stream of the other

#### Profile module
- ProfileViewController only has a Logout button for me to test the flow between landing on Login screen or TabBar screen on app launch with the session manager so it is not a functional module with proper architecture
- On tapping the Logout button, updates SessionManager


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

- Unit tests with Combine's Publisher framework, need to study this more extensivelt as there are no TestSchedulers like what RxTest used to have to minimize waiting time
- ~~Implment a sessionManager to listen to login state in Singleton pattern. Still need to inject this as dependency such that classes that use it can still be unit tested or at least Mocks can be created~~
- Use Interceptor to inject access token to every request
- Implement Coordinator for all Tab bar screens that are functional
- Find ways to consolidate `Job` object from GraphQL's `GetActiveJobsListQuery.Data.Active.Job` and `GetJobDetailQuery.Data.Job` to a common `JobModel` so that the logic to parse them are the streamlined 
- Better error handling on `LoginService` with other errors such as decoding errors or client network failures
- Currently the codebase using Combine is a mixture of PassthrougSubject and Publisher. Need to streamline to right consistency.


### TODO: BUGS 

- **Bug on company name**, since there aren't any company names returned from backend, job._id was used as place holder. Industry and location also returns Int, need to figure out a good way to check if these variables are of valid locations. Maybe check for CharacterSet existence
- **Bug on login form** where button is not enabled for a brief moment after we clear password via backspace. Reproduction steps: Key in username and password. Then backspace the password textfield all the way. The button is still enabled even though the password textfield is empty. It will only be disabled after the first character of password is keyed in again and then it will re-enable.
- **Bug on job detail** where the Apply button text will turn dark on touchDown but after a few rapid clicks.
