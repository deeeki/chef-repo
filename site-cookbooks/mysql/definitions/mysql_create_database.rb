define :mysql_create_database, charset: 'utf8' do
  execute "mysql_create_db #{params[:name]}" do
    password_option = node.mysql.server_root_password != "" ? "-p#{node.mysql.server_root_password}" : ''
    command "mysql -u root #{password_option} -e 'CREATE DATABASE `#{params[:name]}` DEFAULT CHARACTER SET `#{params[:charset]}`;'"
    not_if "mysql -u root #{password_option} -D #{params[:name]}"
  end
end
