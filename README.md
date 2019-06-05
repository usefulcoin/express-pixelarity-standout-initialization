# Standout Express

This script sets up a fresh installation of Pixelarity's Standout on an Amazon EC2 Ubuntu NodeJS/Express Server.

## Purpose

The script was written to automate the process of preparing an Express web application with the Pixelarity Standout template. It should run without incident on a new Amazon EC2 instance running Ubuntu. Once the template is integrated into the Express web application the developer can veer off into more meaningful study and coding.

## Process

```sh
step 1: update the package list. this also installs Node. install unzip and install NPM last.
step 2: install Express Generator.
step 3: verify the installation of APTs and ExpressJS via NPM.
step 4: install html2pug.
step 5: prepare fields for npm init customizations.
step 6: create application skeleton.
step 7: install template.
step 8: start application.
```

## Execution
```sh
git clone https://github.com/usefulcoin/express-pixelarity-standout-initialization.git
cd express-pixelarity-standout-initialization
bash setup.bash
```

## Debugging

Change the debug mode to **true** in the setup.bash script.
