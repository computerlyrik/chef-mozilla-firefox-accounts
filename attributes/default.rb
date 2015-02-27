default['mozilla-firefox-accounts']['server_name'] = "ffsync.#{node['domain']}"

default['mozilla-firefox-accounts']['user'] = 'fxcloud'

default['mozilla-firefox-accounts']['database']['user'] = 'fxcloud'
default['mozilla-firefox-accounts']['database']['database'] = 'fxcloud'
default['mozilla-firefox-accounts']['database']['password'] = nil

default['mozilla-firefox-accounts']['auth-db-server']['path'] = '/srv/fxa/auth-db-server'
default['mozilla-firefox-accounts']['auth-db-server']['version'] = 'da325333a080f06fdda33857ff21ef34b661175e'

default['mozilla-firefox-accounts']['auth-db-mysql']['path'] = '/srv/fxa/auth-db-mysql'
default['mozilla-firefox-accounts']['auth-db-mysql']['version'] = '2b1e00bf4944e5f2a5c319028093582615ff18b6'


default['mozilla-firefox-accounts']['auth-server']['path'] = '/srv/fxa/auth-server'
default['mozilla-firefox-accounts']['auth-server']['version'] = '310c3c881c11ab2f42b85cf99f47c950e8684c94'

default['mozilla-firefox-accounts']['content-server']['path'] = '/srv/fxa/content-server'
default['mozilla-firefox-accounts']['content-server']['version'] = 'v0.31.0'


