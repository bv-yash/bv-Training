require "json"

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

        def has_valid_values(values)
                return false unless values.is_a? Array
                values.each do |elem|
                        return false unless elem.is_a? Integer
                end
                true
        end

        def load(filename)
                filename = "#{filename}.json"
                return puts 'No Such file present.' if !File.exist?(filename)

                data = File.read(filename)        
                elements = JSON.parse(data)
                        
                raise "InValid Values in file."  unless has_valid_values(elements)
                
                clear
                elements.each do |elem|
                        insert elem
                end
                puts 'File Loaded Sucessfully...'

        rescue JSON::ParserError => exception
                puts "InValid Json File."
        rescue RuntimeError => exc
                puts exc
        end
end