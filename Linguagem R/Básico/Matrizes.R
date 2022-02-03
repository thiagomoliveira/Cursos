# Conjunto com linhas e colunas
# COntém somente numeros ou somente caracteres

?matrix # Vai para o help

matrizA <- matrix(c(1, 10, 20, 30, 12, 34, 9, 23), 
                 nrow = 3, ncol = 2, byrow = TRUE)
# se o byrow for TRUE, o R irá preencher os valores por linha

print(matriz)

matriz [2,2]

vetorA <- c(2, 5, 9)

vetorB <- c(23,12,44)

matrizB <- rbind(vetorA, vetorB) 

# rbind e bind_rows() - a diferença é que o segundo preenche espaços vazios com NA

matrizC = matrix(2:9, ncol = 2)

ncol(matrizC)

nrow(matrizC)

dimnames(matrizC) <- list(c("Linha1", "Linha2","Linha3","Linha4"),
                c("coluna1", "coluna2"))

# dimnames nomeia colunas e linhas

matrizD = matrix(2:13, nrow = 4, byrow = TRUE,
                 dimnames = list(c("Linha1", "Linha2","Linha3","Linha4"),
                                 c("coluna1", "coluna2", "coluna3")))

produto <- 2 * matrizD #multiplica todos valores da matriz

matrizE = matrix(c(3,5,10,20), nrow=2, ncol=2, byrow=TRUE)

matrizF = matrix(c(14,12,22,50), nrow=2, ncol=2, byrow=TRUE)

soma = matrizE + matrizF 
# Consigo fazer operações para cada elemento da matriz
# As matrizes devem conter a mesma qtde de linhas e colunas

produto_matriz = matrizE %*% matrizF


media_coluna = colMeans(matrizE)

media_linha = rowMeans(matrizE)

soma_linhas = rowSums(matrizE)

soma_colunas = colSums(matrizE)

matrizG = matrix(c("Segunda", 'terça', 'quarta', 'quinta'), nrow = 2, ncol = 2, byrow = TRUE)


