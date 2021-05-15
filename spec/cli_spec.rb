require "spec_helper"

RSpec.describe "CLI commands" do
  it "help prints out a list of commands" do
    expect(run_command("ticket_viewer help")).to have_output(/ticket_viewer help/)
  end
end
