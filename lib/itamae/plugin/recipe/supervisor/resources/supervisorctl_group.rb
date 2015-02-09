require_relative "./supervisorctl"

module Itamae
  module Plugin
    module Resource
      class SupervisorctlGroup < Itamae::Plugin::Resource::Supervisorctl
        define_attribute :action, default: :restart
        define_attribute :name, default: nil
        define_attribute :group, default: true
      end
    end
  end
end
