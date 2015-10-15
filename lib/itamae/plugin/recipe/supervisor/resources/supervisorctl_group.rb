require_relative "./supervisorctl"

module Itamae
  module Plugin
    module Resource
      class SupervisorctlGroup < Itamae::Plugin::Resource::Supervisorctl
        define_attribute :action, default: :restart
        define_attribute :name, default: nil, default_name: true

        def exec(action, enable_all=false)
          command = ["supervisorctl", action]
          if attributes.name
            name = attributes.name
            if action != "update"
              name = "#{attributes.name}:*"
            end
            command.push(name)
          elsif enable_all
            command.push("all")
          end
          run_command(command)
        end

      end
    end
  end
end
