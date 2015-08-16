require 'chilexpress/version'
require 'chilexpress/shipment'
require 'chilexpress/receiver'
require 'chilexpress/tracking_entry'

require 'nokogiri'
require 'open-uri'

module Chilexpress
  def self.get_order(order_number)
    document = get_document(order_number)
    return false unless document_has_valid_order?(document)
    shipment_attributes = get_shipment_info_from_document(document)
    shipment_attributes[:tracking_entries] = get_tracking_entries_from_document(document)
    shipment_attributes[:receiver] = get_receiver_from_document(document)
    Chilexpress::Shipment.new(shipment_attributes)
  end

  def self.get_document(order_number)
    Nokogiri::HTML(open("http://www.chilexpress.cl/Views/ChilexpressCL/Resultado-busqueda.aspx?DATA=#{order_number}"))
  end

  def self.document_has_valid_order?(document)
    document.css('header.widget-header h3').any?
  end

  def self.get_shipment_info_from_document(document)
    div = document.css('div.wigdet-content').select{ |div| div.text.include?('Orden Nº') }[0]
    shipment_info = div.css('ul li ul li')
    { order_number: shipment_info[0].children[1].text,
      product_type: shipment_info[1].children[1].text,
      service_type: shipment_info[2].children[1].text,
      status: shipment_info[3].children[1].text }
  end

  def self.get_receiver_from_document(document)
    div = document.css('div.wigdet-content').select{ |div| div.text.include?('Datos de Descarga') }[0]
    return nil unless div
    receiver_info = div.css('ul li ul li')
    receiver_attributes = {}

    rut_index = receiver_info.to_a.each_index.select{ |i| receiver_info[i].children[0].text == 'Rut Receptor:' }[0]
    name_index = receiver_info.to_a.each_index.select{ |i| receiver_info[i].children[0].text == 'Nombre Receptor:' }[0]
    delivery_date_index = receiver_info.to_a.each_index.select{ |i| receiver_info[i].children[0].text == 'Fecha Entrega:' }[0]
    delivery_time_index = receiver_info.to_a.each_index.select{ |i| receiver_info[i].children[0].text == 'Hora Entrega:' }[0]

    receiver_attributes[:rut] = receiver_info[rut_index].children[1].text.strip[1..-1] if rut_index
    receiver_attributes[:name] = receiver_info[name_index].children[1].text.strip[1..-1] if name_index
    receiver_attributes[:delivery_date] = receiver_info[delivery_date_index].children[1].text.strip[1..-1] if delivery_date_index
    receiver_attributes[:delivery_time] = receiver_info[delivery_time_index].children[1].text.strip[1..-1] if delivery_time_index

    Chilexpress::Receiver.new(receiver_attributes)
  end

  def self.get_tracking_entries_from_document(document)
    document_entries = document.css('table.addresses tbody tr')
    tracking_entries = []
    document_entries.each do |entry|
      content = entry.css('td')
      tracking_entries << Chilexpress::TrackingEntry.new(date: content[0].text, time: content[1].text, activity: content[2].text)
    end
    tracking_entries
  end
end
