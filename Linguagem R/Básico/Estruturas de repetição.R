for (i in 1:10){
  print(i)
}

lista <- c(1,2,0, 10)
for(numero in lista){
  mult = numero*2
  print(mult)
}

c <- 1
while (c<10){
  print(c)
  c <- c+2
}

x <- 2
repeat { #  estrutura de repetição
  print(x)
  x <- x+1
  if(x>=10) break #  condição para o final
} 
