module TicketViewer
  class CLI < Thor
    desc "auth", "Configure Zendesk API credentials"
    def auth
      netrc = Netrc.read
      netrc["lxmrc.zendesk.com"] = [prompt_username, prompt_password]
      netrc.save
      puts "\nLogin saved."
    end

    private

    def prompt_username
      ask("Username:")
    end

    def prompt_password
      ask("Password:", echo: false)
    end
  end
end
