name             'mozilla-firefox-accounts'
maintainer       'computerlyrik, Christian Fischer'
maintainer_email 'chef-cookbooks@computerlyrik.de'
license          'Apache 2.0'
description      'Installs/Configures mozilla-firefox-accounts'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

supports 'ubuntu'

depends 'git'
depends 'nodejs'
depends 'application_nodejs'
