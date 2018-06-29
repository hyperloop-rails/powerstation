ruby maven libs
---------------

this is just a regular [maven](maven.apache.org) packed as gem. mainly used by [ruby-maven](github.com/takari/ruby-maven)

release a new version
---------------

adjust the version in **lib/maven.rb** and then execute

    ./mvnw deploy

this will push the gem to rubygems.org

license
------

it just comes with the same license as maven itself and all the license info can be found under maven-home/ after

    ./mvnw package


