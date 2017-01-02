# A short description of the functions

### Functions with dependencies on non-standard installed tools*
 _\* on MacOS (OS X)_

* **chosts.fish** _depends on [**dateutils**][fresse] & [**wget**][wget]_.
* **img_size.fish** _depends on [**imagemagick**][imagemagick]_.
* **mdb.fish** _depends on [**tag**][github]_.
* **testmovies.fish** _depends on [**mediainfo**][mediaarea]_.

> These tools were installed with [brew][brew].

* **fixdate.fish** _depends on **SetFile**_  
    SetFile is a macOS (OS X) tool installed by Xcode.  
    From its manpage :  
    _Tools supporting Carbon development, including /usr/bin/SetFile, were deprecated with Xcode 6._  
    Its documentation says it is deprecated, but for now it works. (With Xcode 8 it still gets installed).  
* **xpstatus.fish** _depends on **GetFileInfo**_  
Like _SetFile_ also a deprecated tool installed by Xcode.  



---

#### In alphabetical order

* **ag**  
Change the colors of ag (the silver searcher) output.
I don't like the yellow boxes that show up in the default settings.
Changed to green underlined matches, light yellow pathnames & light blue line numbers

* **apply_settings**  
Set up fish universal variables. At the moment all color related.  
I'm using a customised SpaceGray theme. The standard colors fish comes with don't work very well with this theme. When I set up a Mac this function makes it easy to apply the colors that I found to be working best for me. It has taken an inordinate amount of time to get to these, so it's important to preserve them even if this function is never called again during the computers lifetime. 

* **brdeps**  
Print a list of `brew` installed tools and their dependencies.  
Takes optional arguments, if there are none it will display a list of all installed tools.  
_Output_:  
      `tool_name depends on: some_other_tool(s)`

* **brused**  
Print a list of `brew` installed tools and which other tools use this.  
Takes optional arguments, if there are none it will display a list of all installed tools.  
_Output_:  
       `tool_name used by: some_other_tool(s)`

* **bup**  
Three consecutive commands to keep homebrew up to date and lean.  
`brew update`, `brew upgrade` and finally `brew cleanup`.  
This will update _everything_ that is installed via a brew command for which a newer version is available.

* **cdl**  
Change to a directory and list its contents with a long listing.

* **chosts**  
Compare the local date with the date on the net for my hosts file and see if it's behind.

* **cleands**  
Recursively delete ".DS_Store" files

* **cleanLaunchServices**  
Clean up LaunchServices to remove duplicates in the "_Open With_" menu.

* **cpuhogs**  
Find what's hogging the CPU. Kinda like a Top 10 list.

* **decrypt**  
Decrypt a file.

* **domaininfo**  
Get information for a FQDN (fully qualified domain name). 
It's a wrapper around `dig`, [ipinfo.io][ipinfo] & a `whois` query.  
 I used this to block Facebook, after reading [this][perpetual-beta] blogpost.
Usefull to block tracking servers or other pests on the internet.

* **down4me**  
Checks whether a website is down just for you, or everybody.

* **emptytrash**  
Empty the Trash on all mounted volumes and the main HDD.  
Also, clear Apple’s System Logs (asl) to improve shell startup speed.

* **encrypt**  
Encrypt a file.

* **extract**  
Extract the given archive into a folder.

* **fish\__some\_function_**
functions for the shell's own use.

   * **fish_command_timer**  
   Time stamp & command execution time at the right hand side of the terminal.

   * **fish_greeting**  
   Display a short message at login.

   * **fish_prompt**  
   Prompt line with git info.

   * **fish\_user\_key\_bindings**  
   Sources _fzf\_key\_bindings_  
   Dumped here by brew install fzf.

   * **fish**\__something\_else\_then\_above_  
   Usually a small helper function that is called from other functions.  
   ***Not*** to be used on its own! They are most likely to be destructive in nature.

* **fixdate**  
Extract dates from filenames and put those in the date created & modified metadata.

* **free**  
Emulates the `free` function from Linux.  
Shows free & used memory in human readable format.

* **fzf\_key\_bindings**  
As the name implies key bindings for [fzf][github 2] (fuzzy finder).
It's a symbolic link to keybindings for fzf which lives in `/usr/local/opt/fzf/shell/key-bindings.fish`.

* **getnet**  
Get network information.  
I don't use this anymore because newer Mac's may not have a physical ethernet port.  
Replacement is `netinfo`.

* **hosts**  
Open the hosts file in my favorite editor.

* **img_size**  
Find out the dimensions of an image.

* **jump**  
Jump to previously set bookmark for a directory.

* **lmas**  
List all applications that were downloaded from the Mac App Store.

* **mans**  
Search for something in a man page.  
`mans manpage searchterm`  
Displays paginated result with colored search terms and seven lines surrounding each hit.

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

* **prompt\_git\_status**  
Helper function for fish_prompt.

* **restore\_original\_fish_colors**  
Like it says on the tin.

* **source_script**  
Source sh/csh file. Seems useful, but I can't remember if I ever used it.

* **sudo**  
Run command using sudo (use !! for last command).

* **testmovies**  
A script to extract the height of movie files in a directory & if it's over 720 put their names in a file for further processing with Don Melton's [video transcoding tools][github 3].

* **totrash**  
Move a specified file to the Trash.

* **try_func**  
A dummy function to try out a new script. This gives me time to think of a good name (_it doesn't always works out_).

* **undopush**  
Undo a `git push`

* **unmark**  
Remove a bookmark.

* **updhosts**  
Update my /private/etc/hosts file from [four][someonewhocares] [different][mvps] [online][yoyo] [sources][SB] and append my personal blocklist to it.  
Then flush the DNS cache to make the changes take effect.  
All to block ads & malware sites, trackers and other annoyances like facebook & co.

* **vimrc**  
Open the .vimrc file.

* **weer**  
The weather forecast for a city. Type in `city,country` (case insensitive) as arguments.

* **xpstatus**  
Shows the version of Apple's XProtect tool and the last time it was updated.

---

I've tried to attribute the people from whom I stole some code.  
If you feel that I have missed something, open an Issue here.
Also if you find bugs, ditto.

[fresse]: http://www.fresse.org/dateutils
[github]: https://github.com/jdberry/tag
[github 2]: https://github.com/junegunn/fzf
[github 3]: https://github.com/donmelton/video_transcoding
[imagemagick]: https://imagemagick.org
[mediaarea]: http://mediaarea.net
[perpetual-beta]: https://www.perpetual-beta.org/weblog/blocking-facebook-on-os-x.html
[someonewhocares]: http://someonewhocares.org/hosts/zero/hosts
[mvps]: http://winhelp2002.mvps.org/hosts.txt
[yoyo]: https://pgl.yoyo.org/as/serverlist.php?hostformat=hosts&showintro=0&startdate%5Bday%5D=&startdate%5Bmonth%5D=&startdate%5Byear%5D=&mimetype=plaintext
[SB]: https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/gambling-social/hosts
[brew]: http://brew.sh
[wget]: https://www.gnu.org/software/wget/
[ipinfo]: http://ipinfo.io
