default['mozilla-firefox-accounts']['server_name'] = "ffsync.#{node['domain']}"

default['mozilla-firefox-accounts']['user'] = 'fxcloud'

default['mozilla-firefox-accounts']['database']['user'] = 'fxcloud'
default['mozilla-firefox-accounts']['database']['database'] = 'fxcloud'
default['mozilla-firefox-accounts']['database']['password'] = nil

default['mozilla-firefox-accounts']['auth-db-server']['repository'] = 'https://github.com/mozilla/fxa-auth-db-mysql.git'
default['mozilla-firefox-accounts']['auth-db-server']['version'] = 'train-31'
default['mozilla-firefox-accounts']['auth-db-server']['path'] = '/srv/fxa/auth-db-server'

default['mozilla-firefox-accounts']['auth-server']['version'] = 'train-31'
default['mozilla-firefox-accounts']['auth-server']['path'] = '/srv/fxa/auth-server'

default['mozilla-firefox-accounts']['content-server']['version'] = 'v0.31.0'
default['mozilla-firefox-accounts']['content-server']['path'] = '/srv/fxa/content-server'



