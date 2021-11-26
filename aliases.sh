docker_cmd="docker run --rm -it \
--network host \
-v $(pwd):$(pwd) \
-v /opt/worldlists:/opt/wordlists"

alias ffuf="$docker_cmd h3xtool/ffuf"
alias gobuster="$docker_cmd h3xtool/gobuster"
alias hydra="$docker_cmd h3xtool/hydra"
alias msfconsole="$docker_cmd h3xtool/metasploit"
alias msfvenom="$docker_cmd h3xtool/metasploit"
alias sqlmap="$docker_cmd h3xtool/sqlmap"