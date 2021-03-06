#
# Cookbook Name:: mozilla-firefox-accounts
# Recipe:: fxa-content-server
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

# include_recipe 'mozilla-firefox-accounts::fxa-auth-server'

include_recipe 'mozilla-firefox-accounts'

nodejs_npm 'grunt-cli'
nodejs_npm 'phantomjs'

directory node['mozilla-firefox-accounts']['content-server']['path'] do
  recursive true
  user node['mozilla-firefox-accounts']['user']
end

git node['mozilla-firefox-accounts']['content-server']['path']  do
  repository 'https://github.com/mozilla/fxa-content-server.git'
  revision node['mozilla-firefox-accounts']['content-server']['version']
  user node['mozilla-firefox-accounts']['user']
end

nodejs_npm 'fxa-content-server' do
  url node['mozilla-firefox-accounts']['content-server']['path']
  path node['mozilla-firefox-accounts']['content-server']['path']
end

template "#{node['mozilla-firefox-accounts']['content-server']['path']}/server/config/local.json" do
  source 'content-server.json.erb'
  variables(
      use_htttps: node['mozilla-firefox-sync']['content-server']['use_https']
  )
  notifies :restart, 'service[fxa-content-server]'
end

template '/etc/init/fxa-content-server.conf' do
  source 'upstart.conf.erb'
  variables(
      program_path: node['mozilla-firefox-accounts']['content-server']['path']
  )
end

service 'fxa-content-server' do
  action [:start, :enable]
end

# include_recipe 'application_nodejs'
#
# application 'fxa-content-server' do
#  path node['mozilla-firefox-accounts']['auth-db-server']['path']
#  repository 'github mozilla/fxa-content-server.git'
#  revision 'v0.19.0'
#  nodejs
# end
