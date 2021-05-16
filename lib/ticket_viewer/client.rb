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
      self.class.get(path, basic_auth: @auth).body
    end
  end
end
