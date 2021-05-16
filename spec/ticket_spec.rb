require "spec_helper"
require "time"

RSpec.describe TicketViewer::Ticket do
  subject(:ticket) {
    described_class.new(id: 1,
                        subject: "Example Ticket",
                        description: "This is an example ticket.",
                        requester_id: 12345,
                        created_at: "2021-05-03T22:00:32Z")
  }

  it "has an ID" do
    expect(ticket.id).to eq(1)
  end

  it "has a subject" do
    expect(ticket.subject).to eq("Example Ticket")
  end

  it "has a description" do
    expect(ticket.description).to eq("This is an example ticket.")
  end

  it "has a requester_id" do
    expect(ticket.requester_id).to eq(12345)
  end

  it "has a created_at" do
    expect(ticket.created_at).to eq("Monday May 3 at 10:00 PM")
  end
end
