#
# Cookbook Name:: vagrant
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
bash 'create swapfile' do
  user 'root'
  code <<-EOC
    dd if=/dev/zero of=/swapfile bs=1M count=2048 &&
    chmod 600 /swapfile
    mkswap /swapfile
  EOC
  only_if 'test ! -f /swapfile -a `cat /proc/swaps | wc -l` -eq 1'
end

mount '/dev/null' do
  action :enable
  device '/swapfile'
  fstype 'swap'
end

bash 'activate swap' do
  code 'swapon -ae'
  only_if 'test `cat /proc/swaps | wc -l` -eq 1'
end
