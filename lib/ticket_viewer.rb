# frozen_string_literal: true

require_relative "ticket_viewer/cli"
require_relative "ticket_viewer/client"
require_relative "ticket_viewer/parser"
require_relative "ticket_viewer/ticket"
require_relative "ticket_viewer/version"

module TicketViewer
  class Error < StandardError; end
end
