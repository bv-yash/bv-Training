require "json"

class DataStructures
        def save(filename)
                file_path = "./DataStructureProject/saved_files/#{filename}.json"
                arr = get_values_as_array
                File.open("#{file_path}", 'w') do |file|
                        file.write(arr.to_json)
                end
                puts "File Saved Successfully."
        end

        def has_valid_values(values)
                return false unless values.is_a? Array
                values.each do |elem|
                        return false unless elem.is_a? Integer
                end
                true
        end

        def load(filename)
                file_path = "./DataStructureProject/saved_files/#{filename}.json"
                if !File.exist?(file_path)
                        puts 'No such file present.' 
                        return
                end


                data = File.read(file_path)        
                elements = JSON.parse(data)
                        
                raise "InValid Values in file."  unless has_valid_values(elements)
                
                build elements
                puts 'File Loaded Sucessfully...'

        rescue JSON::ParserError => exception
                puts "InValid Json File."
        rescue RuntimeError => exc
                puts exc
        end
end