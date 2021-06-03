
class DataStructures

    def show_oprations_bst
        puts "
        1  => Add elements into the tree(multiple elements comma separated)
        2  => Print the largest element
        3  => Print the smallest element
        4  => Print Inorder, postorder, level order, and preorder traversal 
        5  => Search an element
        6  => Remove an element
        7  => Print all the paths i.e starting from root to the leaf
        8  => load BST from file.
        9  => Save Tree
        10 => Quit
        "
    end


    def show_oprations_linked_list
        puts "
        1  => Add elements into the list(multiple elements comma separated) 
        2  => Search an element
        3  => Remove an element
        4  => Reverse the list.
        5  => Print the list.
        6  => load list from file.
        7  => Save list
        8 => Quit
        "
    end


    def show_data_structure
        puts "
        1 => Binary Search Tree
        2 => Linked List
        3 => Quit
        "
    
    def main_screen

        while true
            show_data_structure
            
        end
    end

end

def run_script(tree, user_input)
    return puts "Tree is empty" if tree.empty? and user_input != "1"  and user_input != "8" and user_input > 10

    case user_input
    when "1"
        puts "Please enter elemets."
        elements = gets.chomp.split(',').map { |elem| elem.to_i }

        elements.each do |elem|
            tree.insert elem
        end 
        puts "Elements inserted successfully."

    when "2"
        puts "Largest Element : #{tree.find_largest}"

    when "3"
        puts "Smallest Element : #{tree.find_smallest}"

    when "4"
        tree.traverse()
    
    when "5"
        print "Enter the value of element : "

        key = gets.chomp.to_i

        if tree.search(key)
            puts "Element Found."
        else
            puts "Element not found !!!"
        end

    when "6"
        print "Enter the value of element : "

        elem = gets.chomp.to_i

        tree.remove(elem)
        puts "#{elem} deleted successfully."

    when "7"
        tree.all_path_from_root_to_leaf

    when "8"
        tree.load

    when "9"
        tree.save

    else
        puts 'Invalid Input !!!'
    end
end


def main

    tree = BinarySearchTree.new()

    while true

        show_oprations

        user_input = gets.chomp
        if user_input == 'q' or user_input == 'quit' or user_input == '10'
            tree.save
            break
        end
            
        run_script(tree, user_input)

        puts "Press enter to continue." 
        gets
        
        system('clear')
    end

    puts 'Thank You!'
end


main

