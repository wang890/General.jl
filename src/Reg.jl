
module Reg

    # export get_cut
        
    function get_cut(str::String, regex_start::String, regex_end::String)::String    
        # index_start = match(@r_str(regex_start), str).offset
        index_start = match(Base.Regex(regex_start), str).offset
        index_end = match(Base.Regex(regex_end), str).offset + (length(regex_end) - 1)
        str[index_start: index_end]
    end

    function get_match_capture(str::Union{String, SubString{String}}, regex::Base.Regex, old_new::Pair{String, String}...; i::Int=1) ::Tuple{String, Int}
        if strip(str) == ""
            return "", nothing
        end        
        m = match(regex, str)
        if m !== nothing && length(m.captures) >=i # 要有，所有都有，因为是一个regex
            capture = replace(strip(m.captures[i]), old_new...)
            offset = m.offsets[i]
        else
            capture = ""
            offset = nothing
        end
        # capture, offset
        # MethodError: Cannot `convert` an object of type Tuple{String, Int64} to an object of type String
        # 原来是function结果断言写成了String
        capture, offset

    end

    # function get_match_captures_offsets(str::String, regex::Base.Regex)
    #     if str == ""
    #         return ""
    #     end        
    #     m = match(regex, str)
    #     if m !== nothing && length(m.captures) >=i
    #         capture = replace(strip(m.captures[i]), old_new...)
    #     else
    #         capture = ""
    #     end
    #     capture    
    # end

end