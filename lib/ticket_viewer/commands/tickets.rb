require "tty-table"

module TicketViewer
  class CLI < Thor
    desc "tickets [PAGE]", "Display a page of tickets"
    def tickets(page_number=1)
      data = client.get_tickets(page_number)
      tickets = TicketViewer::Parser.parse_page(data)
      print_tickets(tickets)
    end

    private

    def print_tickets(tickets)
      rows = extract_rows(tickets)
      puts TTY::Table.new(header: ["ID", "Subject", "Requester ID", "Created at"], rows: rows).
        render(:unicode) { |r| r.border.separator = :each_row }
    end

    def extract_rows(tickets)
      tickets.map do |ticket|
        [ticket.id, ticket.subject, ticket.requester_id, ticket.created_at]
      end
    end
  end
end
