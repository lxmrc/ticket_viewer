require "spec_helper"

RSpec.describe TicketViewer::Parser do
  subject(:parser) { described_class }

  let(:page_json) { File.open("./spec/fixtures/page_1.json").read }
  let(:ticket_json) { File.open("./spec/fixtures/ticket.json").read }

  it "parses one ticket" do
    ticket = parser.parse_ticket(ticket_json)
    expect(ticket.id).to eq(1)
    expect(ticket.subject).to eq("velit eiusmod reprehenderit officia cupidatat")
    expect(ticket.description).to match("Aute ex sunt culpa ex ea esse sint cupidatat")
    expect(ticket.requester_id).to eq(902093905946)
  end

  it "parses a page of tickets" do
    page = parser.parse_page(page_json)
    expect(page.size).to eq(25)
    expect(page.first.id).to eq(209)
    expect(page.first.subject).to eq("velit eiusmod reprehenderit officia cupidatat")
    expect(page.first.description).to match("Aute ex sunt culpa ex ea esse sint cupidatat")
    expect(page.first.requester_id).to eq(902093905946)
  end
end
