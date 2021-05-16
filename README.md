# Ticket Viewer

Ticket viewer CLI for the Zendesk coding challenge. The requirements were to build a Ticket Viewer that will:

 - Connect to the Zendesk API
 - Request all the tickets for the account
 - Display them in a list
 - Display individual ticket details
 - Page through tickets when more than 25 are returned
 - Handle the API being unavailable
 - Handle basic errors

## Dependencies

- Ruby

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

## Design choices

### Authentication

The ticket viewer uses [Heroku's `netrc` gem](https://github.com/heroku/netrc) to store and retrieve credentials. Storing credentials in plaintext is obviously less than ideal but since it was a requirement to use basic authentication* there was no real way around this. 

*After some discussion in the Slack channel it became apparent that this might not have been intended as a hard requirement and that other applicants were using OAuth or API tokens, but at that point I decided to stick with what I already had.

### API client

Communication with the Zendesk API is encapsulated within the `Client` class which is essentially a wrapper around [HTTParty](https://github.com/jnunemaker/httparty).

An instance of `Client` is instantiated when the `view` or `tickets` commands are run. It reads and stores the login credentials in from the `.netrc` file so that they can be passed along with each HTTP request.

`Client` also handles two basic "unhappy paths": attempting to connect to the API with invalid credentials and attempting to view a non-existent ticket.

### Pagination

Initially I was fetching all of the tickets from the API at once, printing the entire list out and piping the output to `less` using [tty-pager](https://github.com/piotrmurach/tty-pager). This seemed to me like an easy way to satisfy the "Page through tickets when more than 25 are returned" requirement. 

After asking about this in the chat I realised that the Zendesk API allows you to fetch a certain amount of tickets at a time and that this was probably something I should be doing. Fetching them all at once worked fine while there were only 100 but this would be wasteful and inefficient in real life where there could be thousands.

At first I opted for cursor pagination as suggested by the documentation but this required extracting and storing the "after_cursor" and "before_cursor" values from each API response and using them to construct the URL for the next and previous pages. 

I didn't like the complexity this added to my code so I eventually changed to offset pagination instead which allowed me to simply store the current page as a number and increment or decrement as needed.

### Parser

The `Parser` class converts the JSON returned by the Zendesk API into `Ticket` objects. It also calculates how many pages of tickets there are so that this can be displayed to the user and so the CLI can avoid "overflowing" when paginating.

### Ticket

`Ticket` was initially just a struct since all I needed was a container for data. Later I decided to display timestamps in a human-readable format so I converted `Ticket` into a class that does this conversion on initialisation.

### CLI

I used [Thor](https://github.com/erikhuda/thor) to implement the basic command line functionality. I also used some of the gems from the [TTY](https://github.com/piotrmurach/tty) suite of gems to prettify my output and add interactivity, namely [tty-prompt](https://github.com/piotrmurach/tty-prompt), [tty-pager](https://github.com/piotrmurach/tty-pager) and [tty-table](https://github.com/piotrmurach/tty-table).

### Testing

[I had read that it was a best practice to stub external services in tests](https://thoughtbot.com/blog/how-to-stub-external-services-in-tests) so I used [Webmock](https://github.com/bblimke/webmock) to achieve this.

I wrote basic happy path tests for `Parser` and `Client`, and for `Client` I also wrote tests for the two unhappy paths I mentioned above. I also wrote some basic unit tests for `Ticket`.

## Useful resources

Some of the articles/blog posts/tutorials I found helpful in completing the challenge:

- [How to create a Ruby gem with Bundler](https://bundler.io/guides/creating_gem.html)
- [4 Ways to Parse a JSON API with Ruby](https://www.twilio.com/blog/2015/10/4-ways-to-parse-a-json-api-with-ruby.html)
- [How to Stub External Services in Tests](https://thoughtbot.com/blog/how-to-stub-external-services-in-tests)
- [Making a command line utility with gems and Thor](https://willschenk.com/articles/2014/making-a-command-line-utility-with-gems-and-thor/)
