library(GJRM) 

load("dataInfections.RData")  

table(dati$cens)
#   R   I   U 
# 573  96   9 

# baseline model 

eq  <- list(u1 ~ s(u1, bs = "mpi") + s(MELD))
eq2 <- list(u1 ~ s(log(u1), bs = "mpi") +  s(MELD))

ga=gamlss(eq, data = dati, surv = TRUE, margin = "PH", 
          cens = cens, type.cens = "mixed", upperB = "u2")
ga2=gamlss(eq2, data = dati, surv = TRUE, margin = "PH", 
           cens = cens, type.cens = "mixed", upperB = "u2")

BIC(ga)
BIC(ga2)

## Reproducing upper panels of Figure 2 
plot(ga2, eq = 1, scale = 0, pages = 1, all.terms = TRUE)


## other predictors

X=dati[,4:10]

res=data.frame(var=names(X),coef=NA,se=NA,p=NA)
for(j in 1:ncol(X)) {
eq <- as.formula(paste("u1 ~ s(log(u1), bs = 'mpi') + s(MELD) +",names(X)[j],sep=""))
ga <- gamlss(list(eq), data=dati, surv = TRUE, margin = "PH", 
              cens = cens, type.cens = "mixed", upperB = "u2")
res[j,-1]=round(summary(ga)$tableP1[2,c(1,2,4)],3)
res[j,1]=names(X)[j]}

library(xtable)
# Reproducing left panel of Table 2 
xtable(res,digits=3)


eq2 <- list(u1 ~ s(log(u1), bs = "mpi") +paracenthesis+ bed + catether + s(MELD))
out2 <- gamlss(eq2, data = dati, surv = TRUE, margin = "PH", 
              cens = cens, type.cens = "mixed", upperB = "u2")


conv.check(out2)
BIC(out2)

# AIC and BIC support out2

# right panel of Table 2
summary(out2)

# lower plots of Figure 2 
plot(out2, eq = 1, scale = 0, pages = 1, all.terms = TRUE)

nd <- data.frame(catether = 1, MELD = 15, bed = 0, paracenthesis=0) 

## Figure 3
hazsurv.plot(out2, newdata = nd, shade = TRUE, n.sim = 1000, type = "hazard", ls = 200, t.range=c(0.1,30))

BIC(gamlss(eq2, data = dati, surv = TRUE, margin = "PO", 
           cens = cens, type.cens = "mixed", upperB = "u2"))


BIC(gamlss(eq2, data = dati, surv = TRUE, margin = "probit", 
           cens = cens, type.cens = "mixed", upperB = "u2"))




