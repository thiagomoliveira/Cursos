v1 <- 720
v2 <- 850
g <- 70
loc1 <- g
loc2 <- 0
dif_vel <- v2 - v1
if (dif_vel <= 0){
  return(NULL)
}
while (loc1 >= loc2){
  dif_dist <- loc1 - loc2
  if (dif_dist - dif_vel >= 0){
    hora = hora + 1
    loc1 <- loc1 + v1
    loc2 <- loc2 + v2
  }
}
 print(hora)