matriz <- matrix(1:36, nrow = 4)

colnames(df)[1] <- "coluna1"

help(rename)

df <- data.frame(matriz)

# apply - aplica uma função a todas linhas ou colunas de uma matriz

help(apply)

apply(df, 1, sum) # 1 para coluna e 2 para linha

apply(df, 1, mean) 

apply(df, 2, sum)

# lapply -> para uma lista ou vetor, aplica uma função para cada elemento
# retorna um objeto da classe list

letters <- c("a", "b","c", "d", "e","f", "g")

lista <- c(df$coluna1)

ll <- lapply(letters, print)
class(ll)
str(ll)

x <- lapply(lista , print)

# tapply -> aplica uma função numa coluna númerica
# individualizando para cada categoria de um fator

# Nesse caso vamos aplicar a função 
# mean na coluna "Sepal.length" para cada
# Categoria da coluna "Species"
# Posso usar várias outras funções***

class(iris$Sepal.Length) # numeric
class(iris$Species) # fator
tm <- tapply(iris$Sepal.Length, iris$Species, FUN = mean)

tm[["setosa"]] # <- posso guardar o valor nessa variável




