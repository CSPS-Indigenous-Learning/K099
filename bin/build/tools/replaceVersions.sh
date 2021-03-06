#!/bin/bash

#since this script can be launch from the build, we need to get the path of the first script that was executed
currentDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $currentDir/utils.sh

source $currentDir/../../../versions.txt

main() {
	replace_versions
}

validate_input() {
	semver_regex="^(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)(\-[0-9A-Za-z-]+(\.[0-9A-Za-z-]+)*)?(\+[0-9A-Za-z-]+(\.[0-9A-Za-z-]+)*)?$"

	if [[ "$FWversion" =~ $semver_regex ]]
    then
		echo -en '\E[32m'"\033[1mFWversion follow semver standard\033[0m"
		echo
        return 0
    else
        errcho "FWversion $FWversion does not follow semver standard"
		return 1
    fi

    if [[ "$WETversion" =~ $semver_regex ]]
    then
		echo -en '\E[32m'"\033[1mWETversion follow semver standard\033[0m"
		echo
        return 0
    else
        errcho "WETversion $WETversion does not follow semver standard"
		return 1
    fi
}

replace_versions() {
	if validate_input
	then
		doNotModify="\/\/*DO NOT MODIFY. Auto-generated by build*\/\/"
		echo FWversion = $FWversion
		echo WETversion = $WETversion

		# find and replace line "version": of package.json
		echo Replacing FWversion in package.json ...
		sed -i "s/\"version\":.*/\"version\": \""$FWversion"\",/" $currentDir/../../../package.json
		echo Done

		# replace line this.version = of app.js
		echo Replacing FWversion in app.js ...
		sed -i "s/this.version =.*/this.version = "\"$FWversion\""; $doNotModify/" $currentDir/../../../core/js/app.js
		echo Done

		# replace line this.WETversion = of app.js
		echo Replacing WETversion in app.js ...
		sed -i "s/this.WETversion =.*/this.WETversion = "\"$WETversion\""; $doNotModify/" $currentDir/../../../core/js/app.js
		echo Done
	fi
}

main
