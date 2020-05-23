#!/bin/sh

# TODO Find out the correct path to move to
# Windows compatibility

PATHDIR="/usr/local/bin"

echo "Moving cnp to $PATHDIR"
chmod 755 cnp.sh
sudo cp cnp.sh "$PATHDIR/cnp"
echo "Done."
