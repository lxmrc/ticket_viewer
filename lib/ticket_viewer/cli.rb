require "thor"
require "netrc"

module TicketViewer
  class CLI < Thor
    desc "auth", "Configure Zendesk API credentials"
    def auth
      netrc = Netrc.read
      netrc["lxmrc.zendesk.com"] = [prompt_username, prompt_password]
      netrc.save
      puts "\nLogin saved."
    end

    desc "view TICKET_ID", "View ticket details"
    def view(id)
      data = client.get_ticket(id)
      ticket = TicketViewer::Parser.parse_ticket(data)
      puts "#{ticket.subject}"
      puts "#{ticket.description}"
    end

    desc "tickets [PAGE]", "Display a page of tickets"
    def tickets(page_number=1)
      data = client.get_tickets(page_number)
      tickets = TicketViewer::Parser.parse_page(data)
      tickets.each do |ticket|
        puts "#{ticket.id}: #{ticket.subject}"
      end
    end

    private

    def prompt_username
      ask("Username:")
    end

    def prompt_password
      ask("Password:", echo: false)
    end

    def read_auth
      auth = Netrc.read["lxmrc.zendesk.com"].to_h
      auth[:username] = auth.delete(:login)
      auth
    end

    def client
      abort "No login found. Run 'ticket_viewer auth' to setup login details." if Netrc.read["lxmrc.zendesk.com"].nil?
      @client ||= TicketViewer::Client.new(read_auth)
    end
  end
end
