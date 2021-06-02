

class TreeNode

    attr_accessor :value, :left, :right

    def initialize(value = nil, left = nil, right = nil)
      @value = value
      @left = left
      @right = right
    end
end


class BinarySearchTree
    
    def initialize()
        @root = nil
    end

    def insert(value)
        if @root == nil
            @root = TreeNode.new(value)
        else
            curr_node = @root
            previous_node = @root

            while curr_node != nil
                previous_node = curr_node
                if value <= curr_node.value
                    curr_node = curr_node.left
                else
                    curr_node = curr_node.right
                end
            end

            if value < previous_node.value
                previous_node.left = TreeNode.new(value)
            else
                previous_node.right = TreeNode.new(value)
            end
        end
    end


    def traverse        
        print "Inorder traversal => "
        in_order(@root)
        puts

        print "Post-Order traversal => "
        post_order(@root)
        puts

        print "Pre-Order traversal => "
        pre_order(@root)
        puts

        print "Level-Order traversal => "
        level_order(@root)
        puts
    end


    def in_order(root)
        return if root.nil?
            
        in_order(root.left)

        print root.value, ' '

        in_order(root.right)
    end


    def post_order(root)
        return if root.nil?

        post_order(root.left)

        post_order(root.right)

        print root.value, ' '
    end


    def pre_order(root)
        return if root.nil?

        print root.value, ' '

        pre_order(root.left)

        pre_order(root.right)
    end


    def level_order(root)
        return if root.nil?
        
        result = []

        que = Queue.new

        que.push @root

        level = 0
        puts

        until que.empty?
            level_size = que.length
            curr_level = []
            
            level_size.times do 
                node = que.pop
                curr_level << node.value

                que.push(node.left) unless node.left.nil?

                que.push(node.right) unless node.right.nil?
            end

            print 'level ', level, ' => ', curr_level
            puts
            level += 1
            result << curr_level
        end

        result
    end


    def find_smallest()
        return if @root.nil?

        curr_node = @root
        while curr_node.left != nil
            curr_node = curr_node.left
        end

        curr_node.value
    end


    def find_largest()
        return if @root.nil?

        curr_node = @root
        while curr_node.right != nil
            curr_node = curr_node.right
        end

        curr_node.value
    end


    def search(key)
        curr_node = @root

        while curr_node != nil do
            return true if curr_node.value == key 

            if curr_node.value < key
                curr_node = curr_node.right
            else
                curr_node = curr_node.left
            end
        end

        false
    end


    def remove(key)
        @root = remove_helper(key, @root)
    end


    def remove_helper(key, node)
        return nil if node.nil?
        
        if node.value < key

            node.right = remove_helper(key, node.right)

        elsif node.value > key

            node.left = remove_helper(key, node.left)

        else
            if node.left.nil? and node.right.nil? #no child
                node = nil
            elsif node.left != nil   # 1 child
                node = node.left
            elsif node.right !=  nil # 1 child
                node = node.right
            else                     # 2 child

                max_in_left_subtree = find_largest(node.left)

                node.value = max_in_left_subtree

                node.right = remove_helper(max_in_left_subtree, node.right)
            end
        end

        return node
    end


    def all_path_from_root_to_leaf()
        result = []
        curr_path = []
        
        get_paths(@root, curr_path, result)
        
        print_paths(result)
    end


    def get_paths(root, cur_path, result)
        return if root.nil?
        
        cur_path << root.value

        if root.left.nil? and root.right.nil?
            result << cur_path.clone
        else
            get_paths(root.left, cur_path, result)

            get_paths(root.right, cur_path, result)
        end

        cur_path.pop
    end


    def print_paths(paths)
        puts 'Printing All path from root to leaf...'
        paths.each_with_index do |path, idx|
            print 'Path ', idx+1, ' : '
            for val in path
                print val, ' => '
            end
            print 'nil'
            puts
        end
    end


    def clear
        @root = nil
    end


    def load()
        print "Enter file name : "
        name = gets.chomp
    
        begin
            file = File.open("#{name}.txt")    
            data = file.read
            file.close
            
            elements = data.split(',').map { |elem| elem.to_i}
    
            clear
            elements.each do |elem|
                insert elem
            end 
    
            puts 'File Loaded Sucessfully...'

        rescue 

            puts 'No Such file present.'

        end
    end
    
    def save()
        print "Name your file to save : "
        name = gets.chomp
        
        print 'Current Tree =>'
        result = level_order(@root)
    
        File.open("#{name}.txt", 'w') { |file|
            result.each do |level|
                level.each do |value|
                    file << value
                    file << ','
                end
            end
        }
    
        puts "Tree saved as #{name}.txt"
    end

    def empty?
        return  @root.nil?
    end

end



def show_oprations
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






