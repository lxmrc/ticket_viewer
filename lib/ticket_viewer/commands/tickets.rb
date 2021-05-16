module TicketViewer
  class CLI < Thor
    desc "tickets [PAGE]", "Display a page of tickets"
    def tickets(page_number=1)
      data = client.get_tickets(page_number)
      tickets = TicketViewer::Parser.parse_page(data)
      tickets.each do |ticket|
        puts "#{ticket.id}: #{ticket.subject}"
      end
    end
  end
end
