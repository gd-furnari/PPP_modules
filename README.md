# PPP_modules
Repository containing specific ftls for PPP reports. To be used in combination with IUCLID common modules.

# Contribute
If it is the first time you are contributing to the project you need to first clone the repository. From the menu at the top right corner of the repository, 
click on "clone" and copy the HTTPS address. Then in the command line do: ```git clone devops_https_address```

Then, in order to contribute to the project, please follow these instructions:

It is always a good idea to check the status of the repository: ```git status```

1. In your local git repo, pull the contents from DevOps in order to work on the latest version: ```git pull origin```

2. Create a new branch (-b) or move to a branch different from main: ```git checkout -b my_working_branch```

3. Once you finish working, stage and commit your changes including a human-readable message for the commit: ```git add my_changed_file``` and  ```git commit -m "my commit message"```, or both steps at once ```git commit -a -m "my commit message"```

4. Push your changes to DevOps (use the option --set-upstream if the branch does NOT exist remotely): ```git push --set-upstream origin my_working_branch```

5. Open a pull request in DevOps. The Reviewer may comment on your commits, and request or make, changes.  so that the administrator reviews and merges changes to main. When the pull request is approved, the changes will be merged to the main branch

