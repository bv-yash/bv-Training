require_relative "operations"
require_relative "LinkedList"

LIST_OPERATION = Operation.new

module ListOperation
        INSERT = LIST_OPERATION.add_operation(1, 'Add elements into the list(multiple elements comma separated)')
        SEARCH = LIST_OPERATION.add_operation(2, 'Search an element')
        REMOVE = LIST_OPERATION.add_operation(3, 'Remove an element')
        REVERSE = LIST_OPERATION.add_operation(4, 'Reverse the list.')
        PRINT = LIST_OPERATION.add_operation(5, 'Print the list.')
        LOAD = LIST_OPERATION.add_operation(6, 'load list from file.')
        SAVE = LIST_OPERATION.add_operation(7, 'Save list')
        QUIT = LIST_OPERATION.add_operation(8, 'Quit!')
end

def run_list_script(list, user_input)

        case user_input
        when ListOperation::INSERT
                print "Please enter elemets : "
                elements = gets.chomp.split(',')
                return puts "Invalid Inputs!!!" unless is_valid_input(elements)
                
                elements.each do |elem|
                        list.insert Integer(elem)
                end 
                puts "Elements inserted successfully."
        when ListOperation::SEARCH
                print "Enter the value of element : "
                key = gets.chomp.to_i
                puts list.search(key) ? "Element Found." : "Element not found !!!"
        when ListOperation::REMOVE
                print "Enter the value of element : "
                elem = gets.chomp.to_i
                list.remove(elem)
                puts "#{elem} deleted successfully."
        when ListOperation::REVERSE
                list.reverse
                print 'List Reversed Successfully.'
        when ListOperation::PRINT
                print 'Linked List : '
                list.print_list
        when ListOperation::LOAD
                print 'Please enter file name : '
                filename = gets.chomp
                list.load filename
        when ListOperation::SAVE
                print 'Please enter file name : '
                filename = gets.chomp
                list.save(filename)
        when ListOperation::QUIT 
                return puts 'Thank You!!!' if list.empty?

                print 'Please enter file name to save : '
                filename = gets.chomp
                list.save(filename) 
                puts 'Thank You!!!'
        else
                puts 'Invalid Input !!!'
        end
end

def main_LL
        list = LinkedList.new

        loop do
                LIST_OPERATION.show_available_options
                user_input = gets.chomp
                user_input = parse_input(user_input, ListOperation::QUIT)

                run_list_script(list, user_input)
                wait_for_user_input
                break if user_input == ListOperation::QUIT
        end
end