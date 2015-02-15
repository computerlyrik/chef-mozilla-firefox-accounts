default['mozilla-firefox-accounts']['server_name'] = "ffsync.#{node['domain']}"

default['mozilla-firefox-accounts']['user'] = 'fxcloud'

default['mozilla-firefox-accounts']['database']['user'] = 'fxcloud'
default['mozilla-firefox-accounts']['database']['database'] = 'fxcloud'

default['mozilla-firefox-accounts']['auth-db-server']['path'] = '/fxa/auth-db-server'

default['mozilla-firefox-accounts']['auth-server']['path'] = '/fxa/auth-server'


default['mozilla-firefox-accounts']['content-server']['path'] = '/fxa/content-server'
default['mozilla-firefox-accounts']['content-server']['version'] = 'v0.30.0'


