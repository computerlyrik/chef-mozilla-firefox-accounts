#
# Cookbook Name:: mozilla-firefox-accounts
# Recipe:: fxa-auth-server
#
# Copyright 2014, computerlyrik, Christian Fischer
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

package 'libgmp10'
package 'libgmp10-dev'


#AUTH-DB-SERVER
nodejs_npm 'fxa-auth-db-server' do
  url 'https://github.com/mozilla/fxa-auth-db-server.git'
  options ['--production']
  path node['mozilla-firefox-accounts']['auth-db-server']['path']
end

include_recipe 'mozilla-firefox-accounts::database'

#
#template "#{node['mozilla-firefox-accounts']['auth-db-server']['path']}/config/prod.json" do
#  variables(
#      user: node['mozilla-firefox-accounts']['database']['user'],
#      password: node['mozilla-firefox-accounts']['database']['password'],
#      database: node['mozilla-firefox-accounts']['database']['database']
#
#  )
#   source 'auth-db-server.json.erb'
#end



#AUTH-SERVER
nodejs_npm 'fxa-auth-server' do
  url 'github mozilla/fxa-auth-server.git'
  options ['--production']
  path node['mozilla-firefox-accounts']['auth-server']['path']
end

#template "#{node['mozilla-firefox-accounts']['auth-server']['path']}/config/dev.json" do
#   source 'auth-db-server.json.erb'
#end
