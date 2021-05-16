require "tty-pager"

module TicketViewer
  class CLI < Thor
    desc "view TICKET_ID", "View ticket details"
    def view(ticket_id)
      data = fetch_ticket_data(ticket_id)
      ticket = parse_ticket_data(data)
      print_ticket(ticket)
      view_prompt
    end

    private

    def fetch_ticket_data(ticket_id)
      client.get_ticket(ticket_id)
    end

    def parse_ticket_data(data)
      TicketViewer::Parser.parse_ticket(data)
    end

    def print_ticket(ticket)
      output = <<~OUTPUT
        #{bold(ticket.subject)}
        #{ticket.created_at}
        #{"-" * 80}
        #{ticket.description}
        #{"-" * 80}

      OUTPUT
      pager = TTY::Pager::BasicPager.new(width: 80)

      system "clear"
      pager.page(output)
    end

    def bold(text)
      "\e[1m#{text}\e[22m"
    end

    def view_prompt
      TTY::Prompt.new.select("Navigate:") do |menu|
        menu.choice "Back to tickets", -> { tickets(@current_page || 1) }
        menu.choice "Exit"
      end
    end
  end
end
