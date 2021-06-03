load "BST.rb"

BST_OPERATION = {}

def add_operation(id, msg)
    BST_OPERATION[id] = msg
    id
end

module BstOperation
    INSERT_ELEMENT = add_operation(1, 'Insert Element(multiple elements comma separated)')
    SEARCH_ELEMENT = add_operation(2, 'Search Element')
    REMOVE_ELEMENT = add_operation(3, 'Remove Element')
    SMALLEST_ELEMENT = add_operation(4, 'Smallest Element')
    LARGEST_ELEMENT = add_operation(5, 'Largest  Element')
    TRAVERSAL = add_operation(6, 'Traverse Tree')
    ALL_PATH = add_operation(7, 'All Paths i.e Root -> leaf')
    LOAD = add_operation(8, 'Load Tree')
    SAVE = add_operation(9, 'Save Tree')
    QUIT = add_operation(10, 'Quit !')
end
    
def show_bst_operations
    total_op = BST_OPERATION.length

    (1..total_op).each do |op|
        print op, ' => ', BST_OPERATION[op]
        puts
    end
    print 'Please enter your choice : '
end

def run_bst_script(tree, user_input)

    if user_input == 'quit'
        user_input = 10
    else
        user_input = user_input.to_i
    end

    case user_input
    when BstOperation::INSERT_ELEMENT
        print "Please enter elemets : "
        elements = gets.chomp.split(',').map { |elem| elem.to_i }

        elements.each do |elem|
            tree.insert elem
        end 
        puts "Elements inserted successfully."
    when BstOperation::SEARCH_ELEMENT
        return puts 'Tree is Empty' if tree.empty?

        print "Enter the value of element : "
        key = gets.chomp.to_i
        puts tree.search(key) ? "Element Found." : "Element not found !!!"
    when BstOperation::LARGEST_ELEMENT
        puts tree.empty? ? 'Tree is Empty' : "Largest Element : #{tree.find_largest}"
    when BstOperation::SMALLEST_ELEMENT
        puts tree.empty? ? 'Tree is Empty' : "Smallest Element : #{tree.find_smallest}"
    when BstOperation::TRAVERSAL
        puts tree.empty? ? 'Tree is Empty' : tree.traverse       
    when BstOperation::REMOVE_ELEMENT
        return puts 'Tree is Empty' if tree.empty?

        print "Enter the value of element : "
        elem = gets.chomp.to_i
        tree.remove(elem)
        puts "#{elem} deleted successfully."
    when BstOperation::ALL_PATH
        return puts 'Tree is Empty' if tree.empty?
        tree.all_path_from_root_to_leaf
    when BstOperation::LOAD
        print 'Please enter file name : '
        filename = gets.chomp
        tree.load filename
    when BstOperation::SAVE
        return puts 'Tree is Empty' if tree.empty?

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
    tree = BinarySearchTree.new()
    
    loop do
        show_bst_operations
        user_input = gets.chomp

        run_bst_script(tree, user_input)

        puts "Press enter to continue." 
        gets
        system('clear')

    break if user_input == 'quit' or user_input.to_i == BstOperation::QUIT
    end

end


main_BST






