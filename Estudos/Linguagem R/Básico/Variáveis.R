#Tipos de variável
y <- 2 # numeric (posso passar pra int)
logica <- TRUE # boolean
genero <- c('Masculino' , 'Feminino') #concatenado 

#Descobrindo o ipo da variável
mode(y) 
class(y)

#Transformando os tipos de variáveis
y = as.integer(y)
genero <- as.factor(genero)

#Extra (posso usar o length para contar objetos, quantidade de itens dentro de aspas, quantos fatores, etc)
comprimento <- length(genero) 
