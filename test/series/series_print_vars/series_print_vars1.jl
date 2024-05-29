s = Dict{Symbol, Any}(

    :components => Any[
        (:if, :flag, Vector{Union{Expr, Symbol}}[[:sys1, :C]], 
        Vector{Union{Expr, Symbol}}[[:sys2, :C]]),
        (:if, :flag2, Vector{Union{Expr, Symbol}}[[:sys3, :C]], 
        Vector{Union{Expr, Symbol}}[[:sys4, :C]])],
       


    :variables => Dict{Symbol, Dict{Symbol, Any}}(        
        :R => Dict(
            :type => Real
        )
    ), 

    :kwargs => Dict{Symbol, Dict}(

        :a => Dict{Symbol, Union{Nothing, DataType}}(
            :value => nothing, 
            :type => Real
        ),

        :R => Dict{Symbol, Union{Nothing, DataType}}(
            :value => nothing, 
            :type => Real
        ),

        :flag => Dict{Symbol, Bool}(
            :value => 1
        )
    ), 

    :structural_parameters => Dict{Symbol, Dict}(
        :flag => Dict{Symbol, Bool}(
            :value => 1
        )
    ),

    :independent_variable => :t, 

    :parameters => Dict{Symbol, Dict{Symbol, Any}}(

        :a => Dict(
            :type => Real
        ),

        :a2 => Dict(
            :type => AbstractArray{Real}, 
            :condition => 
                (   :if, :flag,

                    Dict{Symbol, Any}(
                        :kwargs => Dict{Any, Any}(
                            :a1 => Dict{Symbol, Union{Nothing, DataType}}(
                                :value => nothing, 
                                :type => Real
                            )
                        ), 

                        :parameters => Any[
                            Dict{Symbol, Dict{Symbol, Any}}(
                                :a1 => Dict(
                                    :type => AbstractArray{Real})
                            )
                        ]
                    ),

                    Dict{Symbol, Any}(
                    :variables => Any[
                        Dict{Symbol, Dict{Symbol, Any}}()
                    ],

                    :kwargs => Dict{Any, Any}(
                        :a2 => Dict{Symbol, Union{Nothing, DataType}}(
                            :value => nothing, 
                            :type => Real
                        )
                    ),

                    :parameters => Any[
                        Dict{Symbol, Dict{Symbol, Any}}(
                            :a2 => Dict(
                                :type => AbstractArray{Real}
                            )
                        )
                    ]
                    )
                )
        ), 

        :a1 => Dict(
            :type => AbstractArray{Real}, 
            :condition => 
                (   :if, :flag,

                    Dict{Symbol, Any}(
                        :kwargs => Dict{Any, Any}(
                            :a1 => Dict{Symbol, Union{Nothing, DataType}}(
                                :value => nothing, 
                                :type => Real
                            )
                        ), 
                        :parameters => Any[
                            Dict{Symbol, Dict{Symbol, Any}}(
                                :a1 => Dict(
                                    :type => AbstractArray{Real}
                                )
                            )
                        ]),

                    Dict{Symbol, Any}(                            
                        :variables => Any[
                            Dict{Symbol, Dict{Symbol, Any}}()
                        ],

                        :kwargs => Dict{Any, Any}(
                            :a2 => Dict{Symbol, Union{Nothing, DataType}}(
                                :value => nothing, 
                                :type => Real
                            )
                        ), 

                        :parameters => Any[
                            Dict{Symbol, Dict{Symbol, Any}}(
                                :a2 => Dict(
                                    :type => AbstractArray{Real}
                                )
                            )
                        ]
                    )
                )
        )
    ), 

    :equations => Any["D(R) ~ 3"]

)