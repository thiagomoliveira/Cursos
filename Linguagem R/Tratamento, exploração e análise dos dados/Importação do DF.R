#Repositórios de dados:
# INEP, Google dataset Search, 
# Portal brasileiro de dados abertos, 
# Kaggle, UCI Machine Learning Repository,
# OMS, Paho, DrivenData, SEADE, etc

# carregar pacote
if(!require(dplyr)) install.packages("dplyr")
library(dplyr)

# Abrir pasta
setwd("C:/Users/thiago.oliveira/OneDrive/Área de Trabalho/Estudos/Linguagem R/Tratamento, exploração e análise dos dados/dados-covid-sp-master/data")

#Abrir arquivo
covid_sp <- read.csv("dados_covid_sp.csv", sep = ";") # Erro de acentuação, correção abaixo (Encoding)
View(covid_sp)

covid_sp_alterado <- read.csv2('dados_covid_sp.csv', sep = ";", encoding = "UTF-8")