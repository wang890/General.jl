
module Aux
    # using Layout
    # Package General does not have Layout in its dependencies
    # using General.Layout

    # function __init__()
        # log = true
    # end
    # log = true
        
    # macro log(exs...) 
    #     # not_show_my_debug = false  # 否定之否定 为肯定，即显示   
    #     # if ! Main.log
    #     #     return nothing
    #     # end
    #     if ! Main.log
    #         quote let nothing end end  # 必须参照 else 的 logmsg_code 返回结果形式
    #         # quote nothing end # 也可以
    #     else           
    #         exs = collect(exs)
    #         exs[1] = exs[1] isa String ? exs[1] : string(exs[1])         

    #         if exs[end] in Layout.level__hr_keys
    #             hr_level = pop!(exs)
    #         else
    #             hr_level = 1
    #         end            
    #         # global level__hr
    #         hr = Layout.level__hr[hr_level]*exs[1]
        
    #         replacing = "\n      "
    #         replaced = replace(hr, '\n'=> replacing)
    #         if hr_level == "3" && length(exs[1]) == 0 
    #             replaced = replaced[1:end-7]
    #         end
    #         exs[1] =  replaced    

    #         Base.CoreLogging.logmsg_code(
    #             (Base.CoreLogging.@_sourceinfo)..., 
    #             esc(Base.CoreLogging.Info), exs...)        
    #     end 
    # end

    """
    macro log(exs...)
        ≡≡, ==, --, \n 等分隔符, 自定义
    Examples: 
        @log
        @log "exDispatch ex.args: "

        @log "First" arr1
        @log "" arr1  # "" 相当于1个\n
        @log "First" arr1 "\n\n"
        @log "" arr1 "\n\n"        

        @log "Third" arr3 "≡≡"
        @log "\nThird" arr3 "=="
        @log "" arr3 "--"
        @log " \n  " arr3  # " \n  "相当于 ""
    """
    macro log(exs...) 
        # not_show_my_debug = false  # 否定之否定 为肯定，即显示   
        # if ! Main.log
        #     return nothing
        # end      

        if ! Main.log
            quote let nothing end end  # 必须参照 else 的 logmsg_code 返回结果形式
            # quote nothing end # 也可以
        else
            exs_len = length(exs)
            # println("exs_len:", exs_len)

            # println(typeof(exs))           
            # exs = collect(exs)
            # println(typeof(exs)) 
            # exs_len:0时, 上述两个打印为 Tuple{} Vector{Union{}}            
            
            if exs_len == 0
                exs = ["", ""]                
                # push!(exs,["", ""]...)
            elseif exs_len == 1
                exs = collect(exs)
                push!(exs,"")
            else
                exs = collect(exs)
            end
            # println(exs)

            exs[1] = exs[1] isa String ? exs[1] : string(exs[1])
            exs1_stripped = strip(exs[1])
            if exs1_stripped == ""
                exs[1] = ""
            end           
                        
            if exs[end] isa String
                separator = pop!(exs)           
            else
                separator = ""
            end

            if separator == ""  # 没有分隔线, 但如果 strip(exs[1]) == ""，相当于有空行分隔
                hr = strip(exs[1])
            else                
                separator_set = Set(separator)
                if separator_set == Set{Char}(' ') # 空格忽略
                    hr = strip(exs[1])

                elseif separator_set == Set{Char}('\n')  # \n分隔                 
                    hr = separator * strip(exs[1])

                elseif separator_set == Set{Char}(['\n', ' '])  # \n分隔, 空格忽略
                    separator = replace(separator, " "=> "")
                    hr = separator * strip(exs[1]) 
                    # \n分隔 的两个elseif: 如果strip(exs[1]) == ""，相当于多1个\n, 如果1个\n就够，就不再设置separator \n
                    # 如果 strip(exs[1]) == "", 就有一个空行
                else
                    hr = (separator*" ")^7 * exs[1]
                end 
            end

            replacing = "\n      "
            replaced = replace(hr, '\n'=> replacing)            
            # if hr_level == "3" && length(exs[1]) == 0 
            #     replaced = replaced[1:end-7]
            # end
            exs[1] =  replaced    

            Base.CoreLogging.logmsg_code(
                (Base.CoreLogging.@_sourceinfo)..., 
                esc(Base.CoreLogging.Info), exs...)        
        end 
    end

    export @log

end
