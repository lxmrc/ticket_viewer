require "tty-table"
require "tty-prompt"

module TicketViewer
  class CLI < Thor
    desc "tickets [PAGE]", "Display a page of tickets"
    def tickets(page_number = 1)
      page_number = 1 if page_number.nil?
      data = fetch_page_data(page_number)
      tickets = parse_page_data(data)

      @current_page = page_number.to_i
      @total_pages = calculate_total_pages(data)

      print_tickets(tickets)
      tickets_prompt
    end

    private

    def fetch_page_data(page_number)
      client.get_tickets(page_number)
    end

    def calculate_total_pages(data)
      TicketViewer::Parser.calculate_total_pages(data)
    end

    def parse_page_data(data)
      TicketViewer::Parser.parse_page(data)
    end

    def print_tickets(tickets)
      system "clear"
      puts TTY::Table.new(header: ["ID", "Subject", "Requester ID", "Created at"], rows: extract_rows(tickets))
        .render(:unicode) { |r| r.border.separator = :each_row }
    end

    def extract_rows(tickets)
      tickets.map do |ticket|
        [ticket.id, ticket.subject, ticket.requester_id, ticket.created_at]
      end
    end

    def tickets_prompt
      TTY::Prompt.new.select("Page #{@current_page} of #{@total_pages}. Navigate:") do |menu|
        menu.choice "Next page", -> { next_page } if @current_page < @total_pages
        menu.choice "Previous page", -> { prev_page } if @current_page > 1
        menu.choice "View ticket", -> { view_ticket }
        menu.choice "Exit"
      end
    end

    def next_page
      tickets(@current_page + 1)
    end

    def prev_page
      tickets(@current_page - 1)
    end

    def view_ticket
      id = TTY::Prompt.new.ask("Ticket ID:")
      view(id)
    end
  end
end
