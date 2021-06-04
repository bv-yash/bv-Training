def wait_for_user_input
    puts "Press enter to continue." 
    gets
    system('clear')
end

def is_valid_input(elements)
    begin
        elements = elements.map { |elem| Integer(elem) }
        true
    rescue ArgumentError
        return false
    end
end

def parse_input(user_input, quit_op)
    (user_input == 'quit') ? quit_op : user_input.to_i 
end

class Operation
    def initialize
      @options = {}
    end

    def add_operation(id, msg)
        @options[id] = msg
        id
    end

    def show_available_options
        @options.each do |id, msg|
            print id, ' => ', msg
            puts
        end
        print 'Please enter your choice : '
    end
end