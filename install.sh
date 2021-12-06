#!/bin/bash
function join { local IFS="$1"; shift; echo "$*"; }
## rebuild all image if --build switch is set
while [ -n "$1" ]; do
        case "$1" in
        --build)
                build=true
                break
                ;;
        *) echo "Option $1 not recognized" ;;
        esac
        shift
done
if [ "$build" = true ]; then
    echo "Building images..."
    "`dirname "$BASH_SOURCE"`/build-all.sh"
fi

## Base docker command
dockerCmd="docker run --rm -it \
--network host \
-v \$HOME/.config:\$HOME/.config \
-v \$HOME/.local:\$HOME/.local \
-v \$HOME/.cache:\$HOME/.cache \
-v /etc/hosts:/etc/hosts \
-v \$(pwd):\$(pwd) \
-v /opt/wordlists:/opt/wordlists \
-w \$(pwd)"

## Parameters
dockerTag=`jq -r .dockerTag config.json`
installDir=`jq -r .installDir config.json`
linkDir=`jq -r .linkDir config.json`
tmpDir="`dirname "$BASH_SOURCE"`/tmp"

mkdir -p $tmpDir
sudo mkdir -p $installDir

## Loop through tools to create launch scripts
for tool in `jq -r ".tools[]" config.json|jq -c "."`; do
    localCmdJson=`echo $tool|jq -r .localcmd`
    localCmd=""
    for ((i = 0 ; i <= $(echo $localCmdJson | jq length) - 1 ; i++)); do
        item=$(echo $localCmdJson | jq ".[$i]" | sed s'/\"//g')
        localCmd=$localCmd" "$item
    done
    name=`echo $tool|jq -r .name`
    image=`echo $tool|jq -r .image`
    dockerArgJson=`echo $tool|jq -r .dockerarg`
    dockerArg=""
    for ((i = 0 ; i <= $(echo $dockerArgJson | jq length) - 1 ; i++)); do
        item=$(echo $dockerArgJson | jq ".[$i]" | sed s'/\"//g')
        dockerArg=$dockerArg" "$item
    done
    commandJson=`echo $tool|jq -r .command`
    command=""
    for ((i = 0 ; i <= $(echo $commandJson | jq length) - 1 ; i++)); do
        item=$(echo $commandJson | jq ".[$i]" | sed s'/\"//g')
        command=$command" "$item
    done
    #commandString=$(for item in "${command[@]}"; do; echo -n " $item"; done)
    #echo $commandString
    usermode=`echo $tool|jq -r .usermode`
    echo "## Installing $name ##"
    eval $localCmd
    if [[ $usermode == true ]]; then
        toolDockerCmd="$dockerCmd --user \"\$(id -u):\$(id -g)\""
    else
        toolDockerCmd=$dockerCmd
    fi
    if [[ $image != *"/"* ]]; then
        image=$dockerTag/$image
    fi
    cat << EOF > $tmpDir/$name
#!/bin/bash
$toolDockerCmd$dockerArg $image$command \$@
EOF
done

chmod +x $tmpDir/*
sudo cp $tmpDir/* $installDir/
rm -rf $tmpDir

## Symlink binaries to path
for bin in $installDir/* ; do
    sudo find -L $linkDir -samefile $bin -exec rm -rf {} \;
    sudo ln -s $bin $linkDir/
done
