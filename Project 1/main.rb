require_relative "BSTScript"
require_relative "LinkedListScript"

DATA_STRUCTURE = Operation.new

module Data
    BST = DATA_STRUCTURE.add_operation(1,'Binary Search Tree')
    LinkedList = DATA_STRUCTURE.add_operation(2,'Linked List')
    QUIT = DATA_STRUCTURE.add_operation(3,'QUIT')
end

def run_script(user_input)

    case user_input
    when Data::BST
        main_BST
    when Data::LinkedList
        main_LL
    when Data::QUIT
        puts "Thank You!!"
    else
        puts "InValid Choice!!!"
    end
end

def main
    loop do
        DATA_STRUCTURE.show_available_options
        user_input = gets.chomp
        user_input = parse_input(user_input, Data::QUIT)

        run_script(user_input)
        break if user_input == Data::QUIT
    end
end

main