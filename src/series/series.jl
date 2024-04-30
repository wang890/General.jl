module Series

    function get_index_of_item_incl_regex(series,regex::Regex)
        for (i, item) in enumerate(series)
            if !(item isa String)
                item = string(item)
            end
            if occursin(regex, item)
                return i                
            end
        end
    end

end