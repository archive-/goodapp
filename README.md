goodapp
=======

GETTING STARTED
---------------
- install rvm (ruby version manager): http://beginrescueend.com/rvm/install/
- make sure that once it's installed you open a new shell (needs to get sourced)
- rvm install 1.9.2
- rvm use 1.9.2
- rvm default 1.9.2
- rvm gemset create goodapp
- cd GOODAPP\_DIRECTORY
- rvm should prompt you -- say you trust by typing 'y'
- then: 'gem install bundler'
- then: 'bundle install' --> should install 'rails' gem
  - (installs gems from the Gemfile in current directory)
- then: 'cd web' (to go into the ruby on rails directory)
- then: 'bundle install' again (to install the gems specific to the web stuff)
- type: 'git submodule init' (to get bootstrap)
- then: 'git submodule update'
- finally, inside the web directory, just type 'rails server' and go to localhost:3000

NOTES
-----
- generated web directory with:
    rails new web
