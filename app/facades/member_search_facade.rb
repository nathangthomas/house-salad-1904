class MemberSearchFacade
  def initialize(state)
    @state = state
  end

  def member_count
    members.count
  end

  def members
    member_search[:results].map do |profile|
      Member.new(profile)
    end
  end

  def copyright
    member_search[:copyright]
  end

  private
  attr_reader :state

  def member_search
    @_member_search ||= service.members_by_state(state)
  end

  def service
    @_service ||= PropublicaService.new
  end
end
