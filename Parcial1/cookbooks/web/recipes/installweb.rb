package 'httpd'
package 'php'
package 'php-mysql' 
package 'mysql' 

service 'httpd' do
 action [:enable, :start]
end

bash 'open port' do 
 code <<-EOH
 iptables -I INPUT 5 -p tcp -m state --state NEW -m tcp --dport 80 -j ACCEPT
 service iptables save
EOH
end

cookbook_file 'var/www/html/index.html' do
 source 'index.html'
 mode 0644
end

cookbook_file 'var/www/html/info.php' do
 source 'info.php'
 mode 0644
end

template 'var/www/html/select.php' do
 source 'select.php.erb'
 mode 0777
 variables(
 usuarioweb_web: node[:web][:usuarioweb_web],
 ip_web: node[:web][:ip_web1],
 passwordweb_web: node[:web][:passwordweb_web]
 )
end


