# frozen_string_literal: true
class CommandParser
  def initialize(bin_command)
    @bin_command = bin_command
    @known_arguments = {}
    @known_options = []
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

  def option_with_parameter(short_handle, long_handle, description, argument_name, &block)
    @known_options << {
      short_handle: short_handle,
      long_handle: long_handle,
      description: description,
      argument_name: argument_name,
      block: block
    }
  end

  def parse(command_runner, argument_values)
    command_runner = parse_arguments(command_runner, argument_values)
    parse_options(command_runner, argument_values)
  end

  def help
    [create_header, create_options].join("\n")
  end

  private

  def create_header
    arguments_help = @known_arguments.keys.map do |key|
      "[#{key}]"
    end.join(' ')

    "Usage: #{@bin_command} #{arguments_help}"
  end

  def create_options
    @known_options.map do |known_option|
      str = "    -#{known_option[:short_handle]}, --#{known_option[:long_handle]}"
      str += "=#{known_option[:argument_name]}" if known_option[:argument_name]

      str + ' ' + known_option[:description]
    end.join("\n")
  end

  def parse_arguments(command_runner, argument_values)
    @known_arguments
      .zip(argument_values_arguments(argument_values)) do |known_argument, argument_value|
      # NOTE: `known_argument` is a pair of `argument` and `block`.
      known_argument[1].call(command_runner, argument_value)
    end

    command_runner
  end

  def parse_options(command_runner, argument_values)
    argument_values_options(argument_values).each do |argument_value_option|
      @known_options.each do |known_option|
        clean_argument_value_option, value = parse_argument_value_option(argument_value_option)
        next unless clean_argument_value_option == known_option[:short_handle] ||
                    known_option[:long_handle]

        if known_option[:argument_name]
          known_option[:block].call(command_runner, value)
        else
          command_runner[known_option[:long_handle].to_sym] = true
        end
      end
    end

    command_runner
  end

  def parse_argument_value_option(argument_value_option)
    argument_value_option.chomp('-').reverse.chomp('-').reverse.split('=')
  end

  def argument_values_arguments(argument_values)
    argument_values.select { |argument_value| !option?(argument_value) }
  end

  def argument_values_options(argument_values)
    argument_values.select { |argument_value| option?(argument_value) }
  end

  def option?(argument_value)
    argument_value.start_with?('-', '--')
  end
end
