class MemberSearchFacade
  def initialize(state)
    @state = state
  end

  def member_count
    members.count
  end

  def members
    # make the API call to Propublica
    conn = Faraday.new(url: "https://api.propublica.org") do |f|
      f.headers['X-API-Key'] = ENV['PROPUBLICA_API_KEY']
      f.adapter  Faraday.default_adapter
    end

    response = conn.get("/congress/v1/members/house/#{state}/current.json")

    # parse the response
    search_result = JSON.parse(response.body, symbolize_names: true)

    # build Member objects
    search_result[:results].map do |result|
      Member.new(result)
    end
  end

  private
  attr_reader :state
end
