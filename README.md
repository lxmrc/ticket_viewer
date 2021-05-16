# Ticket Viewer

Ticket viewer CLI for the Zendesk coding challenge. The requirements were to build a Ticket Viewer that will:

 - Connect to the Zendesk API
 - Request all the tickets for the account
 - Display them in a list
 - Display individual ticket details
 - Page through tickets when more than 25 are returned
 - Handle the API being unavailable
 - Handle basic errors

## Installation

Clone this repo:

```
git clone https://github.com/lxmrc/ticket_viewer
```

Navigate into the directory and run `bundle install`:

```
cd ticket_viewer
bundle install
```

## Usage

Run `bundle exec ticket_viewer [command]` from within the directory.

1. Setup authentication by running `bundle exec ticket_viewer auth`.
2. View a list of the current tickets with `bundle exec ticket_viewer tickets`.
3. Use the interactive prompt to navigate between pages. Alternatively, view a specific page with `bundle exec ticket_viewer tickets PAGE_NUMBER`.
4. Use the interactive prompt to view a specific ticket. Alternatively, view a specific ticket with `bundle exec ticket_viewer view TICKET_ID`.
