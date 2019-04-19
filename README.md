WELCOME TO...
____   ____                     _____
\   \ /   /____   ____  __ __  /     \   ____   ____  __ __
\   Y   // __ \ /    \|  |  \/  \ /  \_/ __ \ /    \|  |  \
 \     /\  ___/|   |  \  |  /    Y    \  ___/|   |  \  |  /
  \___/  \___  >___|  /____/\____|__  /\___  >___|  /____/
             \/     \/              \/     \/     \/
                                         BY: JUSTIN and MINH

Welcome to the "Venue Menu" CLI application! The command line interface to help
you find an event near you!

Before running the application, it is necessary to first create a local database
using a predefined migration. To do this execute the following in the command
line:
```
   rake db:migrate
```
Once complete, you can run the application by executing
```
   ruby bin/run.rb
```
This will start the execution of the program.

The user will fist start by entering the State Code (XX) for the state that they
are currently located in. From there, the databases will populate with
information relevant to the state.

The user can then navigate the through the various menus by selecting the options
that match the  desired search criteria.

A full flow of the program is shown below:
 -Welcome
 -Select a State
 --Attractions
 ---Events
 --Venues
 ---Events
 --Date Search
 ---Today
 ---On a Specific Day
 ---Before a Specific Day

All outcomes result in an Event Summary Table, displaying the refined results
that meet the user's desired search results. Once at this point, the user has
the option to go directly to the the event ticket page, to fully enjoy the
event!

When input is requested, the format needed is indicated. If input is incorrect,
an error message will be displayed, and the user allowed to re-enter information.

We hope you enjoy the application; further, we hope that you make lasting
memories at your next event!
