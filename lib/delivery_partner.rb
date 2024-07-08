module DeliveryPartner
  PIN = 335523

  def self.serviceability dest_pin
    url = "#{ENV['DELIVERY_BASE_URL']}/c/api/pin-codes/json?filter_codes=#{dest_pin.to_i}"
    begin
      response = HTTParty.get(url, headers: {
        'Content-Type' => 'application/json',
        'Authorization' => "Token #{ENV['DELIVERY_API_KEY']}"
      })
      data = response.parsed_response
      if data.present? && data["delivery_codes"].present?
        return true
      else
        return false
      end
    rescue
      return false
    end
  end

  def self.get_delivery_cost dest_pin
    url = "#{ENV['DELIVERY_API_URL']}/api/kinko/v1/invoice/charges/.json"
  end
end