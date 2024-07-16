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

  def self.create_shipment data
    url = "#{ENV['DELIVERY_BASE_URL']}/api/cmu/create.json"
    begin
      response = HTTParty.post(url, 
        headers: {
          'Content-Type' => 'application/json',
          'Authorization' => "Token #{ENV['DELIVERY_API_KEY']}"
        },
        body: {
          format: 'json',
          data: data.to_json
        }
      )
      data = response.parsed_response
    rescue
      return nil
    end

  end

  def self.get_delivery_cost dest_pin, weight
    url = "#{ENV['DELIVERY_BASE_URL']}/api/kinko/v1/invoice/charges/.json?md=S&ss=Delivered&o_pin=#{PIN}&d_pin=#{dest_pin}&cgm=#{weight}"
    begin
      response = HTTParty.get(url, headers: {
        'Content-Type' => 'application/json',
        'Authorization' => "Token #{ENV['DELIVERY_API_KEY']}"
      })
      data = response.parsed_response
      if data.present? && data[0].present? && data[0]["total_amount"].present?
        return data[0]["total_amount"]
      else
        return 0
      end
    rescue => e
      puts e
      return 0
    end
  end
end