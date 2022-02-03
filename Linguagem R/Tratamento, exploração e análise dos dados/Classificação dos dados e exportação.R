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

covid_sp <- read.csv2('dados_covid_sp.csv', sep = ";", encoding = "UTF-8")


# visualizando a tabela
View(covid_sp)
head(covid_sp)

# mudando o nome das colunas por nome

covid_sp_alterado <- rename(covid_sp, municipio = nome_munic)
covid_sp_alterado <- rename(covid_sp, data = datahora,municipio = nome_munic,
                            rotulo_mapa = map_leg, codigo_mapa = map_leg_s)


# Mudar o nome da coluna por número da mesma

colnames(covid_sp_alterado)[1] <- "coluna1" 

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



#### Aula começa aqui ####

# Verificação da tipagem das variáveis 

str(covid_sp_alterado22)

glimpse(covid_sp_alterado2)

#Transformando a tipagem das variáveis

covid_sp_alterado2$semana_epidem <- as.integer(covid_sp_alterado2$semana_epidem)

covid_sp_alterado2$data <- as.Date(covid_sp_alterado2$data, format = '%Y-%m-%d')

# Criação de colunas

covid_sp_alterado2["idoso(%)"] <- 100*covid_sp_alterado2$pop_60 / 
  covid_sp_alterado2$pop

# Exportação de arquivos

write.table(covid_sp_alterado2, file ="covid_sp_tratado.csv", sep=",")
