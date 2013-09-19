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

    Starting meeting with: Bob, Jim, Joan, Sally, Sue, group
    commands: (a)dd (n)ext (q)uit
    >

Use the *next* command to print the name of the next participant in line.
Continue using this command when that participant has finished, to move on to
the next participant. You can also *add* a new participant, or choose to *quit*
scrummin.

    > n
    Sally
    > n
    Sue
    > n
    Joan
    > n
    Bob
    > n
    Jim
    > n
    group
    > n
    done

When the meeting is finished, the scrummin scores are displayed.

    --------------
    Total meeting duration: 65.405435s
    Winning target: 10.900905833333333s
    --------------
    1: Joan, 10.559687s
    2: Bob, 10.335574s
    3: Sue, 9.551485s
    4: Jim, 9.143617s
    5: Sally, 8.655769s
    6: group, 17.159303s

### Campfire

Scrummin now posts information about meetings to Campfire. RDI's campfire
location is http://resdat.campfirenow.com and the room name is *Scrummin*.

For development, you probably don't want to post Campfire notifications while
testing the tool. You can disable Campfire notifications with the
`--no-campfire` option:

    scrummin --no-campfire sally, jim, bob, joan, sue

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## TODO

* Go "back" in a meeting, after "next." Sometimes a participant's turn starts,
  but a question is raised for the previous participant. That time is currently
  tracked to the wrong person.
* End meeting stats. Total time, longest, shortest, etc.
