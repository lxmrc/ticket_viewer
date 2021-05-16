module TicketViewer
  class Parser
    class << self
      def parse_ticket(json)
        ticket_hash = parse_json(json)[:ticket]
        ticket_hash = ticket_hash.slice(:id, :subject, :description, :requester_id, :created_at)
        Ticket.new(**ticket_hash)
      end

      def parse_page(json)
        ticket_hashes = parse_json(json)[:tickets]
        ticket_hashes.map do |ticket_hash|
          ticket_hash = ticket_hash.slice(:id, :subject, :description, :requester_id, :created_at)
          Ticket.new(**ticket_hash)
        end
      end

      private

      def parse_json(json)
        JSON.parse(json, symbolize_names: true)
      end
    end
  end
end
