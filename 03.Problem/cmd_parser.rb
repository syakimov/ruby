# frozen_string_literal: true
class CommandParser
  def initialize(bin_command)
    @bin_command = bin_command
    @known_arguments = {}
    @known_options = []
    @helper = Helper.new
  end

  def argument(argument_name, &block)
    @known_arguments[argument_name] = block
  end

  def option(short_handle, long_handle, description)
    @known_options << {
      short_handle: short_handle,
      long_handle: long_handle,
      description: description
    }
  end

  def option_with_parameter(short, long, description, argument_name, &block)
    @known_options << {
      short_handle: short,
      long_handle: long,
      description: description,
      argument_name: argument_name,
      block: block
    }
  end

  def parse(command_runner, argv)
    @argv = argv
    parse_arguments command_runner
    parse_options command_runner
  end

  def help
    [
      @helper.create_header(@known_arguments, @bin_command),
      @helper.create_body(@known_options)
    ].join("\n")
  end

  private

  def parse_arguments(command_runner)
    @known_arguments
      .zip(@helper.extract_arguments(@argv)) do |argument, value|
        argument[1].call(command_runner, value)
      end

    command_runner
  end

  def parse_options(command_runner)
    @helper.extract_options(@argv).each do |argument_value_option|
      @known_options.each do |known_option|
        option, value = @helper.split_input(argument_value_option)
        @helper.add_option(command_runner, known_option, option, value)
      end
    end

    command_runner
  end
end

class Helper
  def create_header(known_arguments, bin_command)
    arguments_help = known_arguments.keys.map { |key| "[#{key}]" }.join(' ')
    "Usage: #{bin_command} #{arguments_help}"
  end

  def create_body(known_options)
    known_options.map do |known_option|
      s = "    -#{known_option[:short_handle]}, --#{known_option[:long_handle]}"
      s += "=#{known_option[:argument_name]}" if known_option[:argument_name]
      s + ' ' + known_option[:description]
    end.join("\n")
  end

  def split_input(argument_value_option)
    argument_value_option.chomp('-').reverse.chomp('-').reverse.split('=')
  end

  def extract_arguments(argv)
    argv.select { |argument| !option?(argument) }
  end

  def extract_options(argv)
    argv.select { |argument| option?(argument) }
  end

  def option?(argument_value)
    argument_value.start_with?('-', '--')
  end

  def add_option(command_runner, known_option, option, value)
    return unless option == known_option[:short_handle] ||
                  known_option[:long_handle]

    if known_option[:argument_name]
      known_option[:block].call(command_runner, value)
    else
      command_runner[known_option[:long_handle].to_sym] = true
    end
  end
end
