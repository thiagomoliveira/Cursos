#Reposit�rios de dados:
# INEP, Google dataset Search, 
# Portal brasileiro de dados abertos, 
# Kaggle, UCI Machine Learning Repository,
# OMS, Paho, DrivenData, SEADE, etc

# carregar pacote
if(!require(dplyr)) install.packages("dplyr")
library(dplyr)

# Abrir pasta
setwd("C:/Users/thiago.oliveira/OneDrive/�rea de Trabalho/Estudos/Linguagem R/Tratamento, explora��o e an�lise dos dados/dados-covid-sp-master/data")

#Abrir arquivo
covid_sp <- read.csv("dados_covid_sp.csv", sep = ";") # Erro de acentua��o, corre��o abaixo (Encoding)
View(covid_sp)

covid_sp <- read.csv2('dados_covid_sp.csv', sep = ";", encoding = "UTF-8")

#### AULA COME�A AQUI!! ####

# visualizando a tabela

View(covid_sp)
head(covid_sp)

# mudando o nome das colunas

covid_sp_alterado <- rename(covid_sp, municipio = nome_munic)
covid_sp_alterado <- rename(covid_sp, data = datahora,municipio = nome_munic,
                            rotulo_mapa = map_leg, codigo_mapa = map_leg_s)

# excluindo uma coluna por nome

covid_sp_alterado$cod_ra <- NULL

# excluindo uma coluna por n�mero

covid_sp_alterado <- select(covid_sp_alterado, -c(21)) # recebe o dataframe, exceto 21

# excluir v�rias colunas por nome

covid_sp_alterado <- subset(covid_sp_alterado, select = -c(codigo_ibge, cod_drs))

# excluir v�rias colunas por n�mero

covid_sp_alterado <- select(covid_sp_alterado,-c(14, 15))
covid_sp_alterado <- select(covid_sp_alterado, -c(17: 19))

# excluindo uma linha por n�mero

covid_sp_alterado <- slice(covid_sp_alterado, -c(239660))
covid_sp_alterado <- slice(covid_sp_alterado, -c(239661:239666))

# Excluir v�rias linhas por nome

covid_sp_alterado <- covid_sp_alterado %>% filter(municipio != "Ignorado")

#### AULA COME�A AQUI!! ####

sapply(covid_sp_alterado, function(x) sum(is.na(x)))
sapply(covid_sp_alterado, function(x) sum(is.nan(x)))

# Substituir valores missing

library(tidyr)

covid_sp_alterado2 <- covid_sp_alterado %>% mutate_all(replace_na, 54)

# Ou

covid_sp_alterado2 <- replace(x = covid_sp_alterado, list = is.na(covid_sp_alterado),
                              values = 54)


covid_sp_alterado2$semana_epidem[covid_sp_alterado2$semana_epidem == 54] <- 2021

covid_sp_alterado2$semana_epidem[covid_sp_alterado2$data >= '2021-01-01' &
                                   covid_sp_alterado2$data <= '2021-01-07'] <- 54

covid_sp_alterado2$semana_epidem[covid_sp_alterado2$data >= '2021-01-08' &
                                   covid_sp_alterado2$data <= '2021-01-14'] <- 55
