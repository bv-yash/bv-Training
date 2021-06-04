require 'json'

class Node

    attr_accessor :value

    def initialize(value = nil)
        @value = value
    end
end

class DataStructures

    def save(filename)
        filename = "#{filename}.json"
        arr = get_values_as_array
        File.open("#{filename}", 'w') do |file|
            file.write(arr.to_json)
        end
        puts "File Saved Successfully as #{filename}"
    end

    def is_valid_values(values)
        return false unless values.class == Array
        values.each do |elem|
            return false unless elem.class == Integer
        end
        true
    end

    def load(filename)
        filename = "#{filename}.json"
        return puts 'No Such file present.' if !File.exist?(filename)

        begin
            data = File.read(filename)    
            elements = JSON.parse(data)    
        rescue JSON::ParserError => exception
            return puts "InValid Json File."
        end
        return puts "InValid Values in file." unless is_valid_values(elements)
        
        clear
        elements.each do |elem|
            insert elem
        end
        puts 'File Loaded Sucessfully...'
    end
end