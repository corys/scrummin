# Scrummin

TODO: Write a gem description

## Installation

### Dependencies

* [Ruby 2.0](http://www.ruby-lang.org/)
* [Bundler](http://gembundler.com/)

In the project directory, run

    $ bundle install
    $ rake install

This will add an executable to your path called *scrummin*

## Usage

Run the command, passing the names of the participants

    $ scrummin bob sue sally jim joan

The meeting will start, and a list of commands will be printed

    starting meeting with: bob, jim, joan, sally, sue
    commands: (n)ext (q)uit
    >

Use the *next* command to print the name of the next participant in line.
Continue using this command when that participant has finished, to move on to
the next participant.

    > n
    bob
    > n
    joan
    > n
    sally
    > n
    jim
    > n
    sue
    > n
    done

When the meeting is finished, the time each participant spent will be displayed

    bob: 48.39093s
    joan: 142.655843s
    sally: 211.0003s
    jim: 172.519837s
    sue: 93.095637s

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
