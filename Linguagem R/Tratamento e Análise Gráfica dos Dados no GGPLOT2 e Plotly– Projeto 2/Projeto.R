### PROJETO 2 ###

### Tratamento inicial ###

library(dplyr)
library(rstatix)
install.packages("ggplt2")
library(ggplot2)
install.packages("plotly")
library(plotly)


setwd("C:/Users/thiago.oliveira/OneDrive/�rea de Trabalho/Estudos/Linguagem R/Tratamento e An�lise Gr�fica dos Dados no GGPLOT2 e Plotly- Projeto 2")
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

### An�lise dos dados: Gr�fico de barras ###

help("graphics") # Pacote j� vem instalado e inicializado

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

# Grafico por ra�a

sapply(srag_sp_mod, function(x) sum(is.na(x)))
sapply(srag_sp_mod, function(x) sum(is.nan(x)))
srag_sp_mod$CS_RACA[which(is.na(srag_sp_mod$CS_RA�A))] <- 9

srag_sp_mod$CS_RACA[srag_sp_mod$CS_RACA == 1] <- "Branca"
srag_sp_mod$CS_RACA[srag_sp_mod$CS_RACA == 2] <- "Preta"
srag_sp_mod$CS_RACA[srag_sp_mod$CS_RACA == 3] <- "Amarela"
srag_sp_mod$CS_RACA[srag_sp_mod$CS_RACA == 4] <- "Parda"
srag_sp_mod$CS_RACA[srag_sp_mod$CS_RACA == 5] <- "Ind�gena"
srag_sp_mod$CS_RACA[srag_sp_mod$CS_RACA == 9] <- "Ignorado"

# Contagem
grafico_barras = table(srag_sp_mod$CS_RACA)
barplot(grafico_barras, col= "yellow", main="QUANTIDADE POR RA�A")

ggplot(srag_sp_mod, aes(x=CS_RACA)) +
  geom_bar(fill="blue") + labs(title="Quantidade por ra�a",
                              subtitle = "SRAG",
                              x = "Ra�a", y = "Contagem")


### An�lise dos dados: Gr�fico de barras ###

sapply(srag_sp_mod, function(x) sum(is.na(x)))
srag_sp_mod$CS_ZONA[which(is.na(srag_sp_mod$CS_ZONA))] <- 9

srag_sp_mod$CS_ZONA[srag_sp_mod$CS_ZONA == 1] <- "Urbana"
srag_sp_mod$CS_ZONA[srag_sp_mod$CS_ZONA == 2] <- "Rural"
srag_sp_mod$CS_ZONA[srag_sp_mod$CS_ZONA == 3] <- "Periurbana"
srag_sp_mod$CS_ZONA[srag_sp_mod$CS_ZONA == 9] <- "Ignorado"

table(srag_sp_mod$CS_ZONA)

ggplot(srag_sp_mod, aes(x = CS_RACA, y = sexo, fill = factor(CS_ZONA))) +
  geom_col(position = "dodge") +
  labs(title = "Regi�o por sexo e ra�a",
       x = "Ra�a",
       y = "Sexo",
       fill = "Regi�o")

# Gr�fico de barras na horizontal

ggplot(srag_sp_mod, aes(x = CS_RACA, y = sexo, fill = factor(CS_ZONA))) +
  geom_col(position = "dodge") +
  labs(title = "Regi�o por sexo e ra�a",
       x = "Ra�a",
       y = "Sexo",
       fill = "Regi�o")+
  coord_flip()

# Gr�fico de barras empilhado

grafico <- aggregate(idade ~ sexo + CS_ZONA, data = srag_sp_mod, FUN = mean)

ggplot(grafico, aes(x = CS_ZONA, y = idade, fill = factor(sexo))) +
  geom_col(position = "stack")

# Gr�fico com o plotly
srag_sp_mod %>% plot_ly(x = ~ CS_RACA) %>%
                      layout(xaxis = list(title = "Ra�a"),
                             yaxis = list(title = "Quantidade"))

### An�lise dos dados: Box Plot e outiliers ###

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

# Gr�gico com o GGPLOT2
srag_sp_mod %>% filter(!is.na(idade)) %>%
  ggplot(aes(x = " ", y = idade)) +
  geom_boxplot(width = .3, outlier.color = "purple")

srag_atual %>% filter(!is.na(idade)) %>%
  ggplot(aes(x = " ", y = idade)) +
  geom_boxplot(width = .7, outlier.color = "red")

# Gr�fico com Plotly
plot_ly(srag_sp_mod, y = srag_sp_mod$idade,
       type = "box") %>%
      layout(title = "BOXPLOT POR IDADE",
         yaxis = list(title = "Idade"))

### Boxplot coletivo
par(mfrow = c(1,2)) # Gr�ficos na mesma linha
boxplot(srag_atual$idade, ylab = "Idade sem outliers")
boxplot(srag_sp_mod$idade, ylab = "Idade com outliers")

par(mfrow = c(1,2))
boxplot(idade ~ sexo, srag_atual, ylab = "Idade", xlab = "Sexo")
boxplot(idade ~ CS_RACA, srag_atual, ylab = "Idade", xlab = "Ra�a")

par(mfrow = c(2,2))
boxplot(idade ~ sexo, srag_atual, ylab = "Idade", xlab = "Sexo")
boxplot(idade ~ CS_RACA, srag_atual, ylab = "Idade", xlab = "Ra�a")
boxplot(srag_atual$idade, ylab = "Idade sem outliers")
boxplot(idade ~ CS_ZONA , srag_atual, ylab = "Idade", xlab = "Regi�o")

# Com GGPLOT2
ggplot(srag_atual , aes(x = factor(sexo), y = idade)) +
  geom_boxplot(fill = "dodgerblue") +
  labs(y = "Idade",
       x = "Sexo",
       title = "Distribui��o das idades por sexo")

# Com plotly

plot_ly(srag_atual, y = srag_atual$idade, color = srag_atual$sexo,
        type = "box") %>%
  layout(title = "BOXPLOT POR IDADE",
         xaxis = list(title = "Sexo"), yaxis = list(title = "Idade"))

### An�lise Estat�stica: Histograma, estat�stica descritiva e normalidade ###

# Histograma para idade

hist(srag_atual$idade, col = "blue", main = "SRAG POR IDADE",
     xlab = "Distribui��o das idades" , ylab = "Frequ�ncia")

hist(srag_atual$idade, probability = T, col = "brown")
lines(density(srag_atual$idade), col = "orange")

## QQPLOT (GR�FICO DE DISTRIBUI��O NORMAL)
qqnorm(srag_atual$idade, col = "gray")
qqline(srag_atual$idade, col = "red")

library(nortest)

# Teste de normalidade Shapiro-Wilk
shapiro.test(srag_atual$idade) #n�o vai rodar pelo tamanho da tabela

# Anderson-Darling
ad.test(srag_atual$idade)

# Distribui��o n�o � normal

# HISTOGRAMA COM GG PLOT
ggplot(data = srag_atual, aes(x = idade)) +
  geom_histogram(fill = "red", bins = 25) + labs(title = "Histograma da idade",
                                                 subtitle = "SRAG",
                                                 x = "Idade", y = "Contagem")


# HISTOGRAMA COM PLOTLY

plot_ly(x = srag_atual$idade, type = "histogram") %>%
  layout(title="HISTOGRAMA POR IDADE",
         xaxix = list(title = "idade"), yaxis = list(title="Quantidade"))

### An�lise dos dados: Gr�fico de dispers�o e bolhas ###

# Graficos de dispers�o
plot(srag_atual$DT_NOTIFIC, srag_atual$idade,
     title("Casos de SRAG por m�s e por idade"), col= "purple")

scatter.smooth(srag_atual$DT_NOTIFIC, srag_atual$idade)

# Gr�fico de dispers�o no ggplot (2 vari�veis)
ggplot(srag_atual, aes(x = DT_NOTIFIC, y = idade)) +
  geom_point()+
  labs(title = 'Rela��o data de nitifica��o e idade',
       x = "Data de notifica��o",
       y = "Idade")

# Gr�fico de dispers�o no ggplot (4 vari�veis)
srag_atual_camp <- srag_atual %>% filter(ID_MN_RESI == "CAMPINAS")

ggplot(srag_atual_camp, aes(x = DT_NOTIFIC, y = idade,
                            color = CS_RACA, shape = sexo)) +
  geom_point() +
  labs(title = "Rela��o entre data de notifica��o, idade e sexo",
       x = "Data de notifica��o",
       y = "Idade")

# Gr�fico de dispers�o no plotly (3 vari�veis)
plot_ly(x = srag_atual_camp$DT_NOTIFIC, y = srag_atual_camp$idade, type= "scatter",
        mode = "markers", color = srag_atual_camp$sexo)

# Gr�fico de bolhas com ggplot
srag_atual_tupa <- srag_atual %>% filter(ID_MN_RESI == "TUPA")
ggplot(srag_atual_tupa, aes(x = DT_NOTIFIC, y = CS_ZONA,
                            size = idade))+
  geom_point() +
  labs(title = "Rela��o entre data e regi�o por idade",
       x = "Data de notifica��o",
       y = "Regi�o")

# Gr�fico de bolhas com plotly
plot_ly(x = srag_atual_camp$DT_NOTIFIC, y = srag_atual_camp$CS_ZONA, type = "scatter",
        mode = "markers", size = srag_atual_camp$idade)

# An�lise dos dados: Gr�fico de setores (pizza)

table(srag_atual_camp$sexo)
pie(table(srag_atual_camp$sexo), col=c("red", "blue"), radius= 2)

glimpse(srag_atual_camp)
srag_atual_camp$sexo <- as.factor(srag_atual_camp$sexo)

contagem <- table(srag_atual_camp$sexo)
nomes <- levels(srag_atual_camp$sexo)
porcentagem <- round(contagem/sum(contagem)*100, 2)
rotulo <- paste(nomes, " (", porcentagem, "%", ")", sep = " ")
pie(table(srag_atual_camp$sexo), labels = rotulo, main = "SEXO",
    col = c("red", "blue"), radius = 2)

# Gr�fico de setores com GGPLOT

grafico_pizza <- ggplot(srag_atual_camp, aes(x=" ", fill = sexo))+
  geom_bar(width = 1)+
  coord_polar("y")
grafico_pizza + theme(plot.background = element_rect(fill="grey", colour = "red"))

grafico <- data.frame(
  grupo = c("Masculino", "Feminino"),
  valores = c(1311, 1041))
soma = sum(table(srag_atual_camp$sexo))
  
grafico %>%
  ggplot(aes(x = "", y = valores, fill = grupo)) +
  geom_col() +
  geom_text(aes(label = percent(valores/soma, accuracy = 0.1)), position = position_stack(vjust = 0.5)) +
  scale_fill_brewer(palette = "Reds") +
  coord_polar("y") +
  theme_void() +
  labs(title = "QUANTIDADE POR SEXO",
       fill = "LEGENDA")

install.packages("scales")
library(scales)

# Gr�fico de setores com Plotly
plot_ly(srag_atual_camp, labels = ~ sexo, type = "pie")
plot_ly(srag_atual_camp, labels = ~ CS_RACA, type = "pie")
plot_ly(srag_atual_camp, labels = ~ CS_ZONA, type = "pie")


# Distribui��o de Frequ�ncias ###

install.packages("sampling")
install.packages("TeachingSampling")
library(sampling)
library(TeachingSampling)

# Tabela de Frequ�ncias absolutas
freq_abs <- table(srag_atual$idade)
View(freq_abs)

# Tabela de Rrequ�ncias relativas
freq_rel <- prop.table(freq_abs)
View(freq_rel)

# Porcentagem da Frequ�ncia relativa
p_freq_rel <- 100*prop.table(freq_rel)
View(p_freq_rel)

# Criar linha com o total
freq_abs <- c(freq_abs, sum(freq_abs))
View(freq_abs)
names(freq_abs)[112] <- "Total"

# Juntando a Frequ�ncia relativa com a frequ�ncia percentual com as suas respectivas somas
freq_rel <- c(freq_rel, sum(freq_rel))
p_freq_rel <- c(p_freq_rel, sum(p_freq_rel))

# Tabela final com todos os valores
tabela_final <- cbind(freq_abs,
                      freq_rel = round(freq_rel, digits = 5),
                      p_freq_rel = round(p_freq_rel, digits = 2))

View(tabela_final)

# Construindo classes de frequ�ncias
intervalos_classes <- seq(0, 120,10)
View(intervalos_classes)
tabela_classes <- table(cut(srag_atual$idade, breaks = intervalos_classes, right = FALSE))
View(tabela_classes)

# Gr�ficos de frequ�ncia

# Histograma 
hist(srag_atual$idade, col = "red")

df1 <- as.data.frame(tabela_classes)

df1 %>% plot_ly(x = ~Var1, y = ~Freq) %>%
  layout(xaxis = list(title = "Intervalo de idades"),
         yaxis = list(title = "Quantidade"))

# Poligono de frequ�ncia
plot(tabela_classes, type = 'o')
?plot

# Gr�fico de Ogiva
freq_rel_classes <- prop.table(table(cut(srag_atual$idade,
                                         breaks = c(intervalos_classes))))
View(freq_rel_classes)
freq_acum <- cumsum(tabela_classes)[seq_along(intervalos_classes)]
View(freq_acum)

# Gr�fico
plot(intervalos_classes, freq_acum, type = 'o')

# Gr�fico de Ogiva
df <- as.data.frame(freq_acum)

ggplot(df, aes(x = intervalos_classes, y = freq_acum)) +
  geom_line() +
  geom_point() +
  labs(title = "GR�FICO DE OGIVA: FREQU�NCIA ACUMULADA POR CLASSES DE IDADE",
       y = "idade",
       y = "Frequ�ncia acumulada de SRAG",
       color = "Meses") +
  theme_gray()
