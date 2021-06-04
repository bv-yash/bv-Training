def wait_for_user_input
        puts "Press enter to continue." 
        gets
        system('clear')
end

def is_valid_input(elements)
                elements = elements.map { |elem| Integer(elem) }
                true
rescue ArgumentError => exeception
        return false
end