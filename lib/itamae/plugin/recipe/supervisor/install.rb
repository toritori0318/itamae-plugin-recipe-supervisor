node['supervisor'] = {} unless node['supervisor']

# vers
node['supervisor']['logdir']           = node['supervisor']['logdir'] || '/var/log/supervisor'
node['supervisor']['logfile']          = node['supervisor']['logfile'] || "#{node['supervisor']['logdir']}/supervisord.log"
node['supervisor']['logfile_maxbytes'] = node['supervisor']['logfile_maxbytes'] || '50MB'
node['supervisor']['logfile_backups']  = node['supervisor']['logfile_backups'] || '10'
node['supervisor']['loglevel']         = node['supervisor']['loglevel'] || 'info'
node['supervisor']['pidfile']          = node['supervisor']['pidfile'] || '/var/run/supervisord.pid'
node['supervisor']['configfile']       = node['supervisor']['configfile'] || '/etc/supervisord.conf'
node['supervisor']['nodaemon']         = node['supervisor']['nodaemon'] || 'false'
node['supervisor']['minfds']           = node['supervisor']['minfds'] || '1024'
node['supervisor']['minprocs']         = node['supervisor']['minprocs'] || '200'
node['supervisor']['include']          = node['supervisor']['include'] || '/etc/supervisor.d'



# directory
directory node['supervisor']['logdir'] do
  action :create
end
directory node['supervisor']['include'] do
  action :create
end

# pip install
package 'python-pip'
# install supervisor
execute "pip install supervisor"

# init script
template "/etc/init.d/supervisor" do
  source File.expand_path(File.dirname(__FILE__)) + "/templates/initscript.erb"
  variables(p: node['supervisor'])
  mode "755"
  notifies :restart, "service[supervisor]", :immediately
end

template "/etc/supervisord.conf" do
  source File.expand_path(File.dirname(__FILE__)) + "/templates/supervisord.conf.erb"
  variables(p: node['supervisor'])
  mode "644"
  notifies :restart, "service[supervisor]", :immediately
end

service "supervisor" do
  action [:enable, :start]
end
