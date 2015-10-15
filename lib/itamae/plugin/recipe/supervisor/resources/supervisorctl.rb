require "itamae/resource/base"

module Itamae
  module Plugin
    module Resource
      class Supervisorctl < Itamae::Resource::Base
        define_attribute :action, default: :restart
        define_attribute :name, default: nil, default_name: true

        def set_current_attributes
          super
          ensure_supervisor_availability
        end

        def action_restart(options)
          exec("restart", true)
        end

        def action_start(options)
          exec("start", true)
        end

        def action_stop(options)
          exec("stop", true)
        end

        def action_update(options)
          exec("update")
        end

        def action_reload(options)
          exec("reload")
        end

        private

        def exec(action, enable_all=false)
          command = ["supervisorctl", action]
          if attributes.name
            name = attributes.name
            command.push(name)
          elsif enable_all
            command.push("all")
          end
          run_command(command)
        end

        def ensure_supervisor_availability
        end
      end
    end
  end
end
