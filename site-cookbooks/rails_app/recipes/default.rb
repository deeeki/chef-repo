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
