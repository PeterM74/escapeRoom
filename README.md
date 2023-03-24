# escapeRoom
![](https://img.shields.io/badge/version-1.0.0-green)

**A customisable escape room built with an R Shiny backend**

>Welcome to the secret laboratory of the evil scientist Dr Malum! They have left a disbursement vessel somewhere in [city] that will stink up the streets for weeks. You, our elite investigative taskforce, are our only hope to foil their plan. You must navigate their laboratory filled with puzzles and challenges that will test your skills and knowledge to the breaking point. You must solve each puzzle to unlock the necessary clues to disarm the vessel. 

**No good? How about:**

>Welcome to the secret lair of computer scientist Dr Dren! They have developed an electromagnetic pulse (EMP) device that can take out [your company's/favourite service] entire server stack in one strike, and it's up to you to stop them before they wreak havoc...

`escapeRoom` is a fully customisable, open-source escape room experience built on an R Shiny app. You may keep the default settings and puzzles for a quick set-up or go all out customising the experience to your team's skillset with a relatable theme. While it is a Shiny app and the example puzzles included are coding challenges, this can be run by R novices and may involve any type of puzzles/challenges. 

`escapeRoom` is a great team building activity where the group must work together in a non-competitive environment and help each other find the solutions to the puzzles. The best part: there is no cost! The activity is centred around a custom computer terminal that the evil genius has developed which is the only way to interact with the vessel/device to disarm it. Someone (you) will need to act as the evil genius to start the terminal, select the puzzles and guide the activity forward if necessary. Don't worry, it is just as fun (if not more so) to play this part. 

Below is a screenshot of the default terminal's appearance after some commands have been entered:

![Screenshot of escapeRoom terminal in progress](docs/wiki/DefaultScreenshotExample.png)

## Getting started
Ensure you have [R](https://www.r-project.org/) installed (any operating system) and install the following packages:

```
install.packages(c("tidyverse", "shiny", "shinyjs"))
```

Your local software dependencies are now all set! To learn more about how to set up the escape room and how it functions, please read the [wiki](https://github.com/PeterM74/escapeRoom/wiki).

## Contributing and getting help
If you encounter a bug or crash, please file an [issue](https://github.com/PeterM74/escapeRoom/issues) with a reproducible example if possible. 

## Feedback
I released this activity so that others may also enjoy running the activity. I would love to hear your feedback (positive or negative) to know that other teams have tried it out and hopefully found it enjoyable - but criticism is also gratefully accepted. To leave feedback, please file an [issue](https://github.com/PeterM74/escapeRoom/issues) with your feedback. 