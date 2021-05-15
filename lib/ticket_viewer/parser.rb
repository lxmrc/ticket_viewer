module TicketViewer
  class Parser
    class << self
      def parse_ticket(json)
        hash = parse_json(json)[:ticket]
        hash = hash.slice(:id, :subject, :description, :requester_id, :created_at)
        Ticket.new(hash)
      end

      private

      def parse_json(json)
        JSON.parse(json, symbolize_names: true)
      end
    end
  end
end
