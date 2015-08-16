module Chilexpress
  class Receiver
    attr_reader :rut, :name, :delivery_date, :delivery_time

    def initialize(attributes)
      @rut = attributes[:rut]
      @name = attributes[:name]
      @delivery_date = attributes[:delivery_date]
      @delivery_time = attributes[:delivery_time]
    end
  end
end
