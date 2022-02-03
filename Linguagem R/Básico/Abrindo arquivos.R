setwd("C:/Users/thiago.oliveira/OneDrive/Área de Trabalho/Arquivos")

# Arquivo TXT

df1 <- read.table("arquivo.txt")
df1

# Arquivo CSV

df2 <- read.csv("mola.csv")
df2

df3 <- read.csv("questoes.csv")

df3 <- read.csv("questoes.csv", encoding="latin-1")

df3 <- read.csv("questoes.csv", encoding="iso-8859-1")

df3 <- read.csv("questoes.csv", encoding="UTF-8")


install.packages("readxl")
library(readxl)

df4 <- read_xlsx('registro.xlsx')

df5 <- read_excel("registro.xlsx")
