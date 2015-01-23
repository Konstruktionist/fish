################
# => Git segment
################
set kafka_colors 000000 333333 666666 ffffff ffff00 ff6600 ff0000 ff0033 3300ff 0000ff 00ffff
00ff00

function __kafka_is_git_ahead_or_behind -d 'Check if there are unpulled or unpushed commits'
    command git rev-list --count --left-right 'HEAD...@{upstream}' ^ /dev/null  | sed 's|\s\+|\n|g'
end

function __kafka_git_status -d 'Check git status'
    set -l git_status (command git status --porcelain ^/dev/null | cut -c 1-2)
    set -l added (echo -sn $git_status\n | egrep -c "[ACDMT][ MT]|[ACMT]D")
    set -l deleted (echo -sn $git_status\n | egrep -c "[ ACMRT]D")
    set -l modified (echo -sn $git_status\n | egrep -c ".[MT]")
    set -l renamed (echo -sn $git_status\n | egrep -c "R.")
    set -l unmerged (echo -sn $git_status\n | egrep -c "AA|DD|U.|.U")
    set -l untracked (echo -sn $git_status\n | egrep -c "\?\?")
    echo -n $added\n$deleted\n$modified\n$renamed\n$unmerged\n$untracked
end

function __kafka_is_git_stashed -d 'Check if there are stashed commits'
    command git stash list ^ /dev/null  | wc -l
end

function __kafka_prompt_git_symbols -d 'Displays the git symbols'
    set -l is_repo (command git rev-parse --is-inside-work-tree ^/dev/null)
    set -l git_ahead_behind (__kafka_is_git_ahead_or_behind)
    set -l git_status (__kafka_git_status)
    set -l git_stashed (__kafka_is_git_stashed)

    if begin
        [ $is_repo=true ]
        [ (expr $git_status[1] + $git_status[2] + $git_status[3] + $git_status[4] + $git_status[5] + $git_status[6]) -ne 0 ]
    end
        set_color $kafka_colors[3]
        echo -n ''
        set_color -b $kafka_colors[3]
        if [ $symbols_style = 'symbols' ]
            if [ (count $git_ahead_behind) -eq 2 ]
                if [ $git_ahead_behind[1] -gt 0 ]
                    set_color -o $kafka_colors[5]
                    echo -n ' ↑'
                end
                if [ $git_ahead_behind[2] -gt 0 ]
                    set_color -o $kafka_colors[5]
                    echo -n ' ↓'
                end
            end
            if [ $git_status[1] -gt 0 ]
                set_color -o $kafka_colors[12]
                echo -n ' +'
            end
            if [ $git_status[2] -gt 0 ]
                set_color -o $kafka_colors[7]
                echo -n ' –'
            end
            if [ $git_status[3] -gt 0 ]
                set_color -o $kafka_colors[10]
                echo -n ' ✱'
            end
            if [ $git_status[4] -gt 0 ]
                set_color -o $kafka_colors[8]
                echo -n ' →'
            end
            if [ $git_status[5] -gt 0 ]
                set_color -o $kafka_colors[9]
                echo -n ' ═'
            end
            if [ $git_status[6] -gt 0 ]
                set_color -o $kafka_colors[4]
                echo -n ' ●'
            end
            if [ $git_stashed -gt 0 ]
                set_color -o $kafka_colors[11]
                echo -n ' ✭'
            end
        else
            if [ (count $git_ahead_behind) -eq 2 ]
                if [ $git_ahead_behind[1] -gt 0 ]
                    set_color $kafka_colors[5]
                    echo -n ' '$git_ahead_behind[1]
                end
                if [ $git_ahead_behind[2] -gt 0 ]
                    set_color $kafka_colors[5]
                    echo -n ' '$git_ahead_behind[2]
                end
            end
            if [ $git_status[1] -gt 0 ]
                set_color $kafka_colors[12]
                echo -n ' '$git_status[1]
            end
            if [ $git_status[2] -gt 0 ]
                set_color $kafka_colors[7]
                echo -n ' '$git_status[2]
            end
            if [ $git_status[3] -gt 0 ]
                set_color $kafka_colors[10]
                echo -n ' '$git_status[3]
            end
            if [ $git_status[4] -gt 0 ]
                set_color $kafka_colors[8]
                echo -n ' '$git_status[4]
            end
            if [ $git_status[5] -gt 0 ]
                set_color $kafka_colors[9]
                echo -n ' '$git_status[5]
            end
            if [ $git_status[6] -gt 0 ]
                set_color $kafka_colors[4]
                echo -n ' '$git_status[6]
            end
            if [ $git_stashed -gt 0 ]
                set_color $kafka_colors[11]
                echo -n ' '$git_stashed
            end
        end
        set_color -b $kafka_colors[3] normal
    end
end