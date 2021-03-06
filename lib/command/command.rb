module Command
  def self.included(cls)
    cls.extend Build unless cls.ancestors.include? Build
    cls.extend ClassExecutor unless cls.ancestors.include? ClassExecutor
    cls.extend InstanceExecutor unless cls.ancestors.include? Build

    cls.send :dependency, :logger, Telemetry::Logger
  end

  module Build
    def build(params=nil)
      params ||= {}

      logger = Telemetry::Logger.get self
      logger.trace "Building"

      new.tap do |instance|
        Telemetry::Logger.configure instance

        subclass.configure_dependencies(instance)

        SetAttributes.! instance, params

        logger.debug "Built"
      end
    end

    def configure_dependencies(instance)
    end

    def subclass
      self
    end
  end

  module ClassExecutor
    def !(params={})
      instance = build(params)
      instance.!
    end
  end

  module InstanceExecutor
    def self.extended(obj)
      obj.send :undef_method, :!
    end
  end
end
