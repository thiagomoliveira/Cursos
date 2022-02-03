### PROJETO 2 ###

### Aula 1 - Tratamento inicial ###

library(dplyr)
library(rstatix)
install.packages("ggplt2")
library(ggplot2)
install.packages("plotly")
library(plotly)


setwd("C:/Users/thiago.oliveira/OneDrive/Área de Trabalho/Estudos/Linguagem R/Tratamento e Análise Gráfica dos Dados no GGPLOT2 e Plotly- Projeto 2")
srag_sp <- read.csv("SRAG_2020.csv", sep = ";")

# Excluindo colunas
srag_sp_mod <- select(srag_sp, -c(51:133))
srag_sp_mod <- select(srag_sp_mod, -c(5:8))

srag_sp_mod <- select(srag_sp_mod, -c(6,8))

glimpse(srag_sp_mod)

srag_sp_mod$DT_NOTIFIC <- as.Date(srag_sp_mod$DT_NOTIFIC, format = "%m/%d/%Y")

# Renomeando colunas
srag_sp_mod <- rename(srag_sp_mod, sexo = CS_SEXO, idade = NU_IDADE_N)

# Verificando valores missing
sapply(srag_sp_mod, function(x) sum(is.na(x)))
sapply(srag_sp_mod, function(x) sum(is.nan(x)))

### Aula 2 - Análise dos dados: Gráfico de barras ###

help("graphics") # Pacote já vem instalado e inicializado

library(help = "graphics")

# Grafico de barras

# Contagem coluna sexo

table(srag_sp_mod$sexo)

barplot(srag_sp_mod$sexo, col="blue")

grafico_barras <- table(srag_sp_mod$sexo)
barplot(grafico_barras, col="yellow", main="QUANTIDADE POR SEXO")
?barplot

# com o GGPLOT 2
ggplot(srag_sp_mod, aes(x=sexo)) +
  geom_bar(fill="red") + labs(title="Quantidade por sexo",
                              subtitle = "SRAG",
                              x = "Sexo", y = "Contagem")

# Grafico por raça

sapply(srag_sp_mod, function(x) sum(is.na(x)))
sapply(srag_sp_mod, function(x) sum(is.nan(x)))
srag_sp_mod$CS_RACA[which(is.na(srag_sp_mod$CS_RAÇA))] <- 9

srag_sp_mod$CS_RACA[srag_sp_mod$CS_RACA == 1] <- "Branca"
srag_sp_mod$CS_RACA[srag_sp_mod$CS_RACA == 2] <- "Preta"
srag_sp_mod$CS_RACA[srag_sp_mod$CS_RACA == 3] <- "Amarela"
srag_sp_mod$CS_RACA[srag_sp_mod$CS_RACA == 4] <- "Parda"
srag_sp_mod$CS_RACA[srag_sp_mod$CS_RACA == 5] <- "Indígena"
srag_sp_mod$CS_RACA[srag_sp_mod$CS_RACA == 9] <- "Ignorado"

# Contagem
grafico_barras = table(srag_sp_mod$CS_RACA)
barplot(grafico_barras, col= "yellow", main="QUANTIDADE POR RAÇA")

ggplot(srag_sp_mod, aes(x=CS_RACA)) +
  geom_bar(fill="blue") + labs(title="Quantidade por raça",
                              subtitle = "SRAG",
                              x = "Raça", y = "Contagem")


### Aula 3 - Análise dos dados: Gráfico de barras ###

sapply(srag_sp_mod, function(x) sum(is.na(x)))
srag_sp_mod$CS_ZONA[which(is.na(srag_sp_mod$CS_ZONA))] <- 9

srag_sp_mod$CS_ZONA[srag_sp_mod$CS_ZONA == 1] <- "Urbana"
srag_sp_mod$CS_ZONA[srag_sp_mod$CS_ZONA == 2] <- "Rural"
srag_sp_mod$CS_ZONA[srag_sp_mod$CS_ZONA == 3] <- "Periurbana"
srag_sp_mod$CS_ZONA[srag_sp_mod$CS_ZONA == 9] <- "Ignorado"

table(srag_sp_mod$CS_ZONA)

ggplot(srag_sp_mod, aes(x = CS_RACA, y = sexo, fill = factor(CS_ZONA))) +
  geom_col(position = "dodge") +
  labs(title = "Região por sexo e raça",
       x = "Raça",
       y = "Sexo",
       fill = "Região")

# Gráfico de barras na horizontal

ggplot(srag_sp_mod, aes(x = CS_RACA, y = sexo, fill = factor(CS_ZONA))) +
  geom_col(position = "dodge") +
  labs(title = "Região por sexo e raça",
       x = "Raça",
       y = "Sexo",
       fill = "Região")+
  coord_flip()

# Gráfico de barras empilhado

grafico <- aggregate(idade ~ sexo + CS_ZONA, data = srag_sp_mod, FUN = mean)

ggplot(grafico, aes(x = CS_ZONA, y = idade, fill = factor(sexo))) +
  geom_col(position = "stack")

# Gráfico com o plotly
srag_sp_mod %>% plot_ly(x = ~ CS_RACA) %>%
                      layout(xaxis = list(title = "Raça"),
                             yaxis = list(title = "Quantidade"))

### Aula 4 - Análise dos dados: Box Plot e outiliers ###

# Boxplot para idade

# Idade
srag_sp_mod$idade[srag_sp_mod$TP_IDADE == 2] <- 0
srag_sp_mod$idade[srag_sp_mod$TP_IDADE == 1] <- 0

summary(srag_sp_mod$idade)
boxplot(srag_sp_mod$idade)

srag_sp_mod %>% identify_outliers(idade)

outliers <- c(boxplot.stats(srag_sp_mod$idade)$out)
srag_atual <- srag_sp_mod[-c(which(srag_sp_mod$idade %in% outliers)), ]

summary(srag_atual$idade)
boxplot(srag_atual$idade)

# Grágico com o GGPLOT2
srag_sp_mod %>% filter(!is.na(idade)) %>%
  ggplot(aes(x = " ", y = idade)) +
  geom_boxplot(width = .3, outlier.color = "purple")

srag_atual %>% filter(!is.na(idade)) %>%
  ggplot(aes(x = " ", y = idade)) +
  geom_boxplot(width = .7, outlier.color = "red")

# Gráfico com Plotly
plot_ly(srag_sp_mod, y = srag_sp_mod$idade,
       type = "box") %>%
      layout(title = "BOXPLOT POR IDADE",
         yaxis = list(title = "Idade"))

### Boxplot coletivo
par(mfrow = c(1,2)) # Gráficos na mesma linha
boxplot(srag_atual$idade, ylab = "Idade sem outliers")
boxplot(srag_sp_mod$idade, ylab = "Idade com outliers")

par(mfrow = c(1,2))
boxplot(idade ~ sexo, srag_atual, ylab = "Idade", xlab = "Sexo")
boxplot(idade ~ CS_RACA, srag_atual, ylab = "Idade", xlab = "Raça")

par(mfrow = c(2,2))
boxplot(idade ~ sexo, srag_atual, ylab = "Idade", xlab = "Sexo")
boxplot(idade ~ CS_RACA, srag_atual, ylab = "Idade", xlab = "Raça")
boxplot(srag_atual$idade, ylab = "Idade sem outliers")
boxplot(idade ~ CS_ZONA , srag_atual, ylab = "Idade", xlab = "Região")

# Com GGPLOT2
ggplot(srag_atual , aes(x = factor(sexo), y = idade)) +
  geom_boxplot(fill = "dodgerblue") +
  labs(y = "Idade",
       x = "Sexo",
       title = "Distribuição das idades por sexo")

# Com plotly

plot_ly(srag_atual, y = srag_atual$idade, color = srag_atual$sexo,
        type = "box") %>%
  layout(title = "BOXPLOT POR IDADE",
         xaxis = list(title = "Sexo"), yaxis = list(title = "Idade"))
