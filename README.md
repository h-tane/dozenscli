# dozens-cli

Command Line Interface for Dozens.

This package provides a command line interface to Dozens REST API.

## Installation

Add this line to your application's Gemfile:

    gem 'dozenscli'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dozenscli

## Getting Started

Before using dozens-cli, you need to tell it about your credentials.

Create a configuration file like this:

    [profile]
    dozens_id = <dozens_id>
    api_key = <api_key>

and place it in ~/.dozenscli.conf

## Synopsis

    $ dozens <command> <subcommand> [parameters]

Use command help for information on a specific command.

    $ dozens help

    Commands:
      dozens create TYPE     # Create resource. Type can be zone, record
      dozens delete TYPE     # Delete resource. Type can be zone, record
      dozens help [COMMAND]  # Describe available commands or one specific command
      dozens list TYPE       # List resource. Type can be zone, record
      dozens update TYPE     # Update resource. Type can be record

Operation of a record requires JSON data structures as input parameters on the command line.

    // Example
    $ dozens create record --params '{"domain":"dozens.jp","name":"www","type":"A","prio":10,"content":"192.168.0.1","ttl":"7200"}'
