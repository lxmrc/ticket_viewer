require "tty-pager"

module TicketViewer
  class CLI < Thor
    desc "view TICKET_ID", "View ticket details"
    def view(id)
      data = client.get_ticket(id)
      ticket = TicketViewer::Parser.parse_ticket(data)
      print_ticket(ticket)
    end

    private

    def print_ticket(ticket)
      output = <<~OUTPUT

        #{bold(ticket.subject)}
        #{ticket.created_at}
        #{"-" * 80}
        #{ticket.description}

      OUTPUT
      pager = TTY::Pager::BasicPager.new(width: 80)
      pager.page(output)
    end

    def bold(text)
      "\e[1m#{text}\e[22m"
    end
  end
end
