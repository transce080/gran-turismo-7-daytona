# Gran Turismo 7 Daytona Autopilot Script

## Summary

This script is the digital equivalent of using a rubber-band on your controller.  It will hold down the gas and steer slightly right during the race and will navigate the menu to restart in between races.

## Reasons For

- It's a clear text bash script.
- It uses only common, open-source linux tools: chiaki, wmctrl, xdotool.
- It can make your grind time more productive and more hands-off.
- It yields 85,200 credits at a time in ~10 minute increments, making it easier to stop without losing progress.
- It is very stable.  It has been recorded to successfully loop over 50 times in a single run before the test was stopped.
- There is no need to adjust the AI racing difficulty.
- You might feel that using a sophisticated autonomous driving script is too close to cheating, but that using a digital rubber-band is okay.

## Reasons Against

- It requires a Debian-based linux OS or VM.
- By design, it's very basic compared to other driving scripts; it can only handle oval tracks.
- You can make more money using input-recorded driving scripts to complete higher-reward races.
- You might feel that even this much automation is a form of cheating.

## Preface

- The strategy defined below is taken from [RAKIN8R](https://www.reddit.com/user/RAKIN8R/)'s guide [Daytona AFK Grind Setup](https://www.reddit.com/r/GranTurismo7/comments/1817sqm/almost_15m_per_hour_daytona_afk_grind_setup/) on reddit.  Please refer to [this post](https://www.reddit.com/r/GranTurismo7/comments/1817sqm/almost_15m_per_hour_daytona_afk_grind_setup/) and [this post](https://www.reddit.com/r/GranTurismo7/comments/180kegp/new_daytona_afk_grind_setup/) for questions and clarifications.
  - He recommends an engine-swapped Honda Beat but the script can work for any car.
- To maximize rewards, create the race while using a low-PP tune and then switch to a high-PP tune once the race has been created.
  - Race rewards are determined by the difference between your PP and the opponents' PP but are not recalculated when you change car tunes inside the race-start menu.

## Setup

- Install Chiaki
  - Install from your favorite software manager or from the terminal with `sudo apt install chiaki` or `sudo snap install chiaki`.
  - You **must pair Chiaki with your Playstation** before using the script.
  - Pairing is not hard per-se but it's a multi-step process that's worth using a guide for the first time.
- Download the script.  Give it execution permission if needed.
  - The first time you run, it will prompt you to install the necessary software if it doesn't exist.
- Create a custom race at Daytona (make sure to save your settings)
  - Track: Daytona Tri-Oval
  - Race Type: Lap
  - Number of Laps: 10
  - Number of Cars: 20
  - Starting Grid: 20
  - Staring Type, Interval: Rolling Start, 50ft
  - Mechanical Damage: None
  - Tire/Fuel: Off
  - Grip Reduction: Low
  - Weather:  Preset, S01, Midnight
  - Rivals: Select from garage
    - Set all opponents to the same VGT car, something with extremely high PP but cripple the VGT car's top speed beforehand with a transmission modification
  - Rivals Difficulty: Professional Level
  - Penalties:  All Off
  - Correct Vehicle Course After Wall Collision: Off
- Set up the Honda Beat as described in the guide above with one exception
  - Because the script's steering creates friction with the wall, it needs a more aggressive gearing than the guide recommends
  - Set transmission top speed: 350 kph

## Configuration

- You will need to set the `RACE_TIME` variable according to your vehicle speed.
  - If you're not sure, start with the time it takes to rubber-band the race.
- You may also need to tweak the reward amount by modifying the `RACE_PRIZE` variable (note that this is the amount **per lap**).

## Directions

- Start your Playstation and start Gran Turismo 7.
- Start Chiaki and connect to your Playstation.
- With your low PP tune selected, start a custom race at Daytona and load the custom race settings.
- Enter the race itself.  Switch to your high PP tune.
- With the arrow on the Start button, start the script.
- When you're done, exit the script by pressing `CTRL+C`.

## For best results

- At first, you should monitor the script and tweak the `RACE_TIME` variable until the "Race Ending" message is shown the moment you cross the finish line.
  - Use a stopwatch to time between when the script says "Race ending" and when you cross the finish line (or vice versa) to know how much to adjust `RACE_TIME`.
- You will also need to increase `RACE_TIME` periodically as your engine condition decreases over time, but keep your "peak" time written down because that's what you will set it back to once you do an engine overhaul.

## Thanks

- If you find this script useful, feel free to buy me [coffee](https://www.buymeacoffee.com/transce).
