require "spec_helper"

RSpec.describe "CLI commands" do
  it "'help' prints out a list of commands" do
    expect(run_command("ticket_viewer help")).to have_output(/ticket_viewer help/)
  end

  xit "'auth' stores the user's login details" do
    run_command("ticket_viewer auth")
    type "user@example.com"
    type "password123" # this breaks because of the 'noecho' prompt
    expect(last_command_started).to have_output(/Login saved./)
  end
end
