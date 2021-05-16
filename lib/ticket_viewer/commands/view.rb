module TicketViewer
  class CLI < Thor
    desc "view TICKET_ID", "View ticket details"
    def view(id)
      data = client.get_ticket(id)
      ticket = TicketViewer::Parser.parse_ticket(data)
      puts "#{ticket.subject}"
      puts "#{ticket.description}"
    end
  end
end
