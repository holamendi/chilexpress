module Chilexpress
  class Shipment
    attr_reader :order_number, :product_type, :service_type, :status, :receiver, :tracking_entries

    def initialize(attributes)
      @order_number = attributes[:order_number]
      @product_type = attributes[:product_type]
      @service_type = attributes[:service_type]
      @status = attributes[:status]
      @receiver = attributes[:receiver]
      @tracking_entries = attributes[:tracking_entries] || []
    end
  end
end
