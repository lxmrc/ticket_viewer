require "spec_helper"

RSpec.describe TicketViewer::Client do
  let(:page_1_json) { File.open("./spec/fixtures/page_1.json").read }
  let(:page_2_json) { File.open("./spec/fixtures/page_2.json").read }
  let(:ticket_json) { File.open("./spec/fixtures/ticket.json").read }

  subject(:client) {
    described_class.new(
      username: "user@example.com",
      password: "password123"
    )
  }

  it "can get the first page of tickets" do
    stub_request(:get, "https://lxmrc.zendesk.com/api/v2/tickets.json?page=1&per_page=25")
      .with(basic_auth: ["user@example.com", "password123"])
      .to_return(status: 200, body: page_1_json)

    expect(client.get_tickets(1)).to eq(page_1_json)
  end

  it "can get the next page of tickets" do
    stub_request(:get, "https://lxmrc.zendesk.com/api/v2/tickets.json?page=2&per_page=25")
      .with(basic_auth: ["user@example.com", "password123"])
      .to_return(status: 200, body: page_2_json)

    expect(client.get_tickets(2)).to eq(page_2_json)
  end

  it "can get a specific ticket" do
    stub_request(:get, "https://lxmrc.zendesk.com/api/v2/tickets/1")
      .with(basic_auth: ["user@example.com", "password123"])
      .to_return(status: 200, body: ticket_json)

    expect(client.get_ticket(1)).to eq(ticket_json)
  end
end
