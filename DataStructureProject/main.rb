require_relative "./scripts/bst_script"
require_relative "./scripts/linked_list_script"

INPUT_OPTIONS = Operation.new

module InputOptions
        BST = INPUT_OPTIONS.add_operation(1,'Binary Search Tree')
        LINKED_LIST = INPUT_OPTIONS.add_operation(2,'Linked List')
        QUIT = INPUT_OPTIONS.add_operation(3,'QUIT')
end

def run_script(user_input)
        case user_input
        when InputOptions::BST
                main_BST
        when InputOptions::LINKED_LIST
                main_LL
        when InputOptions::QUIT
                puts "Thank You!!"
        else
                puts "InValid Choice!!!"
        end
end

def main
        loop do
                INPUT_OPTIONS.show_available_options
                user_input = gets.chomp
                user_input = user_input == 'quit' ? 3 : user_input.to_i

                run_script(user_input)
                break if user_input == InputOptions::QUIT
        end
end

main