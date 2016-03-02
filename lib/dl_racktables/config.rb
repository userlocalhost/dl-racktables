require 'yaml'

module DLRacktables
  class Config
    CONFIG_PATH = '/usr/local/etc/dl_racktables.yml'

    class << self
      def [](param)
        (@config_data ||= load_config)[param]
      end
  
      private
      def load_config
        unless FileTest.exists?(config_path)
          raise RuntimeError "invalid configuration file (#{config_path})"
        end
  
        YAML.load_file(config_path)
      end
  
      def config_path
        ENV['DL_RACKTABLES_CONFIG_PATH'] == nil ? CONFIG_PATH : ENV['DL_RACKTABLES_CONFIG_PATH']
      end
    end
  end
end
