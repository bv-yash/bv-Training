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