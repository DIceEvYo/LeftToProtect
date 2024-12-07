# LeftToProtect 
Fall 2024 Game Jam Project


### [Commands To Know] ###
Before executing command locate the terminal to your desired workspace:
- git clone link (Creates a clone of the contents from github to your machine)

Now CD into the project folder:
- cd LeftToProtect

Congrats, now you can use the commands! 

### [When you are ready to make your changes] ###
- git status (To confirm that your changes have been tracked)
- git checkout -b name_of_your_branch (To create a new branch for your new changes)
- git add filename or git add . (To add your local changes to the branch)
- git commit -m "Your message" (To save your added changes to branch and describe the details of your save. Make your messages brief but to the point, your commits will display on github, so its helpful to other developers if your comments have thought put into them)
- git push origin name_of_your_branch (To push your local branch changes to the online github. NEVER USE MAIN. It's bad practice, and if there's ANY issues with your changes (for example you forgot to update your code, buggy, etc) it can be a headache to reverse.)

Congrats, now you can make the pull request!

### [Making the pull request] ###
![image](https://github.com/user-attachments/assets/6028e928-5eaf-473c-ba5e-16969aba6bbb)
![image](https://github.com/user-attachments/assets/da3207b9-3c00-45d9-9166-d319e3beba7a)

Go to the pull request tab, select create a pull request.
Select your branch as the compare, and base to test_main

![image](https://github.com/user-attachments/assets/41b108d2-1067-433c-ada6-1bc46eaa6c83)

Add a description to your pull request (let the other developers know about the changes you've made)

![image](https://github.com/user-attachments/assets/420ab821-d670-4c84-9d11-4a04c1e541ad)

Good Practice: Add reviewers. On the right side of the pull request page there's a reviewers section. It should notify whoever is selected that there's a pull request they need to review. Usually in internships/jobs, your manager may have you select them or designated reviewers for this section.
Finally when you think all the details are good enough, press the make pull request button.

![image](https://github.com/user-attachments/assets/c7af94dd-0bcf-40df-8ce6-566d176c256b)

Warning: Right after the pull request is made, it may give you the option to merge the pull request. In bigger companies, you may not have access to this option. DO NOT HIT THE MERGE BUTTON. Make sure to notify or let people review the changes first, especially if the code is planned to merge into main. It will prevent more issues.

Congrats you're done! When you want to work on a new feature, to prevent running into potential merge/code conflicts, please be sure to have the latest updated code. 

### [To update your code run] ###
git pull origin main (This pulls the latest changes from the main branch)
