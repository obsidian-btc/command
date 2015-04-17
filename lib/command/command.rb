module Command
  def self.included(cls)
    cls.extend InstanceExecutor
    cls.extend Build unless cls.ancestors.include? Build
    cls.extend ClassExecutor unless cls.ancestors.include? ClassExecutor

    cls.send :dependency, :logger, Logger
  end

  module Build
    def build(params=nil)
      params ||= {}

      logger = Logger.get self
      logger.trace "Building"

      new.tap do |instance|
        Logger.configure instance

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
