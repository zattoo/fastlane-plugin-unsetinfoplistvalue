require 'fastlane/action'
require_relative '../helper/unsetinfoplistvalue_helper'

module Fastlane
  module Actions
    class UnsetinfoplistvalueAction < Action
      def self.run(params)
        require 'plist'

        begin
          path = File.expand_path(params[:path])
          plist = Plist.parse_xml(path)

          plist.delete(params[:key])

          new_plist = Plist::Emit.dump(plist)
          File.write(path, new_plist)
        rescue StandardError => ex
          UI.error(ex)
          UI.user_error!("Unable to unset key '#{params[:key]}' the plist file at '#{path}'")
        end
      end

      def self.description
        "Unsets value to Info.plist of your project as native Ruby data structures"
      end

      def self.authors
        ["Zattoo"]
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :key,
                                       env_name: 'FL_SET_INFO_PLIST_PARAM_NAME',
                                       description: 'Name of key in plist',
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :path,
                                       env_name: 'FL_SET_INFO_PLIST_PATH',
                                       description: 'Path to plist file you want to update',
                                       optional: false,
                                       verify_block: proc do |value|
                                         UI.user_error!("Couldn't find plist file at path '#{value}'") unless File.exist?(value)
                                       end)
        ]
      end

      def self.is_supported?(platform)
        %i[ios appletvos mac].include?(platform)
      end

      def self.example_code
        [
          'unset_info_plist_value(path: "./Info.plist", key: "CFBundleIdentifier")'
        ]
      end

      def self.category
        :project
      end
    end
  end
end
