#! /bin/bash
#
# script name: setup.bash
# script author: munair simpson
# script created: 20190605
# script purpose: spin up node/express with Pixelarity's Paradigm Shift template

# disable/enable debugging.
debug="false" && echo [$0] set debug mode to "$debug".

# step 1: update the package list and install Yarn. this also installs Node. install unzip and install NPM last.
if $debug ; then sudo apt -y update && sudo apt -y install unzip && sudo apt -y install npm && sudo apt -y install vim ; fi
sudo apt -y update > /dev/null 2>&1 && echo [$0] updated APT packages.
sudo apt -y install unzip > /dev/null 2>&1 && echo [$0] installed unzip APT.
sudo apt -y install npm > /dev/null 2>&1 && echo [$0] installed NPM APT.
sudo apt -y install vim > /dev/null 2>&1 && echo [$0] installed vim APT.

# step 2: install Express Generator.
if $debug ; then sudo npm install -g express-generator ; fi
sudo npm install -g express-generator > /dev/null 2>&1 && echo [$0] installed Express Generator.

# step 3: verify the installation of APTs and ExpressJS via NPM.
nodeversion=$(nodejs --version) && echo [$0] verified the installation of nodejs version $nodeversion.
npmversion=$(npm --version) && echo [$0] verified the installation of npm version $npmversion.
expressversion=$(express --version) && echo [$0] verified the installation of express version $expressversion.

# step 4: install html2pug.
if $debug ; then sudo npm install -g html2pug ; fi
sudo npm install -g html2pug > /dev/null 2>&1 && echo [$0] installed html2pug.

# step 5: prepare fields for npm init customizations.
cat << EOF > ~/.npm-init.js
module.exports = {
  'license': 'MIT',
  'homepage': 'https://github.com/usefulcoin/express-pixelarity-standout-initialization',
  'author': {
    'email': 'munair@gmail.com',
    'name': 'munair'
  },
  'repository': {
      'type': 'git',
      'url': 'https://github.com/usefulcoin/express-pixelarity-standout-initialization.git'
  },
  'scripts': {
    'clean': 'rm -rf dist/*',
    'loadhtml': 'pug views/*.pug --pretty --out dist',
    'loadsass': 'node-sass public/stylesheets/sass/main.scss public/stylesheets/main.css',
    'loadtherest': 'cp -R public/* dist && cp public/images/favicon.ico dist/',
    'prebuild': 'npm run clean',
    'build:markup': 'npm run loadhtml',
    'build:therest': 'npm run loadtherest',
    'build:styles': 'npm run loadsass',
    'build': 'npm run build:styles && npm run build:therest && npm run build:markup -s',
    'deploy:dev': 's3-cli sync ./dist/ s3://development/',
    'deploy:www': 's3-cli sync ./dist/ s3://production/',
    'deploy': 'npm run deploy:dev && npm run deploy:www',
    'start': 'node ./bin/www',
    'devstart': 'nodemon ./bin/www'
  }
}
EOF

# step 6: create application skeleton.
express --css sass --view pug standout && echo [$0] created web application skeleton.
npm set init.repository 'https://github.com/usefulcoin/express-pixelarity-standout-initialization.git' && echo [$0] set default repository.
npm set init.description 'Fresh set up of the Pixelarity Standout template for a NodeJS/Express Server' && echo [$0] set default description.
cd standout && npm init --yes && npm install && echo [$0] application initialized and essential node modules installed.
npm install --save-dev nodemon && echo [$0] nodemon installed as a developer dependency.
npm install --save-dev s3-cli && echo [$0] s3-cli installed as a developer dependency.
npm install --save-dev node-sass && echo [$0] node-sass installed as a developer dependency.

# step 7: install template.
unzip ../standout.zip -d /tmp/standout && mv /tmp/standout/standout . && echo [$0] unzipped template archive.
cp -R standout/assets/fonts public && echo [$0] installed fonts.
cp standout/assets/js/* public/javascripts && echo [$0] installed javascripts.
cp -R standout/assets/sass public/stylesheets && echo [$0] installed sass modules.
cp standout/assets/css/* public/stylesheets && echo [$0] installed stylesheets.
html2pug < standout/index.html > /tmp/puggified.html && sed -e 's#assets/css#stylesheets#g;s#assets/js#javascripts#g' /tmp/puggified.html > views/index.pug && echo [$0] installed index.html.
cp -R standout/images public && echo [$0] installed images.
rm -rf standout && rm -rf ../standout.zip && echo [$0] removing standout directory & zip archive.

# step 7: start application
echo [$0] starting web application && DEBUG=standout:* npm start
