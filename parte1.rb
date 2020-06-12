class HousingMarketController < ApplicationController
  layout "v4/react"

  API_DEMO_URL = "https://hl-api-demo.herokuapp.com/api/area-data-service".freeze
  API_ENDPOINTS = {
    median_price: "#{API_DEMO_URL}/median-price",
    median_price_last_year: "#{API_DEMO_URL}/median-price-last-year",
    list_to_sell_ratio: "#{API_DEMO_URL}/list-to-sell-ratio",
    days_on_market: "#{API_DEMO_URL}/days-on-market",
    months_of_inventory: "#{API_DEMO_URL}/months-of-inventory",
  }.freeze

  PROPERTY_TYPES = [
    { param: "co_op", name: "Co Op" },
    { param: "condominium", name: "Condominium" },
    { param: "mobile_manufactured_home", name: "Mobile Manufactured Home" },
    { param: "multi_family", name: "Multi Family" },
    { param: "other", name: "Other" },
    { param: "single_family_home", name: "Single Family Home" },
    { param: "tenancy_in_common", name: "Tenancy in Common" },
    { param: "townhomes", name: "Townhomes" },
    { param: "", name: "All" }
  ].freeze

  def city
    @area = City.find_by(slug: params[:area_slug])
    error_404 and return unless city_pases_guardrails?

    @state = @area.state
    dynamic_date
    perform_requests("city")

    @implicit_base_css = true
    @full_viewport_scale = true
  end

  def state
    @implicit_base_css = true
    @full_viewport_scale = true

    @jump_links = [{ linkText: "Seattle Market Overview", selector: "" }]
    @jump_links << { linkText: "Top Agent Insights", selector: "" }
    @jump_links << { linkText: "Additional Resources", selector: "" }
    @jump_links << { linkText: "Nearby Markets", selector: "" }
  end

  def national
    @implicit_base_css = true
  end

  private

  def perform_requests area_type
    median_price_requests(area_type)
    days_on_market_requests(area_type)
    months_inventory_requests(area_type)
    list_to_sale_requests(area_type)
  end

  def median_price_requests area_type
    @median_price_datasets = Rails.cache.fetch("#{@area.slug}/median-price", expires_in: 1.week) do
      PROPERTY_TYPES.map do |property_type|
        response = RestClient.get(API_ENDPOINTS.median_price,
                                  params: { "filter[area_id]" => @area.id,
                                            "filter[area_type]" => area_type,
                                            "filter[property_type]" => property_type.param })

        response_body = response_guardrails(response.body)
        { name: property_type.name, data: response_body }
      end
    end

    @median_price_yearly = Rails.cache.fetch("#{@area.slug}/median-price-yearly", expires_in: 1.week) do
      response = RestClient.get(API_ENDPOINTS.median_price,
                                params: { "filter[area_id]" => @area.id,
                                          "filter[area_type]" => area_type,
                                          "filter[range]" => "year" })

      response_body = response_guardrails(response.body)
      [{ name: "All", data: response_body }]
