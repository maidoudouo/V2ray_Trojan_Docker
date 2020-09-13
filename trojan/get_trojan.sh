#!/bin/sh

normalizeVersion() {
    if [ -n "$1" ]; then
        case "$1" in
            v*)
                echo "$1"
            ;;
            *)
                echo "v$1"
            ;;
        esac
    else
        echo ""
    fi
}

main(){
    TAG_URL="https://api.github.com/repos/p4gefau1t/trojan-go/releases/latest"
    VERSION="$(normalizeVersion "$(curl -s "${TAG_URL}" --connect-timeout 10| grep 'tag_name' | cut -d\" -f4)")"
	if [[ $VERSION == "" ]]; then
            echo "Failed to fetch release information. Please check your network or try again."
            return
	fi
	echo "Latest trojan version:" $VERSION
    git clone --branch=${VERSION} https://github.com/p4gefau1t/trojan-go.git
}
main
