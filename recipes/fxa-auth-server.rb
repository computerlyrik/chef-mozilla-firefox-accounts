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

include_recipe 'mozilla-firefox-accounts::fxa-auth-db-server'

#AUTH-SERVER
package 'libgmp10'
package 'libgmp10-dev'

directory node['mozilla-firefox-accounts']['auth-server']['path'] do
  recursive true
  user node['mozilla-firefox-accounts']['user']
end

git node['mozilla-firefox-accounts']['auth-server']['path']  do
  repository 'https://github.com/mozilla/fxa-auth-server.git'
  revision node['mozilla-firefox-accounts']['auth-server']['version']
  user node['mozilla-firefox-accounts']['user']
end

nodejs_npm 'fxa-auth-server' do
  url node['mozilla-firefox-accounts']['auth-server']['path']
  path node['mozilla-firefox-accounts']['auth-server']['path']
end

template "#{node['mozilla-firefox-accounts']['auth-server']['path']}/config/prod.json" do
   source 'auth-server.json.erb'
  notifies :restart, 'service[fxa-auth-server]'
end

template '/etc/init/fxa-auth-server.conf' do
  source 'upstart-auth-server.conf.erb'
end

service 'fxa-auth-server' do
  action [:start, :enable]
end 

