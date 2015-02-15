default['mozilla-firefox-accounts']['server_name'] = "ffsync.#{node['domain']}"

default['mozilla-firefox-accounts']['user'] = 'fxcloud'

default['mozilla-firefox-accounts']['database']['user'] = 'fxcloud'
default['mozilla-firefox-accounts']['database']['database'] = 'fxcloud'

default['mozilla-firefox-accounts']['auth-db-server']['path'] = '/fxa/auth-db-server'
default['mozilla-firefox-accounts']['auth-db-server']['version'] = 'fa80cf0c996c84271da88cf73578dd95def96f6e'

default['mozilla-firefox-accounts']['auth-server']['path'] = '/fxa/auth-server'
default['mozilla-firefox-accounts']['auth-server']['version'] = '45a0574d17221f7557960164011f3c72c233e284'

default['mozilla-firefox-accounts']['content-server']['path'] = '/fxa/content-server'
default['mozilla-firefox-accounts']['content-server']['version'] = 'v0.30.0'


