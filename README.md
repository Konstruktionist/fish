# A short description of the functions

### Functions with dependencies on non-standard installed tools

* chosts.fish _depends on [**dateutils**](http://www.fresse.org/dateutils)_
* img_size.fish _depends on [**imagemagick**](https://imagemagick.org)_.
* fixdate.fish _depends on **SetFile**_  
    SetFile is a macOS (OS X) tool installed by Xcode.  
    From its manpage :  
    _Tools supporting Carbon development, including /usr/bin/SetFile, were deprecated with Xcode 6._  
    Its documentation says it is deprecated, but for now it works. (With Xcode 8 it still gets installed).  
* mdb.fish _depends on [**tag**](https://github.com/jdberry/tag)_.
* testmovies.fish _depends on [**mediainfo**](http://mediaarea.net)_.
* xpstatus.fish _depends on **GetFileInfo**_  
Like _SetFile_ also a deprecated tool installed by Xcode.

---

## In alphabetical order

* **apply_settings**  
Set up fish universal variables. At the moment all color related
* **bup**  
Three consecutive commands to keep homebrew up to date and lean.  
`brew update`, `brew upgrade` and finally `brew cleanup`.  
This will update *everything* that is installed via a brew command for which a newer version is availlable.
* **cdl**  
Change to a directory and list its contents with a long listing.
* **chosts**  
Compare the local date with the date on the net for my hosts file and see if it's behind.
* **cleands**  
Recursively delete ".DS_Store" files
* **cleanLaunchServices**  
Clean up LaunchServices to remove duplicates in the "*Open With*" menu.
* **cpuhogs**  
Find what's hogging the CPU. A Top 10 list.
* **decrypt**  
Decrypt a file.
* **down4me**  
Checks whether a website is down just for you, or everybody.
* **emptytrash**  
Empty the Trash on all mounted volumes and the main HDD.  
Also, clear Apple’s System Logs (asl) to improve shell startup speed.
* **encrypt**  
Encrypt a file.
* **extract**  
Extract the given archive into a folder.
* **fish_greeting**  
Display a short message at login.
* **fish_prompt**  
Prompt line with git info.
* **fish_right_prompt**  
Time stamp at the right hand side of the terminal.
* **fish_user_key_bindings**  
Symbolic link to *fzf_key_bindings* which lives in `/usr/local/Cellar/fzf/version_number/shell`  
Dumped here by `brew install fzf`.
* **fixdate**  
Extract dates from filenames and put those in the date created & modified metadata.
* **fzf_key_bindings**  
As the name implies key bindings for [fzf](https://github.com/junegunn/fzf) (fuzzy finder).
* **getnet**  
Get network information.  
I don't use this anymore because newer Mac's may not have a physical ethernet port.
* **glog**  
A nice git log display.
* **hosts**  
Open the hosts file in my favorite editor.
* **ii**  
Display useful host related informaton.
* **img_size**  
Find out the dimensions of an image.
* **ip**  
Show IP addresses & DNS servers. 
* **ipinfo**  
Get IP information for a FQDN (fully qualified domain name). I used this to block Facebook.  
To find out more  look at [this](https://www.perpetual-beta.org/weblog/blocking-facebook-on-os-x.html) blogpost.
* **jump**  
Jump to previously set bookmark for a directory.
* **lmas**  
List all applications that were downloaded from the Mac App Store.
* **mans**  
Search for something in a man page.  
Displays paginated result with colored search terms and three lines surrounding each hit.
* **mark**  
Set a bookmark for the current directory or a named directory.
* **marks**  
Show a list of the defined bookmarks.
* **mdb**  
A script to create a simple plaintext movie database.
* **netinfo**  
Get network information.  
The  successor of getnet.fish.  
Works on Mac's without a physical ethernet port. See in the comments.
* **nvimrc**  
Open the init.vim file.
* **prompt_git_status**  
Helper function for fish_prompt.
* **restore_original_fish_colors**  
Like it says on the tin.
* **source_script**  
Source sh/csh file. Seems usefull, but I can't remember if I ever used it.
* **sudo**  
Run command using sudo (use !! for last command).
* **testmovies**  
A script to extract the height of movie files in a directory & if it's over 720 put their names in a file for further processing with Don Melton's transcode-video tools.
* **totrash**  
Move a specified file to the Trash.
* **try_func**  
A dummy function to try out a new script. This gives me time to think of a good name (_it doesn't allways works out_).
* **undopush**  
Undo a `git push`
* **unmark**  
Remove a bookmark.
* **updhosts**  
Update my /private/etc/hosts file from [someonewhocares.org](http://someonewhocares.org/hosts/zero/hosts) and append my personal blocklist to it.
* **vimrc**  
Open the .vimrc file.
* **weer**  
The weather forecast for a city. Type in `city,country` (case insensitive).
* **xpstatus**  
Shows the version of Apple's XProtect tool and the last time it was updated.

---
