require "thor"
require "netrc"

require_relative "./commands/auth"
require_relative "./commands/view"
require_relative "./commands/tickets"

module TicketViewer
  class CLI < Thor
    private

    def client
      check_auth
      @client ||= TicketViewer::Client.new(read_auth)
    end

    def check_auth
      abort "No login found. Run 'ticket_viewer auth' to setup login details." if Netrc.read["lxmrc.zendesk.com"].nil?
    end

    def read_auth
      auth = Netrc.read["lxmrc.zendesk.com"].to_h
      auth[:username] = auth.delete(:login)
      auth
    end
  end
end
