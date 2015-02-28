#
# Cookbook Name:: mozilla-firefox-accounts
# Recipe:: fxa-auth-db-server
#
# Copyright 2014, 2015 computerlyrik, Christian Fischer
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'mozilla-firefox-accounts'
include_recipe 'mozilla-firefox-accounts::mysql'

# AUTH-DB-SERVER
directory node['mozilla-firefox-accounts']['auth-db-server']['path'] do
  recursive true
  user node['mozilla-firefox-accounts']['user']
end

git node['mozilla-firefox-accounts']['auth-db-server']['path']  do
  repository node['mozilla-firefox-accounts']['auth-db-server']['repository']
  revision node['mozilla-firefox-accounts']['auth-db-server']['version']
  user node['mozilla-firefox-accounts']['user']
  notifies :run, 'execute[npm install]', :immediately
end

execute 'npm install' do
  cwd node['mozilla-firefox-accounts']['auth-db-server']['path']
  action :nothing
end

template 'fxa-auth-db' do
  variables(
      user: node['mozilla-firefox-accounts']['database']['user'],
      password: node['mozilla-firefox-accounts']['database']['password'],
      database: node['mozilla-firefox-accounts']['database']['database']

  )
  path "#{node['mozilla-firefox-accounts']['auth-db-server']['path']}/config/prod.json"
  source 'auth-db-server.json.erb'
  notifies :restart, 'service[fxa-auth-db-server]'
end

nodejs_npm 'fxa-auth-db-server' do
  url node['mozilla-firefox-accounts']['auth-db-server']['path']
  path node['mozilla-firefox-accounts']['auth-db-server']['path']
end

template '/etc/init/fxa-auth-db-server.conf' do
  source 'upstart.conf.erb'
  variables(
      program_path: node['mozilla-firefox-accounts']['auth-db-server']['path']
  )
end

service 'fxa-auth-db-server' do
  action [:start, :enable]
end
