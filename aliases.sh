docker_cmd="docker run --rm -it \
--network host \
-v /etc/hosts:/etc/hosts \
-v \$(pwd):\$(pwd) \
-v /opt/wordlists:/opt/wordlists \
-w \$(pwd)"

alias stegseek="$docker_cmd h3xtool/stegano stegseek" 
alias binwalk="$docker_cmd h3xtool/stegano binwalk"
alias steghide="$docker_cmd h3xtool/stegano steghide"
alias nikto="$docker_cmd h3xtool/nikto"
alias wpscan="$docker_cmd wpscanteam/wpscan"
alias wfuzz="$docker_cmd ghcr.io/xmendez/wfuzz"
alias nmap="$docker_cmd h3xtool/nmap"
alias ffuf="$docker_cmd h3xtool/gofuzz /usr/local/bin/ffuf"
alias gobuster="$docker_cmd h3xtool/gofuzz /usr/local/bin/gobuster"
alias hydra="$docker_cmd h3xtool/hydra"
alias msfconsole="$docker_cmd h3xtool/metasploit /opt/metasploit-framework/bin/msfconsole"
alias msfvenom="$docker_cmd h3xtool/metasploit /opt/metasploit-framework/bin/msfvenom"
alias sqlmap="$docker_cmd h3xtool/sqlmap"
alias amass="$docker_cmd -v /home/h3x/.config/amass:/.config/amass/ caffix/amass"
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias ape='source ./venv/bin/activate'