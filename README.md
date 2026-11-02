# CURIOUS

**Stay curious. Keep growing.**

CURIOUS is a Flutter mobile app that helps **students and interns** discover learning programs, read full details, register and share feedback, while **hosts** create and manage programs and see who joined and what learners think. It was built during the Excelerate Mobile Application Development with Flutter internship.

---

## Table of Contents
1. [Project Overview and Purpose](#project-overview-and-purpose)
2. [Features](#features)
3. [Screenshots](#screenshots)
4. [Demo Video](#demo-video)
5. [Navigation Flow](#navigation-flow)
6. [How It Works](#how-it-works)
7. [Design Choices](#design-choices)
8. [Tech Stack](#tech-stack)
9. [Project Structure](#project-structure)
10. [Setup Instructions](#setup-instructions)
11. [Testing](#testing)
12. [Changelog and Contribution Log](#changelog-and-contribution-log)
13. [Roadmap](#roadmap)
14. [Author](#author)

---

## Project Overview and Purpose
Learners often cannot see which programs exist, and hosts find it hard to keep information up to date and to collect feedback. CURIOUS puts both sides in one app:

- **Students and interns** browse programs, read details, register, give feedback and follow their own registrations.
- **Hosts** create, edit and delete programs and review participants, ratings and comments.

| User | What they do |
|---|---|
| **Student / Intern** | Logs in, browses programs, opens details, registers, gives feedback, sees "My programs" and a profile |
| **Host** | Logs in, creates, edits and deletes programs, sees participants, feedback and average ratings |

## Features

**Student side**
- Login with a role selector and validated email and password
- Bottom navigation with four working tabs: Home, Programs, My programs, Profile
- Home screen with a personal welcome, announcements and featured programs
- Program Listing loaded from a mock API, with a loading spinner, an error card with Retry and a local-file fallback
- Program Details with schedule, mentor and eligibility
- Registration form (name, email, year of study) with validation and a submit spinner
- Feedback form (star rating, name, email, comments) with validation and confirmation
- My programs list and a Profile screen with Log out

**Host side**
- Dashboard with live counts
- Create a program form with validation and a date picker
- My programs list with edit and delete (with confirmation and Undo)
- Participants and feedback screen with an overview, a participants list, a feedback list and a filter by program

**General**
- One global theme for consistent colours, buttons, inputs and app bars
- Named routes and a screen flow with parent and child screens
- Data shared between screens so that host changes appear for students immediately

> Registrations, feedback and host changes are kept in memory while the app runs. Login checks the format of the email and password and does not verify real accounts.

## Screenshots

### Core screens
| Login (Student) | Login (Host) | Home |
|:---:|:---:|:---:|
| <img src="docs/screenshots/Login.png" width="200" alt="Login screen for students"> | <img src="docs/screenshots/login_host.png" width="200" alt="Login screen for hosts"> | <img src="docs/screenshots/home.png" width="200" alt="Home screen"> |

| Program Listing | Program Details | Feedback |
|:---:|:---:|:---:|
| <img src="docs/screenshots/programs.png" width="200" alt="Program listing"> | <img src="docs/screenshots/details.png" width="200" alt="Program details"> | <img src="docs/screenshots/feedback.png" width="200" alt="Feedback screen"> |

### Data, loading, errors and forms
| Loading | Error with Retry | Registration errors |
|:---:|:---:|:---:|
| <img src="docs/screenshots/loading.png" width="200" alt="Loading spinner"> | <img src="docs/screenshots/error.png" width="200" alt="Error card with Retry"> | <img src="docs/screenshots/register_errors.png" width="200" alt="Registration validation errors"> |

| Registration success | Feedback form | Login validation |
|:---:|:---:|:---:|
| <img src="docs/screenshots/register_success.png" width="200" alt="Registration success"> | <img src="docs/screenshots/feedback_form.png" width="200" alt="Feedback form validation"> | <img src="docs/screenshots/login_errors.png" width="200" alt="Login validation errors"> |

### Host side
| Host Dashboard |
|:---:|
| <img src="docs/screenshots/host_dashboard.png" width="200" alt="Host dashboard"> |

<!-- After taking the new screenshots, add them here:
| My programs (host) | Create program | Participants and feedback |
|:---:|:---:|:---:|
| <img src="docs/screenshots/host_programs.png" width="200"> | <img src="docs/screenshots/host_create.png" width="200"> | <img src="docs/screenshots/host_participants.png" width="200"> |
-->

## Demo Video
A 2 to 3 minute walkthrough of the login flow, home dashboard, program browsing, form submission and the host features:

**[Watch the demo video](https://drive.google.com/file/d/1MmPJqucHcocVulbd3DALcGYzmf21p7mA/view?usp=sharing)**

## Navigation Flow

```
Student:  Login -> Home -> Program Listing -> Program Details -> Registration / Feedback
          (bottom tabs: Home, Programs, My programs, Profile)
Host:     Login -> Host Dashboard -> Create a program / My programs / Participants and feedback
```

![Screen flow with parent and child screens](docs/screenshots/screen_flow.png)

Home is the **parent** screen. Program Listing is a **child of Home**, Program Details a **child of Listing**, and Registration and Feedback are **children of Details**. The Host Dashboard is the parent of the host screens. Every child screen has a back arrow, so users never get stuck.

## How It Works

**Data loading.** `ProgramService` requests `assets/data/programs.json` through a mock API (the file served by GitHub) using the `http` package, with an 8 second timeout. If the request fails it falls back to the same file bundled in the app, and if that fails too the app shows an error card with a Retry button. `Program.fromJson` turns each JSON item into a `Program` object.

**Shared state.** `ProgramRepository` is a single shared object (a `ChangeNotifier`) that holds the program list. When a host adds, edits or deletes a program it calls `notifyListeners()`, and every screen built with `ListenableBuilder` redraws, so students see the change straight away. Local state, such as the selected role or the star rating, uses `setState`.

**Forms.** Every form uses `Form`, `TextFormField` and validators. Errors appear after the first failed submit, the submit button shows a spinner while submitting, and a confirmation message appears when it succeeds.

**Session.** `UserSession` remembers who logged in, so screens can greet the user, pre-fill forms and show "My programs".

## Design Choices
- **Calm sunrise imagery** in indigo, violet and gold supports the idea of curiosity and fresh starts.
- **One global theme** (`ThemeData`) keeps the interface consistent on every screen.
- **Cards with short descriptions** make lists easy to scan, and full details sit on a separate screen.
- **A role selector** gives each type of user a suitable message and dashboard.
- **Loading, error and empty states** keep the app predictable in every situation.
- **The layout follows the Week 1 wireframes** and the mentor feedback on screen flow.

## Tech Stack
- [Flutter](https://flutter.dev) (stable channel) and [Dart](https://dart.dev), Material 3
- `http` package for API requests
- `ChangeNotifier` and `setState` for state
- Git, GitHub and VS Code

## Project Structure

```
flutter_program_app/
├── lib/
│   ├── main.dart                        # App entry point, theme and named routes
│   ├── data/
│   │   ├── program_repository.dart      # Shared program list (ChangeNotifier)
│   │   ├── registrations_store.dart     # Temporary list of registrations
│   │   ├── feedback_store.dart          # Temporary list of feedback
│   │   └── user_session.dart            # Who is logged in
│   ├── models/
│   │   ├── program.dart                 # Program with fromJson and copyWith
│   │   ├── registration.dart
│   │   └── feedback_entry.dart
│   ├── services/
│   │   └── program_service.dart         # Mock API request with local fallback
│   ├── screens/
│   │   ├── login_screen.dart
│   │   ├── student_shell.dart           # Bottom navigation for students
│   │   ├── home_screen.dart
│   │   ├── program_listing_screen.dart
│   │   ├── program_details_screen.dart
│   │   ├── registration_screen.dart
│   │   ├── feedback_screen.dart
│   │   ├── my_programs_screen.dart
│   │   ├── profile_screen.dart
│   │   ├── host_home_screen.dart
│   │   ├── host_programs_screen.dart
│   │   ├── create_program_screen.dart   # Create and edit form
│   │   └── participants_feedback_screen.dart
│   └── theme/
│       └── app_theme.dart               # Colours and global styles
├── assets/
│   ├── images/                          # Backgrounds and logo
│   └── data/programs.json               # Program data
├── docs/
│   ├── screenshots/                     # Images used in this README
│   └── Week3_Changelog_Akash_Debnath.pdf
├── CHANGELOG.md
├── pubspec.yaml
└── README.md
```

## Setup Instructions

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (stable channel; this project was built with Flutter 3.47.7)
- Google Chrome (or an Android emulator or phone)
- Git

### Run the app
```bash
git clone https://github.com/akashdebnath-alt/flutter_program_app.git
cd flutter_program_app
flutter pub get
flutter run -d chrome
```
The first run takes a minute or two.

### Try it out
1. On the Login screen choose **Student / Intern** or **Host**.
2. Enter any valid email (for example `student@mail.com`) and a password of at least 6 characters (for example `123456`).
3. **As a student:** browse Programs, open Details, Register, give Feedback, then check My programs and Profile.
4. **As a host:** create, edit and delete a program, then open Participants and feedback.
5. Log out from the Profile screen (students) or the app bar (hosts) to switch roles.

> The lists live in memory, so restarting the app resets registrations, feedback and host changes.

### Test switches
In `lib/services/program_service.dart`:
- `simulateError = true` shows the error card with Retry.
- `useLocalFallback = false` disables the offline fallback.

### Check the code
```bash
flutter analyze
```

## Testing
Manual test checklist used before submission:

| Area | Checked |
|---|---|
| Login validation (empty fields, invalid email, short password) | Yes |
| Role selector, tagline and navigation for student and host | Yes |
| Bottom tabs, back arrows, log out | Yes |
| Programs: spinner, API data, offline fallback, error card with Retry | Yes |
| Registration and feedback: every validation rule, spinner, confirmation, cleared fields | Yes |
| Host: create, edit, delete with Undo, participants and feedback filters | Yes |
| `flutter analyze` | No issues |

## Changelog and Contribution Log
See [CHANGELOG.md](CHANGELOG.md) for week by week changes and the commit history. The Week 3 report is in [docs/Week3_Changelog_Akash_Debnath.pdf](docs/Week3_Changelog_Akash_Debnath.pdf).

## Roadmap
- [x] Week 1: setup, proposal and wireframes
- [x] Week 2: UI screens with navigation
- [x] Week 3: data loading, loading and error states, forms with validation
- [x] Week 4: mock API with fallback, shared state, host management, student tabs and profile, named routes
- [ ] Real backend and authentication (for example Firebase)
- [ ] Save registrations and feedback permanently
- [ ] Push notifications for announcements
- [ ] Automated widget tests and an Android build

## Author
**Akash Debnath**
B.Tech CSE, The ICFAI University, Tripura
Flutter Intern, Excelerate
GitHub: [@akashdebnath-alt](https://github.com/akashdebnath-alt)