#!/bin/bash
## Base docker command

while [ -n "$1" ]; do # while loop starts
        case "$1" in
        --build)
                build=true
                break
                ;; # Exit the loop using break command
        *) echo "Option $1 not recognized" ;;
        esac
        shift
done

if [ "$build" = true ]; then
    echo "Building images..."
    "`dirname "$BASH_SOURCE"`/build-all.sh"
fi

docker_cmd="docker run --rm -it \
--network host \
-v /etc/hosts:/etc/hosts \
-v \$(pwd):\$(pwd) \
-v /opt/wordlists:/opt/wordlists \
-w \$(pwd)"

dockerTag=`jq -r .dockerTag config.json`
installDir=`jq -r .installDir config.json`
linkDir=`jq -r .linkDir config.json`
tmpDir="`dirname "$BASH_SOURCE"`/tmp"
mkdir -p $tmpDir
sudo mkdir -p $installDir

cat << EOF > $tmpDir/stegseek
#!/bin/bash
$docker_cmd $dockerTag/stegano stegseek \$@
EOF

cat << EOF > $tmpDir/binwalk
#!/bin/bash
$docker_cmd $dockerTag/stegano binwalk \$@
EOF

cat << EOF > $tmpDir/steghide
#!/bin/bash
$docker_cmd $dockerTag/stegano steghide \$@
EOF

cat << EOF > $tmpDir/steghide
#!/bin/bash
$docker_cmd $dockerTag/nikto nikto \$@
EOF

cat << EOF > $tmpDir/wpscan
#!/bin/bash
$docker_cmd wpscanteam/wpscan \$@
EOF

cat << EOF > $tmpDir/wfuzz
#!/bin/bash
$docker_cmd ghcr.io/xmendez/wfuzz \$@
EOF

cat << EOF > $tmpDir/nmap
#!/bin/bash
$docker_cmd $dockerTag/nmap \$@
EOF

cat << EOF > $tmpDir/ffuf
#!/bin/bash
$docker_cmd $dockerTag/gofuzz /usr/local/bin/ffuf \$@
EOF

cat << EOF > $tmpDir/gobuster
#!/bin/bash
$docker_cmd $dockerTag/gofuzz /usr/local/bin/gobuster \$@
EOF

cat << EOF > $tmpDir/msfconsole
#!/bin/bash
$docker_cmd $dockerTag/metasploit /opt/metasploit-framework/bin/msfconsole \$@
EOF

cat << EOF > $tmpDir/msfvenom
#!/bin/bash
$docker_cmd $dockerTag/metasploit /opt/metasploit-framework/bin/msfvenom \$@
EOF

cat << EOF > $tmpDir/sqlmap
#!/bin/bash
$docker_cmd $dockerTag/sqlmap \$@
EOF

cat << EOF > $tmpDir/amass
#!/bin/bash
$docker_cmd -v /home/h3x/.config/amass:/.config/amass/ caffix/amass \$@
EOF

chmod +x $tmpDir/*
sudo cp $tmpDir/* $installDir/
rm -rf $tmpDir

for bin in $installDir/* ; do
    sudo rm $linkDir/`basename $bin`
    sudo ln -s $bin $linkDir/
done