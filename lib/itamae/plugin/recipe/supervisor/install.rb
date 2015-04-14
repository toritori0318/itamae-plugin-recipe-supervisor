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
package 'python-setuptools'
# install supervisor
execute "easy_install supervisor"
# link
link "/usr/bin/supervisorctl" do
  to "/usr/local/bin/supervisorctl"
  only_if "! test -e /usr/bin/supervisorctl"
end
# link
link "/usr/bin/supervisord" do
  to "/usr/local/bin/supervisord"
  only_if "! test -e /usr/bin/supervisord"
end

# init script
template "/etc/init.d/supervisor" do
  source File.expand_path(File.dirname(__FILE__)) + "/templates/initscript.erb"
  variables(p: node['supervisor'])
  mode "755"
  notifies :run, "execute[supervisor restart(zombie aversion)]", :immediately
end

template "/etc/supervisord.conf" do
  source File.expand_path(File.dirname(__FILE__)) + "/templates/supervisord.conf.erb"
  variables(p: node['supervisor'])
  mode "644"
  notifies :run, "execute[supervisor restart(zombie aversion)]", :immediately
end

execute "supervisor restart(zombie aversion)" do
  command <<-"EOH"
if ( supervisorctl avail ) < /dev/null > /dev/null 2>&1; then
  echo "- supervisorctl stop all.."
  supervisorctl stop all
  sleep 1
fi
service supervisor restart
EOH
end

service "supervisor" do
  action [:enable]
end
