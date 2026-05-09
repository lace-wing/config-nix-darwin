#!/bin/sh

if [ "$OSTYPE" = "darwin"* ]; then
	export JAVA_HOME=$(/usr/libexec/java_home -v 17) 
fi

exec jdtls "$@"
