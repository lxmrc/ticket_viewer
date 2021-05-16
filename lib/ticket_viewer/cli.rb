require "thor"

require_relative "./commands/auth"
require_relative "./commands/view"
require_relative "./commands/tickets"

module TicketViewer
  class CLI < Thor

    private

    def client
      abort "No login found. Run 'ticket_viewer auth' to setup login details." if Netrc.read["lxmrc.zendesk.com"].nil?
      @client ||= TicketViewer::Client.new(read_auth)
    end
  end
end
