## -------------------------------------------------------------------------
## SCRIPT: Practice.R
## CURSO: Master en Big Data y Business Analytics
## ASIGNATURA: Analisis Estadistico
## PROFESOR: Antonio Pita Lozano
## FECHA: 04/12/2016
## ALUMNO: Mark Wellings
## -------------------------------------------------------------------------

##### 1. Setting working directory #####

setwd("C:/Users/Mark/Desktop/Master/ANALISIS ESTADISTICO/Practice")

### Loading and reviewing data set###

house=read.csv("house_train.csv")
head(house)
str(house)
summary(house)

### Effect of square feet on price ###
## Transforming the variables to numeric and integer value##
house$sqft_living = as.integer(house$sqft_living)
house$price = as.numeric(house$price)

price = house$price
livroom = house$sqft_living
#Overview of price and square feet living
head(cbind(house$price, house$sqft_living)) 

#Plotting the data model1#
#Price is the dependent variable 

plot(price, livroom,xlab="HousePrices",ylab="Square feet living room")
abline((lm(livroom ~ price)), col='red') 
#Defining the model#

model1 <- lm(price~livroom)
summary(model1)
model1$coefficients[2]

# This means that when there is one square feet more, that the price increases by 281.959. 

#Correlation#
cor(house$price,house$sqft_living)
#There is a positive correlation


#In order to make a better price prediction we give the commercial agent the possibility to estimate the price by zipcode:

test <- unique(house$zipcode)
test
length(test)
# The commercial agent has to decide for which zipcode he or she wants to estimate the price
#here for example, we want to check for 10th entry in 'test'
i<-c(10)
newmodel<-lm(house$price[house$zipcode==test[i]]~house$sqft_living[house$zipcode==test[i]])
plot(house$price[house$zipcode==test[i]], house$sqft_living[house$zipcode==test[i]],xlab="HousePrices",ylab="Square feet living room", main=paste("For zipcode",  test[[i]], sep=" "))
abline((lm(house$sqft_living[house$zipcode==test[i]] ~ house$price[house$zipcode==test[i]])), col='red') 
summary(newmodel)
# This is the value the price increases when square feet increases by 1. 
newmodel$coefficients[2]


#########################################################################################################################

## Predcit price in dataset house_test

## First of all, we have to find a good model and the respective variables.
## All variables ##

#Id: identificador de la vivienda
#date: fecha asociada a la información 
#price: precio de la vivienda
#bedrooms: número de habitaciones
#bathrooms: número de baños
#sqft_living=superficie de la vivienda (en pies) 
#sqft_lot: superficie de la parcela (en pies)
#floors: número de plantas
#waterfront: indicador de estancia en primera línea al mar
#view: número de orientaciones de la vivienda
#condition: campo desconocido
#grade: campo desconocido
#sqft_above: campo desconocido
#sqft_basement: campo desconocido
#yr_built: año de construcción
#yr_renovated: año de reforma
#zipcode: codigo postal
#lat: latitud
#long: longitud
#sqft_living15: campo desconocido
#sqft_lot15:campo desconocido



## For my model I will use the following variables:

# bedrooms: número de habitaciones
# #sqft_living=superficie de la vivienda (en pies)
# bathrooms: número de baños
# sqft_lot: superficie de la parcela (en pies)
# waterfront: indicador de estancia en primera línea al mar
# view: número de orientaciones de la vivienda
#floors: número de plantas

#Transforming the variables in factors and numeric: 

house=read.csv("house_train.csv")

head(house)
house$bedrooms = as.numeric(house$bedrooms)
house$sqft_living = as.numeric(house$sqft_living)
house$bathrooms = as.numeric(house$bathrooms)
house$sqft_lot = as.numeric(house$sqft_lot)
house$waterfront = as.factor(house$waterfront)
house$view = as.factor(house$view)
house$floors = as.factor(house$floors)
house$price = as.numeric(house$price)

#Creating a model with linear regresion #

model2=lm(price~bedrooms+sqft_living+bathrooms+sqft_lot+waterfront+view+floors,data=house)
summary(model2)
plot(model2$residuals)
hist(model2$residuals)
qqnorm(model2$residuals); qqline(model2$residuals,col=2)

# The residuals are NOT distributed normally. 
# The reason is that price is not distributed normally.
hist(house$price)
# Transforming price with log, achieves normal distribution (requirement for linear regresion)
hist(log(house$price))
#Recreating the model#
model3=lm(log(price)~bedrooms+sqft_living+bathrooms+sqft_lot+waterfront+view+floors,data=house)
summary(model3)
plot(model3$residuals)
hist(model3$residuals)
qqnorm(model3$residuals); qqline(model3$residuals,col=2)
#We can see the model is better

## Now creating the new column with precited values##

house1=read.csv("house_test.csv")
head(house1)
house1$bedrooms = as.numeric(house1$bedrooms)
house1$sqft_living = as.numeric(house1$sqft_living)
house1$bathrooms = as.numeric(house1$bathrooms)
house1$sqft_lot = as.numeric(house1$sqft_lot)
house1$waterfront = as.factor(house1$waterfront)
house1$view = as.factor(house1$view)
house1$floors = as.factor(house1$floors)
house1$price = as.numeric(house1$price)

## Predicting the price using model 2###
a <- list(as.integer(predict(model2, house1)))
house1["price-model2"] <- a
head(house1)
## Predicting the price using model 3###
b <- c(as.integer(predict(model3, house1)))
#Transforming variable b (inverse log)
b<-exp(1)^b
house1["price-model3"] <- b
head(house1)
#Saving the new csv file##
write.csv(house1, file = "house_with_predicted_price.csv")
#Two new columns created, one for each model and its predicted price




