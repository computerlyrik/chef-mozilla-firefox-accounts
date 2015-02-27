#
# Cookbook Name:: mozilla-firefox-accounts
# Recipe:: fxa-auth-server
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



include_recipe 'mozilla-firefox-accounts::database'

#AUTH-DB-SERVER
directory node['mozilla-firefox-accounts']['auth-db-server']['path'] do
  recursive true
end

git node['mozilla-firefox-accounts']['auth-db-server']['path']  do
  repository 'https://github.com/mozilla/fxa-auth-db-server.git'
  revision node['mozilla-firefox-accounts']['auth-db-server']['version']
end

nodejs_npm 'fxa-auth-db-server' do
  url node['mozilla-firefox-accounts']['auth-db-server']['path']
  options ['--production']
end


#AUTH-DB-SERVER MYSQL
directory node['mozilla-firefox-accounts']['auth-db-mysql']['path'] do
  recursive true
end

git node['mozilla-firefox-accounts']['auth-db-mysql']['path']  do
  repository 'https://github.com/mozilla/fxa-auth-db-mysql.git'
  revision node['mozilla-firefox-accounts']['auth-db-mysql']['version']
  notifies :create, 'template[fxa-auth-db]', :immediately
  notifies :run, 'nodejs_npm[fxa-auth-db-mysql]', :immediately
  notifies :run, 'execute[fxa-auth-db-migration]', :immediately
end

template 'fxa-auth-db' do
  variables(
      user: node['mozilla-firefox-accounts']['database']['user'],
      password: node['mozilla-firefox-accounts']['database']['password'],
      database: node['mozilla-firefox-accounts']['database']['database']

  )
  path "#{node['mozilla-firefox-accounts']['auth-db-mysql']['path']}/config/prod.json"
  source 'auth-db-server.json.erb'
end

nodejs_npm 'fxa-auth-db-mysql' do
  url node['mozilla-firefox-accounts']['auth-db-mysql']['path']
  options ['--production']
  action :nothing
end

execute 'fxa-auth-db-migration' do
  cwd node['mozilla-firefox-accounts']['auth-db-mysql']['path']
  command 'node bin/db_patcher.js'
  action :nothing
end




#AUTH-SERVER
package 'libgmp10'
package 'libgmp10-dev'

directory node['mozilla-firefox-accounts']['auth-server']['path'] do
  recursive true
end

git node['mozilla-firefox-accounts']['auth-server']['path']  do
  repository 'https://github.com/mozilla/fxa-auth-server.git'
  revision node['mozilla-firefox-accounts']['auth-server']['version']
end

nodejs_npm 'fxa-auth-server' do
  url node['mozilla-firefox-accounts']['auth-server']['path']
  options ['--production']
end

#template "#{node['mozilla-firefox-accounts']['auth-server']['path']}/config/dev.json" do
#   source 'auth-db-server.json.erb'
#end
