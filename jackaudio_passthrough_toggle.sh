#!/bin/bash

# Author: Thorben Weber

# toggles jack audio microphone passthrough on and off

# jack_lsp lists ports and the ports they are
# connected to will be listed indented below.

FROM=system:capture_1
TO=system:playback_1

# ^\s detects whitespace at the start of a line
RESULT=$(jack_lsp -c "$FROM" | grep "^\s" | grep "$TO" )

# -n tests for nonempty strings
if [[ -n "$RESULT" ]]; then
        jack_disconnect system:capture_1 system:playback_1
        jack_disconnect system:capture_2 system:playback_2
else
        jack_connect system:capture_1 system:playback_1
        jack_connect system:capture_2 system:playback_2
fi
