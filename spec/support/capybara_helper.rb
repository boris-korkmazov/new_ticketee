module CapybaraHelper
  def assert_no_link_for(text)
    expect(page).to_not(have_css("a", :text => text), "Expected not to see the #{text.inspect} link, but did.")
  end

  def assert_link_for(text)
    expect(page).to(have_css("a", :text => text), "Expected to see the #{text} link, but did not.") 
  end

  def state_line_for(state)
    state = State.find_by_name!(state)
    "#state_#{state.id}"
  end
end


RSpec.configure do |c|
  c.include CapybaraHelper, :type => :feature
end

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.javascript_driver = :chrome
