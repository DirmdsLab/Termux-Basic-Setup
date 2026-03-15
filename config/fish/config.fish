if status is-interactive

    # Alias And Func Mix By Title

    # Better ls
    alias ls='eza --icons --group-directories-first -1'
    alias ls-M='eza --icons --group-directories-first -1 -s modified'
   
    # Fish Config
    alias Reload='cd; clear; source ~/.config/fish/config.fish'
    alias Reload-Here='clear; source ~/.config/fish/config.fish'
    alias Reload-Here-Keep='source ~/.config/fish/config.fish'
    alias FishConfig='nano ~/.config/fish/config.fish'

    # Tmux 
    function new-attach
        if test (count $argv) -eq 0
            echo "Usage: new-attach <session_name>"
            return 1
        end

        tmux new -A -s $argv[1]
    end

    # setup-ssh-agent <path_to_private_key>
    function setup-ssh-agent
        if test (count $argv) -eq 0
            echo "Usage: setup-ssh-agent <path_to_private_key>"
            return 1
        end

        set key $argv[1]

        # Start ssh-agent and capture its environment variables
        eval (ssh-agent -c)

        # Add the provided key
        ssh-add $key
    end

    # Neofetch
    function neofetch
        set ascii_dir ~/Documents/art-hypr/neofetch

        if test (count $argv) -eq 0
            command neofetch --ascii $ascii_dir/neofetch0
            return
        end

        if test $argv[1] = "default"
            command neofetch
            return
        end

        if string match -rq '^[0-9]+$' -- $argv[1]
            if test $argv[1] -ge 1 -a $argv[1] -le 5
                command neofetch --ascii $ascii_dir/neofetch$argv[1]
            else
                command neofetch --ascii $ascii_dir/neofetch0
            end
            return
        end

        command neofetch $argv
    end

    # Cli
    function launch_cli_art
        set tty (tty)
        set cols (tput cols)
        set lines (tput lines)

        if test "$tty" = "/dev/tty1" -o "$tty" = "/dev/tty2" -o "$tty" = "/dev/tty3"
            ~/Documents/art-hypr/user.sh
        else if test $cols -ge 160; and test $lines -ge 35
            ~/Documents/art-hypr/start-art.sh
        else
            neofetch
            ~/Documents/art-hypr/user.sh
        end
    end

    # yt-download
    alias yt-download=$HOME/File/Script/yt/yt.sh

    # Triger-Add

    # Main

    set -g fish_greeting

    launch_cli_art

    starship init fish | source

end
