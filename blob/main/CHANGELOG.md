Changelog

All notable changes to CURIOUS, by internship week. Newest first.

Week 4: Final version
Added
Mock API loading with the http package (JSON served by GitHub) with an 8 second timeout and a local-file fallback
Shared ProgramRepository (ChangeNotifier) so that host changes appear for students immediately
Host: create program form with a date picker, edit mode and delete with confirmation and Undo
Host: "My programs" list with registration counts
Host: "Participants and feedback" screen with an overview, a participants list, a feedback list and a filter by program
Student: working bottom navigation shell, "My programs" and Profile screens, Log out
UserSession to remember who is logged in and to pre-fill forms
Named routes (/login, /student, /host)
Changed
Home screen shows featured programs from the shared list and a personal welcome
Login uses controllers and shows errors only after the first failed submit
Registration and feedback forms no longer show red errors after a successful submit
Dashboard background image file name corrected so the picture loads
Fixed
Misplaced model file that caused "Target of URI doesn't exist" errors
Login screenshot file name case so the README picture shows on GitHub
Week 3: Data, state and forms
Added
assets/data/programs.json and Program.fromJson
ProgramService and a FutureBuilder on the Program Listing with a loading spinner, an error card with Retry and an empty state
Registration form (name, email, year of study dropdown) with validation, a submit spinner, a confirmation and cleared fields
Feedback form (star rating, name, email, comments) with validation
Login validation (valid email, password with at least 6 characters)
Week 3 report in docs/Week3_Changelog_Akash_Debnath.pdf
Week 2: UI prototype
Added
Login, Home, Program Listing, Program Details and Feedback screens
Student and Host role selector with role-specific tagline and host dashboard
Global theme (AppColors, AppTheme), sunrise backgrounds and the CURIOUS logo
Navigation between screens and a screen flow diagram with parent and child screens
README with screenshots and a demo video
Week 1: Planning and setup
Added
Flutter environment set up and project created
App proposal document and four low-fidelity wireframes
GitHub repository, initial commit and README
Commit history

Run git log --oneline to see every commit with its message, or open the Commits page of the repository on GitHub.