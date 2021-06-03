load 'Node.rb'

class TreeNode < Node

    attr_accessor :left, :right

    def initialize(value = nil, left = nil, right = nil)
        super value
        @left = left
        @right = right
    end
end


class BinarySearchTree
    
    def initialize
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

            if value <= previous_node.value
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

    def find_smallest
        return if @root.nil?

        curr_node = @root
        while curr_node.left != nil
            curr_node = curr_node.left
        end

        curr_node.value
    end

    def find_largest
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

        node
    end

    def all_path_from_root_to_leaf
        result   = []
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

    def load(filename)
        begin
            file = File.open("#{filename}")    
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
    
    def save(filename)
        print 'Current Tree =>'
        result = level_order(@root)

        arr = []
        result.each do |level|
            level.each do |value|
                arr << value
            end
        end

        File.open("#{filename}", 'w') { |file|
            length = arr.length
            for idx in (0..length-2)
                file << arr[idx]
                file << ','
            end
            file << arr[length-1]
        }
        puts "Tree saved as #{filename}"
    end

    def empty?
        return  @root.nil?
    end

end
