require_relative "BST.rb"

BST_OPERATION = {}

def add_operation(id, msg)
    BST_OPERATION[id] = msg
    id
end

module BstOperation
    INSERT = add_operation(1, 'Insert Element(multiple elements comma separated)')
    SEARCH = add_operation(2, 'Search Element')
    REMOVE = add_operation(3, 'Remove Element')
    SMALLEST = add_operation(4, 'Smallest Element')
    LARGEST = add_operation(5, 'Largest  Element')
    TRAVERSAL = add_operation(6, 'Traverse Tree')
    ALL_PATH = add_operation(7, 'All Paths i.e Root -> leaf')
    LOAD = add_operation(8, 'Load Tree')
    SAVE = add_operation(9, 'Save Tree')
    QUIT = add_operation(10, 'Quit !')
end
    
def show_bst_operations
    BST_OPERATION.each do |key, msg|
        print key, ' => ', msg
        puts
    end
    print 'Please enter your choice : '
end

def is_valid_input(elements)
    begin
        elements = elements.map { |elem| Integer(elem) }
    rescue ArgumentError
        return false
    end
    true
end

def run_bst_script(tree, user_input)
    
    ops = [BstOperation::INSERT, BstOperation::LOAD,BstOperation::SAVE, BstOperation::QUIT]
    return puts "Empty Tree" if tree.empty? and !ops.include?(user_input)

    case user_input
    when BstOperation::INSERT
        print "Please enter elemets : "
        elements = gets.chomp.split(',')
        return puts "Invalid Inputs!!!" unless is_valid_input(elements)
        
        elements.each do |elem|
            tree.insert Integer(elem)
        end 
        puts "Elements inserted successfully."
    when BstOperation::SEARCH
        print "Enter the value of element : "
        key = gets.chomp.to_i
        puts tree.search(key) ? "Element Found." : "Element not found !!!"
    when BstOperation::LARGEST
        puts "Largest Element : #{tree.find_largest}"
    when BstOperation::SMALLEST
        puts "Smallest Element : #{tree.find_smallest}"
    when BstOperation::TRAVERSAL
        tree.traverse       
    when BstOperation::REMOVE
        print "Enter the value of element : "
        elem = gets.chomp.to_i
        tree.remove(elem)
        puts "#{elem} deleted successfully."
    when BstOperation::ALL_PATH
        tree.all_path_from_root_to_leaf
    when BstOperation::LOAD
        print 'Please enter file name : '
        filename = gets.chomp
        tree.load filename
    when BstOperation::SAVE
        print 'Please enter file name : '
        filename = gets.chomp
        tree.save(filename)
    when BstOperation::QUIT
        return puts 'Thank You!!!' if tree.empty?

        print 'Please enter file name to save : '       
        filename = gets.chomp
        tree.save(filename) 
        puts 'Thank You!!!'
    else
        puts 'Invalid Input !!!'
    end
end

def wait_for_user_input
    puts "Press enter to continue." 
    gets
    system('clear')
end

def parse_input(user_input)
    (user_input == 'quit') ? 10 : user_input.to_i
end

def main_BST
    tree = BinarySearchTree.new()
    
    loop do
        show_bst_operations
        user_input = gets.chomp
        user_input = parse_input(user_input)

        run_bst_script(tree, user_input)
        wait_for_user_input

    break if user_input == BstOperation::QUIT
    end
end

main_BST