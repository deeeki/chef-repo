define :mysql_create_database, charset: 'utf8' do
  execute "mysql_create_db #{params[:name]}" do
    command "mysql -u root -e 'CREATE DATABASE `#{params[:name]}` DEFAULT CHARACTER SET `#{params[:charset]}`;'"
    not_if "/usr/bin/mysql -u root -D #{params[:name]}"
  end
end
