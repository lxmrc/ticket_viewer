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
      setup_client
      ticket = get_ticket(id)
      puts "#{ticket.subject}"
      puts "#{ticket.description}"
    end

    private

    def prompt_username
      ask("Username:")
    end

    def prompt_password
      ask("Password:", echo: false)
    end

    def check_auth
      abort "No login found. Run 'ticket_viewer auth' to setup login details." if Netrc.read["lxmrc.zendesk.com"].nil?
    end

    def read_auth
      auth = Netrc.read["lxmrc.zendesk.com"].to_h
      auth[:username] = auth.delete(:login)
      auth
    end

    def setup_client
      check_auth
      @client ||= TicketViewer::Client.new(read_auth)
    end

    def get_ticket(id)
      data = @client.get_ticket(id)
      ticket = TicketViewer::Parser.parse_ticket(data)
    end
  end
end
