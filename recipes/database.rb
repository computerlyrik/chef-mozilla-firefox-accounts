#
# Cookbook Name:: mozilla-firefox-accounts
# Recipe:: database
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

mysql2_chef_gem 'default' do
  client_version node['mysql']['version'] if node['mysql'] && node['mysql']['version']
  action :install
end

# Enable secure password generation
::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)
node.set_unless['gitlab']['database']['password'] = secure_password
ruby_block 'save node data' do
  block do
    node.save
  end
  not_if { Chef::Config[:solo] }
end

# install mysql database
mysql_service 'default' do
  port '3306'
  version node['mysql']['version'] if node['mysql'] && node['mysql']['version']
  initial_root_password node['mysql']['server_root_password']
  action [:create, :start]
end


# Helper variables
database = node['mozilla-firefox-accounts']['database']['database']
database_user = node['mozilla-firefox-accounts']['database']['user']
database_password = node['mozilla-firefox-accounts']['database']['password']


database_connection = {
  host: 'localhost',
  username: 'root',
  password: node['mysql']['server_root_password']
}

# Create the database
mysql_database database do
  connection database_connection
  action :create
end

# Create the database user
mysql_database_user database_user do
  connection database_connection
  password database_password
  database_name database
  privileges ['SELECT', 'LOCK TABLES', 'INSERT', 'UPDATE', 'DELETE', 'CREATE', 'DROP', 'INDEX', 'ALTER']
  action [:create, :grant]
end

