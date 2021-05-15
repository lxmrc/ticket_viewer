module TicketViewer
  Ticket = Struct.new(:id, :subject, :description, :requester_id, :created_at, keyword_init: true)
end
