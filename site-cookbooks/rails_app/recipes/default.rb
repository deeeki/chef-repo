#
# Cookbook Name:: rails_app
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
user 'deploy' do
  uid 1000
  action :create
end

group 'deploy' do
  members node.app.deploy_users
  action :modify
end

directory '/var/www' do
  action :create
end

directory "/var/www/#{node.app.name}" do
  owner 'deploy'
  group 'deploy'
  mode '2775'
  action :create
end

simple_iptables_policy 'INPUT' do
  policy 'DROP'
end
simple_iptables_rule 'loopback' do
  chain 'system'
  rule '--in-interface lo'
  jump 'ACCEPT'
end
simple_iptables_rule 'established' do
  chain 'system'
  rule '-m conntrack --ctstate ESTABLISHED,RELATED'
  jump 'ACCEPT'
end
simple_iptables_rule 'ssh' do
  chain 'system'
  rule "--proto tcp --dport #{node.ssh.port}"
  jump 'ACCEPT'
end
simple_iptables_rule 'http' do
  rule [ '--proto tcp --dport 80',
         '--proto tcp --dport 443' ]
  jump 'ACCEPT'
end

template "#{node.nginx.dir}/sites-available/#{node.app.name}" do
  source 'nginx.conf.erb'
end

nginx_site node.app.name

mysql_secure_installation
mysql_create_database node.mysql.database_name
