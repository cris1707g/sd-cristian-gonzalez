package 'httpd'

service 'httpd' do 
 action [:enable, :start]
end

bash 'open port' do 
 code <<-EOH
 iptables -I INPUT 5 -p tcp -m state --state NEW -m tcp --dport 80 -j ACCEPT
 iptables -I INPUT 5 -p tcp -m state --state NEW -m tcp --dport 8080 -j ACCEPT
 service iptables save
EOH
end

cookbook_file "etc/httpd/conf.d/balancecfg.conf" do
  source "balancecfg.conf"
  mode 0644
end



