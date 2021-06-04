require_relative "services"
require_relative "BST"

BST_OPERATION = Operation.new

module BstOperation
    INSERT = BST_OPERATION.add_operation(1, 'Insert Element(multiple elements comma separated)')
    SEARCH = BST_OPERATION.add_operation(2, 'Search Element')
    REMOVE = BST_OPERATION.add_operation(3, 'Remove Element')
    SMALLEST = BST_OPERATION.add_operation(4, 'Smallest Element')
    LARGEST = BST_OPERATION.add_operation(5, 'Largest  Element')
    TRAVERSAL = BST_OPERATION.add_operation(6, 'Traverse Tree')
    ALL_PATH = BST_OPERATION.add_operation(7, 'All Paths i.e Root -> leaf')
    LOAD = BST_OPERATION.add_operation(8, 'Load Tree')
    SAVE = BST_OPERATION.add_operation(9, 'Save Tree')
    QUIT = BST_OPERATION.add_operation(10, 'Quit !')
end

def run_bst_script(tree, user_input)
    
    ops = [BstOperation::INSERT, BstOperation::LOAD, BstOperation::SAVE, BstOperation::QUIT]
    if tree.empty? and !ops.include?(user_input)
        puts "Empty Tree" 
        return
    end

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

def main_BST
    tree = BinarySearchTree.new
    
    loop do
        BST_OPERATION.show_available_options
        user_input = gets.chomp
        user_input = parse_input(user_input, BstOperation::QUIT)

        run_bst_script(tree, user_input)
        wait_for_user_input
        break if user_input == BstOperation::QUIT
    end
end