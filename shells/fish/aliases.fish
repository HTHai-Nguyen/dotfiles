# Detect OS
if test -f /etc/os-release
#    source /etc/os-release
    set ID (grep '^ID=' /etc/os-release | cut -d '=' -f2 | tr -d '"')
    
    if test "$ID" = "debian"
         alias update="sudo apt update -y"
         alias upgrade="sudo apt upgrade -y"
         alias install="sudo apt install -y"
         alias remove="sudo apt remove -y"
         alias uninstall="sudo apt purge -y"
         alias list="apt list"
         # alias search="apt search"
         function search
            apt search $argv | awk '{print $1}'
        end
    end
end
