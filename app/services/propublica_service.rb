class PropublicaService
  def members_by_state(state)
    get_json("/congress/v1/members/house/#{state}/current.json")
  end

  private

  def conn
    Faraday.new(url: "https://api.propublica.org") do |f|
      f.headers['X-API-Key'] = ENV['PROPUBLICA_API_KEY']
      f.adapter  Faraday.default_adapter
    end
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
