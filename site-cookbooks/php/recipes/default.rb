#
# Cookbook Name:: php
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
remote_file "#{Chef::Config[:file_cache_path]}/remi-release-6.rpm" do
  source 'http://rpms.famillecollet.com/enterprise/remi-release-6.rpm'
  action :create
end

rpm_package 'remi-release' do
  source "#{Chef::Config[:file_cache_path]}/remi-release-6.rpm"
  action :install
end

%w[php-devel php-mbstring php-fpm php-mysqlnd].each do |package|
  yum_package package do
    action :install
    options '--enablerepo=remi-php55'
  end
end

template '/etc/php.ini' do
  source 'php.ini.erb'
end
