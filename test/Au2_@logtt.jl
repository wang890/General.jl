using General.Aux

arr1 = [1, 5, 7]
arr2 = [10, 50]
arr3 = [300, 400]

re = r"^\s*(?:#|$)"

occursin(r"^\s*(?:#|$)", "not a comment")


a = 7

@log "" arr1 arr2 re typeof(re)  typeof(arr2)

b = 16
c= ["hello", false]

println(arr1,arr2,re,b,c,r"^\s*(?:#|$)")

d=9

@info arr1 arr2 re b c r"^\s*(?:#|$)" occursin(r"^\s*(?:#|$)", "not a comment") = ["hello", false]

e = 11

@logtt arr1 arr2 "--"
# logt接收到的表达式 和 类型
# (:arr1, :arr2, "--")
# Tuple{Symbol, Symbol, String}

f = 12

@logtt arr1 arr2 "hello", re, "--"
# logt接收到的表达式 和 类型
# (:arr1, :arr2, :(("hello", re, "--")))
# Tuple{Symbol, Symbol, Expr}

g = 13

@logtt arr1 arr2 re b c r"^\s*(?:#|$)" occursin(r"^\s*(?:#|$)", "not a comment") = ["hello", false] "≡≡"

h = 14

# @logtt失败
# ≡≡ ≡≡ ≡≡ ≡≡ ≡≡ ≡≡ ≡≡ 
# Symbol, Symbol, Symbol, Symbol, Symbol, Expr, Expr

# 若eval再Typeof: UndefVarError: `arr1` not defined

i = 10
