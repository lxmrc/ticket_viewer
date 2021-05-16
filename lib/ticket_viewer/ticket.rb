module TicketViewer
  class Ticket
    attr_reader :id, :subject, :description, :requester_id, :created_at

    def initialize(id:, subject:, description:, requester_id:, created_at:)
      @id = id
      @subject = subject
      @description = description
      @requester_id = requester_id
      @created_at = DateTime.strptime(created_at).strftime("%A %B %-e at %I:%M %p")
    end
  end
end
