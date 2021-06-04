require_relative "./data_structure"
require_relative "./node"

class ListNode < Node
        attr_accessor :_next

        def initialize(value = nil, _next = nil)
                super value
                @_next = _next
        end
end

class LinkedList < DataStructures
        
        def initialize
                @head = nil
                @tail = nil
        end

        def build(elements)
                clear
                elements.each do |elem|
                        insert_at_end(elem)
                end
        end

        def insert_at_end(value)
                new_node = ListNode.new(value)
                
                if @head.nil?
                        @head = new_node
                        @tail = new_node
                else
                        @tail._next = new_node
                        @tail = @tail._next
                end
        end
        
        def remove(value)
                rreturn if @head.nil?

                if @head.value == value
                        @head = @head._next
                else
                        prev = nil
                        curr_node = @head
                        until curr_node.nil?
                                if curr_node.value == value
                                       prev._next = curr_node._next
                                       @tail = prev if curr_node == @tail
                                       break
                                end
                                prev = curr_node
                                curr_node = curr_node._next
                        end
                end
        end

        def search(value)
                curr_node = @head
                until curr_node.nil?
                        return true if curr_node.value == value
                        curr_node = curr_node._next
                end
                false
        end

        def print_list
                curr_node = @head
                until curr_node.nil?
                        print curr_node.value, ' => '
                        curr_node = curr_node._next
                end
                puts 'nil'
        end

        def reverse
                prev = nil
                curr_node = @head
                @tail = curr_node

                until curr_node.nil?
                        nxt = curr_node._next
                        curr_node._next = prev
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
                until curr_node.nil?
                        arr << curr_node.value
                        curr_node = curr_node._next
                end
                arr
        end
end