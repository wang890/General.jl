
module Aux
    function get_exs_separator(exs)
        plus, popped = false, false        
        exs_len = length(exs)  
        if exs_len == 0
            exs = ["", ""]
            plus = true
        elseif exs_len == 1
            # exs = collect(exs)
            # push!(exs,"")
            # plus = true
            the_first = pop!(exs)
            exs = []
            push!(exs, the_first)            
            push!(exs,"")
            plus = true
        else
            exs = collect(exs)
        end 
                    
        if exs[end] isa String
            separator = pop!(exs)
            if ! plus
                popped = true
            end
            # display("exs pop") 
            # exs |> display          
        else
            separator = ""
        end
        # (exs, separator) |> display
        return exs, separator, popped
    end

    function get_hr(hr_main, hr_main2, separator)
        if separator == ""  # 没有分隔线, 但如果 strip(exs[1]) == ""，相当于有空行分隔
            hr = hr_main # hr_main 原来是 strip(exs[1])
        else                
            separator_set = Set(separator)
            if separator_set == Set{Char}(' ') # 空格忽略
                hr = hr_main

            elseif separator_set == Set{Char}('\n')  # \n分隔                 
                hr = separator * hr_main

            elseif separator_set == Set{Char}(['\n', ' '])  # \n分隔, 空格忽略
                separator = replace(separator, " "=> "")
                hr = separator * hr_main 
                # \n分隔 的两个elseif: 如果strip(exs[1]) == ""，相当于多1个\n, 如果1个\n就够，就不再设置separator \n
                # 如果 strip(exs[1]) == "", 就有一个空行
            else
                hr = (separator*" ")^7 * hr_main2 # hr_main2 原来是exs[1]
            end 
        end

        replacing = "\n      "
        hr = replace(hr, '\n'=> replacing)            
        # if hr_level == "3" && length(exs[1]) == 0 
        #     hr = hr[1:end-7]
        # end
    end
        
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

        if ! Main.log
            quote let nothing end end 
        else
            exs, separator, popped = get_exs_separator(exs)

            exs[1] = exs[1] isa String ? exs[1] : string(exs[1])
            exs1_stripped = strip(exs[1])
            if exs1_stripped == ""
                exs[1] = ""
            end           
            
            if exs == [""]
                quote let nothing end end 
            else
               
                # 相当于 strip(exs[1])->hr_main, 原来hr_main2是 exs[1]
                hr = get_hr(exs1_stripped, exs[1], separator)
                exs[1] =  hr             

                Base.CoreLogging.logmsg_code(
                    (Base.CoreLogging.@_sourceinfo)..., 
                    esc(Base.CoreLogging.Info), exs...)       
            end 
        end 

    end
    
    macro logt(exs...)
        # exs |> display
        if ! Main.log
            quote nothing end
        elseif length(exs) == 0
            quote
                $(
                    quote                            
                        println("") # logt, 打印 1空行
                    end                          
                )
            end

        else
            # exs, separator = get_exs_separator(exs)
            # exs |> display
            # separator |> display
            # escapes = esc.(exs)
            # escapes |> display

            # values = [(esc(exs...)),]
            # [$(exs...),]

            
            #[esc(exs...),] # 错误
            # no method matching esc(::Symbol, ::Expr, ::Symbol, ::Symbol)
            # quote values = [$(escapes...),] end
            
            # values |> display
            

            
            # values |> display            
            quote                
                # exs, separator = get_exs_separator($(esc(exs)))
                # exs |> display
                
                # if exs == [""]
                # values = [$(exs...),]
                # values = [$((esc(exs))...),]

                # escapes = esc.(exs)
                #[esc(exs...),] # 错误
                # no method matching esc(::Symbol, ::Expr, ::Symbol, ::Symbol)
                # values = [$(escapes...),]
                # UndefVarError: `escapes` not defined

                # values = [$((esc.(exs))...),]
                exs, separator, popped = get_exs_separator($(esc(exs))) # 原来 $(esc(exs)),用不着$ 不对还是要 否则未定义
                # exs |> display
                # separator |> display

                # escapes = esc.(exs)
                # escapes = [esc(exs...),]
                # escapes |> display

                # escapes = []


                values = [$((esc.(exs))...),] # 和上一行exs不一样
                if popped
                    pop!(values)
                end
                # values = [$(exs...),]
                # display("values")
                # values |> display
                # i = 1

                # if values == [""]
                #     $(
                #         quote                            
                #             println("") # logt, 打印 1空行
                #         end                          
                #     )
                # else
                hr = get_hr("", "", separator)
                names = string.(exs)
                # display("names")
                # names |> display
                # values = [$(exs...),]

                # values0 = [esc(exs...),]                    
                # values = [$([esc(exs...),]...),]
                # values0 |> display
                # values |> display
                # # types = [typeof(($(exs...))...),] # 错误
                # i = 1
                $(
                    quote
                        if hr != "" # 如果都打印，for循环里还有1个println("")，会成双行
                            println(hr)
                        end
                        # i = 1  # `i` not defined
                        # i = 1
                        for (i,v) in enumerate(values)                                
                            println("")
                            first = names[i] * ", " * string(typeof(v))
                            println(first)
                            # second = "       " * v # no method matching *(::String, ::Vector{Int64})
                            println("  = ", v)                    
                            # i = i + 1  # 没有 i++ 写法
                        end
                    end
                )
            end
        end        
    end    

    using General.Explore
    macro logtt(exs...) 
        exs |> display
        typeof(exs) |> display
        # names = broadcast(Explore.@str_dollar, exs) # 不能这样用广播        

        if ! Main.log
            quote let nothing end end 
        else
            exs, separator = get_exs_separator(exs)
            
            if exs == [""]
                quote let nothing end end 
            else
                types = Explore.eval_type.(exs)
                hr_main = join(types, ", ")  # 相当于 strip(exs[1])

                hr = get_hr(hr_main, "\n"*hr_main, separator)
                pushfirst!(exs, hr)             

                Base.CoreLogging.logmsg_code(
                    (Base.CoreLogging.@_sourceinfo)..., 
                    esc(Base.CoreLogging.Info), exs...)       
            end 
        end
    end

    export @log, @logt, @logtt

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

    # macro log(exs...) 
    #     # not_show_my_debug = false  # 否定之否定 为肯定，即显示   
    #     # if ! Main.log
    #     #     return nothing
    #     # end
    #     # println(exs)
    #     # println(typeof(exs[1]))      

    #     if ! Main.log
    #         quote let nothing end end  # 必须参照 else 的 logmsg_code 返回结果形式
    #         # quote nothing end # 也可以
    #     else
    #         exs_len = length(exs)
    #         # println("exs_len:", exs_len)

    #         # println(typeof(exs))           
    #         # exs = collect(exs)
    #         # println(typeof(exs)) 
    #         # exs_len:0时, 上述两个打印为 Tuple{} Vector{Union{}}            
            
    #         if exs_len == 0
    #             exs = ["", ""]                
    #             # push!(exs,["", ""]...)
    #         elseif exs_len == 1
    #             exs = collect(exs)
    #             push!(exs,"")
    #         else
    #             exs = collect(exs)
    #         end
    #         # println(exs)

    #         exs[1] = exs[1] isa String ? exs[1] : string(exs[1])
    #         exs1_stripped = strip(exs[1])
    #         if exs1_stripped == ""
    #             exs[1] = ""
    #         end           
                        
    #         if exs[end] isa String
    #             separator = pop!(exs)           
    #         else
    #             separator = ""
    #         end

    #         if separator == ""  # 没有分隔线, 但如果 strip(exs[1]) == ""，相当于有空行分隔
    #             hr = strip(exs[1])
    #         else                
    #             separator_set = Set(separator)
    #             if separator_set == Set{Char}(' ') # 空格忽略
    #                 hr = strip(exs[1])

    #             elseif separator_set == Set{Char}('\n')  # \n分隔                 
    #                 hr = separator * strip(exs[1])

    #             elseif separator_set == Set{Char}(['\n', ' '])  # \n分隔, 空格忽略
    #                 separator = replace(separator, " "=> "")
    #                 hr = separator * strip(exs[1]) 
    #                 # \n分隔 的两个elseif: 如果strip(exs[1]) == ""，相当于多1个\n, 如果1个\n就够，就不再设置separator \n
    #                 # 如果 strip(exs[1]) == "", 就有一个空行
    #             else
    #                 hr = (separator*" ")^7 * exs[1]
    #             end 
    #         end

    #         replacing = "\n      "
    #         replaced = replace(hr, '\n'=> replacing)            
    #         # if hr_level == "3" && length(exs[1]) == 0 
    #         #     replaced = replaced[1:end-7]
    #         # end
    #         exs[1] =  replaced    

    #         Base.CoreLogging.logmsg_code(
    #             (Base.CoreLogging.@_sourceinfo)..., 
    #             esc(Base.CoreLogging.Info), exs...)        
    #     end 
    # end

end
