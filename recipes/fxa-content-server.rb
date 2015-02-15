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

#include_recipe 'mozilla-firefox-accounts::fxa-auth-server'

include_recipe 'mozilla-firefox-accounts'

nodejs_npm 'grunt-cli'
nodejs_npm 'phantomjs'

directory node['mozilla-firefox-accounts']['content-server']['path'] do
  recursive true
end

nodejs_npm 'fxa-content-server' do
  url 'github mozilla/fxa-content-server.git'
  version node['mozilla-firefox-accounts']['content-server']['version']
  path node['mozilla-firefox-accounts']['content-server']['path']
  options ['--production']
end


#template "#{node['mozilla-firefox-accounts']['auth-server']['path']}/config/dev.json" do
#   source 'content-server.json.erb'
#end


#include_recipe 'application_nodejs'

application 'fxa-content-server' do
  path node['mozilla-firefox-accounts']['auth-db-server']['path']
  repository 'github mozilla/fxa-content-server.git'
  revision 'v0.19.0'
  nodejs
end
