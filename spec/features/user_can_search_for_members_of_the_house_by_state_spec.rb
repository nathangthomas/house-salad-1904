require "rails_helper"

feature "A user can search for members of the house by state" do
  scenario "with a valid state" do
    visit "/"
    select "Colorado", from: "state"
    click_on "Locate Members of the House"
    expect(current_path).to eq "/search"
    expect(current_url).to include "state=CO"
    # And I should see a message "7 Results"
    expect(page).to have_content("7 Results")
    expect(page).to have_css(".member", count: 7)
    # And they should be ordered by seniority from most to least
    # And I should see a name, role, party, and district for each member
    within(first(".member")) do
      expect(page).to have_css(".name")
      expect(page).to have_css(".role")
      expect(page).to have_css(".party")
      expect(page).to have_css(".district")
    end
  end
end
