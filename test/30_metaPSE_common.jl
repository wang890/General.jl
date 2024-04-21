macro julia2dict(ex)    
    @log "\n@julia2dict ex:" ex "≡≡"
    return julia2dict_do(ex)
end

function julia2dict_do(ex::Expr)
    d = Dict{Symbol,Any}()
    d[:head] = ex.head    
    @log "\njulia2dict_do\nd[:head](= ex.head): " d[:head] "==" 
    
    @log "\nexpr.args: " ex.args "=="
    
    @log "exDispatch ex.args: "
    d[:args] = map(x -> exDispatch(x), ex.args)

    # @log "\n得到的 d[:args]: " d[:args]
    @log "\ndict from julia2dict" d "==" 

    return d
end

function exDispatch() end

# exDispatch(ex::Expr) = julia2dict_do(ex)
# exDispatch(ex::LineNumberNode) = Dict{Symbol,Dict{Symbol,Any}}(:LINENUMBERNODE => Dict{Symbol,Any}(:line => ex.line, :file => ex.file))
# exDispatch(ex::QuoteNode) = Dict{Symbol,Symbol}(:QUOTENODE => ex.value)
# exDispatch(ex::String) = Dict{Symbol,String}(:STRING => ex)
# exDispatch(ex::Symbol) = ex
# exDispatch(ex::Number) = ex
# exDispatch(ex::Bool) = ex

function exDispatch(ex::Expr)    
    # @log "Expr" ex 2
    @log "\n@julia2dict ex:" ex "≡≡"
    julia2dict_do(ex)
end

function exDispatch(ex::LineNumberNode)
    dd = Dict{Symbol,Dict{Symbol,Any}}(
        :LINENUMBERNODE => Dict{Symbol,Any}(:line => ex.line, :file => ex.file))

    @log "LineNumberNode" dd "--"    
    return dd
end

function exDispatch(ex::QuoteNode)
    dd = Dict{Symbol,Symbol}(:QUOTENODE => ex.value)
    @log "QuoteNode" dd "--"    
    return dd
end

function exDispatch(ex::String)
    dd = Dict{Symbol,String}(:STRING => ex)
    @log "String" dd "--"
    return dd
end

function exDispatch(ex::Symbol)    
    @log "Symbol" ex "--"
    return ex
end

function exDispatch(ex::Number)    
    @log "Number" ex "--"
    return ex
end

function exDispatch(ex::Bool)    
    @log "Bool" ex "--"
    return ex
end

dictDispatch = Dict{Vector{String},Function}(
    ["STRING"] => (arg) -> arg["STRING"],
    ["head", "args"] => (arg) -> try
        dict2julia(arg)
    catch e
        println("Error: ", e)
        println("At: ", arg)
    end,
    ["QUOTENODE"] => (arg) -> QuoteNode(Symbol(arg["QUOTENODE"])),
    ["LINENUMBERNODE"] => (arg) -> LineNumberNode(arg["LINENUMBERNODE"]["line"], arg["LINENUMBERNODE"]["file"]),
)

function dict2julia(d::Dict)
    @log "\ndict2julia: " "=="
    head = Symbol(d["head"])    
    args = map(d["args"]) do arg
        @log "arg:" arg
        arg isa Dict ? dictDispatch[collect(keys(arg))](arg) : (arg isa String ? Symbol(arg) : arg)
        # @log "\narg mapped:" arg 3
    end
    @log "\nhead from dict2julia: " head "=="
    @log "args from dict2julia: " args

    ex = Expr(head, args...)
    @log "\nexpr from dict2julia: " ex "=="
    # return Expr(head, args...)
    return ex
end

function json2julia(io::AbstractString)
    str = length(io) < 256 && isfile(io) ? read(io, String) : io
    dct = JSON3.read(str, Dict)
    @log "\njson from file: " str "≡≡"
    @log "\ndict from json: " dct "≡≡"
    return dict2julia(dct)
end