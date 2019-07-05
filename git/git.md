Initialise a local git repo
    git init

Clone a Github  repop
    git clone <url>

Add a remote named <name> for the repository at <url>
    git remote add origin <github https url>

Show all local changes
    git status

Stage all the changes
    git add -A

Commit the change to branch
    git commit -m "commit message"

Push the local repo to the remote repo
    git push origin master

Show current branch
    git branch

List all remote branches
    git branch -a 

Delete local branch
    git branch -d <branch_name>

Delete remote branch
    git push --delete <remote_name> <branch_name>

Remove already deleted remote branches
    git remote prune origin

Switch to named branch
    git checkout <name_of_branch>

Create a new branch
    git checkout -b <name_of_new_branch>

Refresh local repo from remote
    git fetch

Refresh remote branches
    git fetch -p

Merge the named branch into your local code
    git merge <name_of_branch>

Pull the remote changes into local
    git pull origin

See last commit
    git log --name-status HEAD^..HEAD

Stash changes to reapply later
    git stash

View changes stashed
    git stash list

Apply stashed changes  
    git stash apply

Remove stored stashes
    git stash drop

Undo the last commit
    git reset --soft HEAD~1

Compare two repos

git remote add -f b path/to/repo_b.git
git remote update
git diff master remotes/b/master
git remote rm b