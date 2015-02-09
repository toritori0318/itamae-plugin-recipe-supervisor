require_relative './resources/supervisorctl'
require_relative './resources/supervisorctl_group'

# define service dsl
define :supervisor_service,
    command: nil,
    process_name: "%(program_name)s",
    numprocs: 1,
    numprocs_start: 0,
    priority: 999,
    autorestart: false,
    autostart: false,
    startsecs: 1,
    startretries: 3,
    exitcodes: [0,2],
    stopsignal: 'TERM',
    stopwaitsecs: 10,
    stopasgroup: nil,
    killasgroup: nil,
    user: 'root',
    redirect_stderr: false,
    stdout_logfile: 'AUTO',
    stdout_logfile_maxbytes: '50MB',
    stdout_logfile_backups: 10,
    stdout_capture_maxbytes: 0,
    stdout_events_enabled: false,
    stderr_logfile: 'AUTO',
    stderr_logfile_maxbytes: '50MB',
    stderr_logfile_backups: 10,
    stderr_capture_maxbytes: 0,
    stderr_events_enabled: false,
    environment: {},
    directory: nil,
    umask: nil,
    serverurl: 'AUTO',
    supervisor_dir: '/etc/supervisor.d' do

  tparams = params
  tparams[:service_name] = params[:name]

  template "#{params[:supervisor_dir]}/#{tparams[:service_name]}.conf" do
    source File.expand_path(File.dirname(__FILE__)) + "/templates/program.conf.erb"
    variables(p: tparams)
    mode "644"
  end

end


# define group dsl
define :supervisor_group,
    programs: [],
    priority: nil,
    supervisor_dir: '/etc/supervisor.d' do

  tparams = params
  tparams[:group_name] = params[:name]

  template "#{params[:supervisor_dir]}/#{params[:name]}.conf" do
    source File.expand_path(File.dirname(__FILE__)) + "/templates/group.conf.erb"
    variables(p: tparams)
    mode "644"
  end

end
