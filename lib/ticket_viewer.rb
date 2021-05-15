# frozen_string_literal: true

require_relative "ticket_viewer/version"
require_relative "ticket_viewer/ticket"
require_relative "ticket_viewer/client"
require_relative "ticket_viewer/cli"

module TicketViewer
  class Error < StandardError; end
end
