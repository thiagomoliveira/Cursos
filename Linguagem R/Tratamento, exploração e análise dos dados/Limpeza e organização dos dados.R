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

#### AULA COMEÇA AQUI!! ####

# visualizando a tabela
View(covid_sp)
head(covid_sp)

# mudando o nome das colunas

covid_sp_alterado <- rename(covid_sp, municipio = nome_munic)
covid_sp_alterado <- rename(covid_sp, data = datahora,municipio = nome_munic,
                            rotulo_mapa = map_leg, codigo_mapa = map_leg_s)

# excluindo uma coluna por nome

covid_sp_alterado$cod_ra <- NULL

# excluindo uma coluna por número

covid_sp_alterado <- select(covid_sp_alterado, -c(21)) # recebe o dataframe, exceto 21

# excluir várias colunas por nome

covid_sp_alterado <- subset(covid_sp_alterado, select = -c(codigo_ibge, cod_drs))

# excluir várias colunas por número

covid_sp_alterado <- select(covid_sp_alterado,-c(14, 15))
covid_sp_alterado <- select(covid_sp_alterado, -c(17: 19))

# excluindo uma linha por número

covid_sp_alterado <- slice(covid_sp_alterado, -c(239660))
covid_sp_alterado <- slice(covid_sp_alterado, -c(239661:239666))

# Excluir várias linhas por nome

covid_sp_alterado <- covid_sp_alterado %>% filter(municipio != "Ignorado") 



