### DATA FRAMES ###

mes_numero <- c(1,2,3,4,5,6,7,8)
mes_nome <- c("jan", 'fev','mar','abr','mai','jun','jul','ago')

ano <- c(2021,2021,2021,2021,2021,2021,2021,2021 )

df_meses <- data.frame(mes_numero,mes_nome, ano)

# Data Frames pertencentes ao R (pacote datasets)

df <- mtcars
df2 <- airquality
View(df)
nrow(df)
ncol(df)
summary(df)

### LISTAS ###
# Podem conter elementos de diferentes tipos (tipo especial de vetor)

nome <- c("Luciano", "Pedro", "Joyce", "Maria")
idade <- c(46, 30, 23, 54)
curso <- c("Física", "Engenharia", "Matemática", "Biologia")
lista <- list(nome, idade, curso)
print(lista)

# Encontrando objeto da lista

lista[1]

# Nomeando termos da lista

lista2 <- list(nome = c("Thiago", "Bruno"),
               idade = c(27,28),
               curso = c("ENG", "ADS"))