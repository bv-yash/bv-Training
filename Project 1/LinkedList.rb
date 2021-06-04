require_relative 'DataStructure'

class ListNode < Node

    attr_accessor :next

    def initialize(value = nil, nxt = nil)
        super value
        @next = nxt
    end
end

class LinkedList < DataStructures

    def initialize
        @head = nil
        @tail = nil
    end

    def insert(value)
        new_node = ListNode.new(value)
        
        if @head.nil?
            @head = new_node
            @tail = new_node
        else
            @tail.next = new_node
            @tail = new_node
        end
    end
    
    def remove(value)
        return if @head.nil?

        if @head.value == value
            @head = @head.next
            return
        end

        prev = nil
        curr_node = @head
        while !curr_node.nil? and curr_node.value != value
            prev = curr_node
            curr_node = curr_node.next
        end
        return if curr_node.nil?
        prev.next = curr_node.next
        @tail = prev if curr_node == @tail
    end

    def search(value)
        curr_node = @head
        until curr_node.nil?
            return true if curr_node.value == value
            curr_node = curr_node.next
        end
        false
    end

    def print_list
        curr_node = @head
        until curr_node.nil?
            print curr_node.value, ' => '
            curr_node = curr_node.next
        end
        puts 'nil'
    end

    def reverse
        prev = nil
        curr_node = @head
        @tail = curr_node

        until curr_node.nil?
            nxt = curr_node.next
            curr_node.next = prev
            prev = curr_node
            curr_node = nxt
        end
        @head = prev
    end

    def clear
        @head = nil
        @tail = nil
    end

    def empty?
        @head.nil?
    end

    def get_values_as_array
        arr = []
        curr_node = @head
        while curr_node != nil
            arr << curr_node.value
            curr_node = curr_node.next
        end
        arr
    end
end