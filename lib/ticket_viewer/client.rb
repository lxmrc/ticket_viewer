require "httparty"

module TicketViewer
  class Client
    include HTTParty
    base_uri "https://lxmrc.zendesk.com/api/v2"

    def initialize(auth)
      @auth = auth
    end

    def get_tickets(page_number)
      get_data("/tickets.json?page=#{page_number}&per_page=25")
    end

    def get_ticket(ticket_id)
      get_data("/tickets/#{ticket_id}")
    end

    private

    def get_data(path)
      response = self.class.get(path, basic_auth: @auth)
      response.success? ? response.body : raise(TicketViewer::Error, error_message(response.code))
    end

    def error_message(code)
      case code
      when 401
        "Couldn't authenticate you. Run `ticket_viewer auth` to configure your login details and try again."
      when 404
        "No ticket with that ID."
      else
        "An unknown error occurred."
      end
    end
  end
end
