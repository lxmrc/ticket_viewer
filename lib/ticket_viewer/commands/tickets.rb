require "tty-table"

module TicketViewer
  class CLI < Thor
    desc "tickets [PAGE]", "Display a page of tickets"
    def tickets(page_number = 1)
      data = fetch_page_data(page_number)
      tickets = parse_page_data(data)
      print_tickets(tickets)
    end

    private

    def fetch_page_data(page_number)
      client.get_tickets(page_number)
    end

    def parse_page_data(data)
      TicketViewer::Parser.parse_page(data)
    end

    def print_tickets(tickets)
      rows = extract_rows(tickets)
      puts TTY::Table.new(header: ["ID", "Subject", "Requester ID", "Created at"], rows: rows)
        .render(:unicode) { |r| r.border.separator = :each_row }
    end

    def extract_rows(tickets)
      tickets.map do |ticket|
        [ticket.id, ticket.subject, ticket.requester_id, ticket.created_at]
      end
    end
  end
end
