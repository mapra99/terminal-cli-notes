    end
  end

  def days_on_market_requests area_type
    @days_on_market_datasets = Rails.cache.fetch("#{@area.slug}/median-dom", expires_in: 1.week) do
      PROPERTY_TYPES.map do |property_type|
        response = RestClient.get(API_ENDPOINTS.days_on_market,
                                  params: { "filter[area_id]" => @area.id,
                                            "filter[area_type]" => area_type,
                                            "filter[property_type]" => property_type.param })

        response_body = response_guardrails(response.body)
        { name: property_type.name, data: response_body }
      end
    end

    @days_on_market_yearly = Rails.cache.fetch("#{@area.slug}/median-dom-yearly", expires_in: 1.week) do
      response = RestClient.get(API_ENDPOINTS.days_on_market,
                                params: { "filter[area_id]" => @area.id,
                                          "filter[area_type]" => area_type,
                                          "filter[range]" => "year" })

      response_body = response_guardrails(response.body)
      [{ name: "All", data: response_body }]
    end
  end

  def months_inventory_requests area_type
    @months_inventory_datasets = Rails.cache.fetch("#{@area.slug}/months-inventory", expires_in: 1.week) do
      PROPERTY_TYPES.map do |property_type|
        response = RestClient.get(API_ENDPOINTS.months_of_inventory,
                                  params: { "filter[area_id]" => @area.id,
                                            "filter[area_type]" => area_type,
                                            "filter[property_type]" => property_type.param })

        response_body = response_guardrails(response.body)
        { name: property_type.name, data: response_body }
      end
    end

    @months_inventory_yearly = Rails.cache.fetch("#{@area.slug}/months-inventory-yearly", expires_in: 1.week) do
      response = RestClient.get(API_ENDPOINTS.months_of_inventory,
                                params: { "filter[area_id]" => @area.id,
                                          "filter[area_type]" => area_type,
                                          "filter[range]" => "year" })

      response_body = response_guardrails(response.body)
      [{ name: "All", data: response_body }]
    end
  end

  def list_to_sale_requests area_type
    @list_to_sale_monthly = Rails.cache.fetch("#{@area.slug}/list-to-sale", expires_in: 1.week) do
      response = RestClient.get(API_ENDPOINTS.list_to_sell_ratio,
                                params: { "filter[area_id]" => @area.id,
                                          "filter[area_type]" => area_type })

      response_body = response_guardrails(response.body)
      [{ name: "All", data: response_body }]
    end
  end

  def city_pases_guardrails?
    @area.present?
  end

  def dynamic_date
    @month = Date.today.strftime("%B")
    @year = Date.today.strftime("%Y")
  end

  def response_guardrails response_body
    body = JSON.parse(response_body)
    if body.is_a? Hash
      return "[]" if body.key? "error"
    end

    response_body
  end
end
