# facilita para saber a quantidade de cada categoria
# Exemplo: Masculino e feminino

escolaridade <- c("Fundamental", "Médio", "Superior", "Fundamental", "Médio", "Superior")

escolaridade_fator <- as.factor(escolaridade) # Níveis

summary(escolaridade)

summary(escolaridade_fator) # Quantifica cada nível

table(escolaridade)

tensao_casas <- c(110, 220, 220, 110, 220, 110, 110, 220)

summary(tensao_casas) # Para números aparece vários elementos

tensao_casas_fator <- as.factor(tensao_casas)

summary(tensao_casas_fator) # Quantifica cada nível
