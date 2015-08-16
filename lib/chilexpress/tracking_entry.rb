module Chilexpress
  class TrackingEntry
    attr_reader :date, :time, :activity

    def initialize(attributes)
      @date = attributes[:date]
      @time = attributes[:time]
      @activity = attributes[:activity]
    end
  end
end
