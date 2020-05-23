# cnp - create new project
Small shell script to create a Github repository from the command line.

## Usage:

```sh
# Creates a new folder and public repository with the name <repository-name>
cnp <repository-name> 

# -p or --private flag creates a private repository
cnp <repository-name> -p | --private 

# Usage
cnp -h | --help 
```

## Installation: 

1. Clone the repo.
2. Install by moving "cnp.sh" to a folder in your PATH. Rename to "cnp".
On Linux/Unix you can use the script:
```sh
# install
./install.sh
```
Installs to /usr/local/bin/ as default.

The scripts requires the enviroment variables $USER, which is your Github username, and your $OAUTH-TOKEN from Github.
