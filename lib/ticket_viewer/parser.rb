module TicketViewer
  class Parser
    class << self
      def parse_ticket(data)
        ticket_hash = parse_json(data)[:ticket]
        create_ticket(ticket_hash)
      end

      def parse_page(data)
        ticket_hashes = parse_json(data)[:tickets]
        ticket_hashes.map { |ticket_hash| create_ticket(ticket_hash) }
      end

      def calculate_total_pages(data)
        parse_json(data)[:count] / 25
      end

      private

      def parse_json(data)
        JSON.parse(data, symbolize_names: true)
      end

      def create_ticket(ticket_hash)
        ticket_hash = ticket_hash.slice(:id, :subject, :description, :requester_id, :created_at)
        Ticket.new(**ticket_hash)
      end
    end
  end
end
