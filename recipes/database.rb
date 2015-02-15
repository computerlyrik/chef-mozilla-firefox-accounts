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

