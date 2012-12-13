module Stampable
  module Base
    def self.config= config
      @config = self.config.merge(config)
    end

    def self.config
      @config || {:stamp_field => :modified_by, :except_user_list => ['background_job']}
    end

    def self.included(klass)
      klass.send :before_save, :set_modified_by
    end

    def set_modified_by
      return unless changed?
      user_name = Thread.current['current_user'] || Stampable::Base.config[:default_user]
      return if Stampable::Base.config[:except_user_list].include?(user_name)
      stamp_writer = (Stampable::Base.config[:stamp_field].to_s + '=').to_sym
      send(stamp_writer, user_name) if respond_to?(stamp_writer)
    end
  end
end
