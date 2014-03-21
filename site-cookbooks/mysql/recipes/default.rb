#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
remote_file "#{Chef::Config[:file_cache_path]}/mysql-community-release-el6-5.noarch.rpm" do
  source 'http://repo.mysql.com/mysql-community-release-el6-5.noarch.rpm'
  action :create
end

rpm_package 'mysql-community-release' do
  source "#{Chef::Config[:file_cache_path]}/mysql-community-release-el6-5.noarch.rpm"
  action :install
end

yum_package 'mysql-community-server' do
  action :install
end

yum_package 'mysql-community-devel' do
  action :install
end

service 'mysqld' do
  action [:start, :enable]
end
