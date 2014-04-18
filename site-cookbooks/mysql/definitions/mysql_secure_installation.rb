define :mysql_secure_installation do
  execute "mysql_secure_install" do
    command <<-"EOH"
    mysqladmin drop test -f
    mysql -e "DELETE from user WHERE user = '';" -D mysql
    mysql -e "DELETE from user WHERE user = 'root' AND host = \'#{`hostname`.chomp}\';" -D mysql
    mysql -e "SET PASSWORD FOR 'root'@'::1' = PASSWORD('#{node.mysql.server_root_password}');" -D mysql
    mysql -e "SET PASSWORD FOR 'root'@'127.0.0.1' = PASSWORD('#{node.mysql.server_root_password}');" -D mysql
    mysql -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('#{node.mysql.server_root_password}');" -D mysql
    mysqladmin flush-privileges -p#{node.mysql.server_root_password}
    EOH
    action node.mysql.server_root_password != "" ? :run : :nothing
    only_if 'mysql -u root -e "SHOW DATABASES;"'
  end
end
