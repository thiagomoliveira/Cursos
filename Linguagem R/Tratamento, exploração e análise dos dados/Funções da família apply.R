matriz <- matrix(1:36, nrow = 4)

colnames(df)[1] <- "coluna1"

help(rename)

df <- data.frame(matriz)

# apply - aplica uma fun��o a todas linhas ou colunas de uma matriz

help(apply)

apply(df, 1, sum) # 1 para coluna e 2 para linha

apply(df, 1, mean) 

apply(df, 2, sum)

# lapply -> para uma lista ou vetor, aplica uma fun��o para cada elemento
# retorna um objeto da classe list

letters <- c("a", "b","c", "d", "e","f", "g")

lista <- c(df$coluna1)

ll <- lapply(letters, print)
class(ll)
str(ll)

x <- lapply(lista , print)

# tapply -> aplica uma fun��o numa coluna n�merica
# individualizando para cada categoria de um fator

# Nesse caso vamos aplicar a fun��o 
# mean na coluna "Sepal.length" para cada
# Categoria da coluna "Species"
# Posso usar v�rias outras fun��es***

class(iris$Sepal.Length) # numeric
class(iris$Species) # fator
tm <- tapply(iris$Sepal.Length, iris$Species, FUN = mean)

tm[["setosa"]] # <- posso guardar o valor nessa vari�vel




