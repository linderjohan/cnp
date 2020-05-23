#!/bin/sh

# Help/Usage
usage() {
	echo "Usage:"
	echo "cnp -h "
	echo "cnp <repository-name> -p "
	echo ""
	echo "   <repository-name>	Name of repository."
	echo "   -p			Private flag, creates a private repository."
	echo "   -h			Help (this output)."
	exit 0
}

# No USER variable available
if [ "$USER" == "" ]; then
	echo "This script requires your github username stored in environment variable \$USER"
	usage
fi

# No OAUTH_TOKEN variable available
if [ "$OAUTH_TOKEN" == "" ]; then
	echo "This script requires your OAUTH_TOKEN stored in environment variable \$OAUTH_TOKEN"
	usage
fi

# No arguments? Exit
if [ $# -eq 0 ]; then
	echo "Missing parameters."
	usage
fi

# Vars
REPONAME=""
PRIVATE=false

# Parse input
while [ "$1" != "" ]; do
	case $1 in
	-p | --private)
		PRIVATE=true
		;;

	-h | --help)
		usage
		;;

	*)
		REPONAME=$1
		;;

	esac
	shift
done

# If no reponame was supplied
if [ "$REPONAME" == "" ]; then
	echo "No repository name privided."
	usage
fi

# Create project folder
echo "Creating project folder $REPONAME ->"
mkdir $REPONAME
cd $REPONAME
echo "---Done---\n============\n"

# Create repo on github
echo "Creating Github repository $REPONAME ->"
curl --output /dev/null -# -H "Authorization: token $OAUTH_TOKEN" https://api.github.com/user/repos -d '{"name":"'$REPONAME'","private":'$PRIVATE'}'
# echo "Authorization: token $OAUTH_TOKEN" https://api.github.com/user/repos -d '{"name":"'$REPONAME'","private":'$PRIVATE'}'
echo "---Done---\n============\n"

# Create README.md
echo "Creating README ->"
echo "# $REPONAME" >>README.md
echo "---Done---\n============\n"

# Create .gitignore
echo "Creating .gitginore ->"
touch .gitignore
echo "---Done---\n============\n"

# Intial commit and push to remote
echo "Pushing to remote ->"
git init
git add -A
git commit -m "Initial commit"
git remote rm origin
git remote add origin https://github.com/$USER/$REPONAME.git
git push -u origin master
echo "---Done---\n============\n"

# Open repo in broswer
read -p "Open repo in browser? (y/n)  " answer_browser

case $answer_browser in
y)
	echo "Opening repo in browser."
	open https://github.com/$USER/$REPONAME
	;;
n) ;;

*) ;;

esac

echo "---All done---\n"
