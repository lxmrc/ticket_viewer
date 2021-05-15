# frozen_string_literal: true

require_relative "lib/ticket_viewer/version"

Gem::Specification.new do |spec|
  spec.name          = "ticket_viewer"
  spec.license       = "MIT"
  spec.version       = TicketViewer::VERSION
  spec.authors       = ["Alex Mercea"]
  spec.email         = ["alex@lxmrc.com"]

  spec.summary       = "Ticket viewer for Zendesk coding challenge."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "pry", "~> 0.14.1"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "guard-rspec", "~> 4.7.3"
  spec.add_development_dependency "standard", "~> 1.1.1"
  spec.add_development_dependency "webmock", "~> 3.12.2"
  spec.add_development_dependency "super_diff", "~> 0.8.0"
  spec.add_development_dependency "aruba", "~> 1.1.0"

  spec.add_dependency "thor", "~> 1.0"
  spec.add_dependency "httparty", "~> 0.18.1"
  spec.add_dependency "netrc", "~> 0.11.0"
end
